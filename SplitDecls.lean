/-
SplitDecls.lean — Split mathlib into one-file-per-declaration lattice

Uses the Lean4 kernel Environment API to:
1. Load an environment (via import)
2. Extract every declaration and its exact dependencies
3. Emit one .lean file per declaration
4. Generate a flake.nix for each declaration in the lattice

This gives exact dependency tracking (not regex) and enables:
- Minimal recompilation: change one decl → rebuild only its dependents
- Parallel builds: independent branches compile in parallel
- Cherry-pick imports: import Decls.HVertexOperator pulls only what's needed

Usage:
  lake env lean SplitDecls.lean -- Mathlib.Algebra.Vertex.HVertexOperator ./out
-/
import Lean

open Lean System

/-- Collect all constant names referenced in an expression -/
def collectRefs (e : Expr) : NameSet :=
  e.foldConsts {} fun n s => s.insert n

/-- Get all dependencies of a constant (from type + value) -/
def constDeps (env : Environment) (n : Name) : NameSet :=
  match env.find? n with
  | some ci =>
    let fromType := collectRefs ci.type
    let fromVal := match ci with
      | .defnInfo v => collectRefs v.value
      | .thmInfo v  => collectRefs v.value
      | .opaqueInfo v => collectRefs v.value
      | _ => {}
    fromType.union fromVal
  | none => {}

/-- Filter to only names that are in our target set -/
def filterDeps (deps : NameSet) (targets : NameSet) : Array Name := Id.run do
  let mut result : Array Name := #[]
  for n in deps.toList do
    if targets.contains n then result := result.push n
  return result

/-- Sanitize a Lean name into a valid filename component -/
def nameToFile (n : Name) : String :=
  n.toString.replace "." "/" ++ ".lean"

/-- Sanitize a Lean name into a module name for imports -/
def nameToSimpleMod (n : Name) : String :=
  "Split." ++ n.toString.replace "." "_"

/-- BFS closure from a root name -/
def bfsClosure (env : Environment) (root : Name) (universeSet : NameSet) : NameSet := Id.run do
  let mut visited : NameSet := {}
  let mut queue : Array Name := #[root]
  while queue.size > 0 do
    let n := queue[0]!
    queue := queue.extract 1 queue.size
    if visited.contains n then continue
    if !universeSet.contains n then continue
    visited := visited.insert n
    let deps := constDeps env n
    for d in deps.toList do
      if universeSet.contains d && !visited.contains d then
        queue := queue.push d
  return visited

/-- Topological sort of names by dependency -/
def topoSort (env : Environment) (names : Array Name) (universeSet : NameSet) : Array Name := Id.run do
  let mut sorted : Array Name := #[]
  let mut visited : NameSet := {}
  let mut remaining := names
  let mut maxIter := names.size * 2
  while remaining.size > 0 && maxIter > 0 do
    maxIter := maxIter - 1
    let mut nextRemaining : Array Name := #[]
    for n in remaining do
      let deps := filterDeps (constDeps env n) universeSet
      let allSatisfied := deps.all fun d => visited.contains d || !universeSet.contains d
      if allSatisfied then
        sorted := sorted.push n
        visited := visited.insert n
      else
        nextRemaining := nextRemaining.push n
    if nextRemaining.size == remaining.size then
      let first := remaining[0]!
      sorted := sorted.push first
      visited := visited.insert first
      nextRemaining := remaining.extract 1 remaining.size
    remaining := nextRemaining
  return sorted

/-- Emit a flake.nix for one declaration -/
def emitDeclFlake (n : Name) (deps : Array Name) (outDir : System.FilePath) : IO Unit := do
  let declDir := outDir / n.toString.replace "." "/"
  IO.FS.createDirAll declDir
  let mut inputsLines : Array String := #[]
  for d in deps do
    let dPath := d.toString.replace "." "-"
    let dDeclDir := outDir / d.toString.replace "." "/"
    let dUrl := s!"    {dPath}.url = \"git+file:///mnt/data1/git/github.com/leanprover-community/mathlib4/?ref=feature/split&dir={dDeclDir}\";"
    inputsLines := inputsLines.push dUrl
  let inputsBlock := if inputsLines.isEmpty then "" else "\n" ++ String.intercalate "\n" inputsLines.toList ++ "\n  "
  let inputsPart := "{ nixpkgs.url = \"github:NixOS/nixpkgs/nixos-unstable\"; flake-utils.url = \"github:numtide/flake-utils\"; " ++ inputsBlock ++ "}"
  let sys := "x86_64-linux"
  let preamble := "{\n  description = \"Mathlib declaration: " ++ n.toString ++ "\";\n  inputs = " ++ inputsPart ++ ";\n  outputs = { self, nixpkgs, flake-utils }:"
  let body := "\n    let\n      system = \"" ++ sys ++ "\";\n      pkgs = nixpkgs.legacyPackages.${system};\n    in {\n      packages.${sys}.default = pkgs.stdenv.mkDerivation {\n        pname = \"decl-" ++ n.toString ++ "\";\n        version = \"0.1.0\";\n        src = ./.;\n        phases = [ \"unpackPhase\" \"installPhase\" ];\n        installPhase = ''\n          mkdir -p $out\n          cp " ++ (nameToFile n) ++ " $out/\n        '';\n      };\n    };\n}"
  let flakeContent := preamble ++ body
  IO.FS.writeFile (declDir / "flake.nix") flakeContent

/-- Emit a single .lean file for one declaration -/
def emitDeclFile (env : Environment) (n : Name) (deps : Array Name) (outDir : System.FilePath) : IO Unit := do
  let relPath := (nameToSimpleMod n).replace "." "/" ++ ".lean"
  let path := outDir / relPath
  let parent := path.parent.getD outDir
  IO.FS.createDirAll parent
  let mut lines : Array String := #[]
  for d in deps do
    lines := lines.push s!"import {nameToSimpleMod d}"
  if deps.size > 0 then lines := lines.push ""
  lines := lines.push s!"-- {n} from environment"
  match env.find? n with
  | some (.defnInfo v) =>
    lines := lines.push s!"-- def {n} : {v.type}"
    lines := lines.push s!"-- (definition body omitted)"
  | some (.thmInfo v) => lines := lines.push s!"-- theorem {n} : {v.type}"
  | some (.axiomInfo v) => lines := lines.push s!"-- axiom {n} : {v.type}"
  | some (.opaqueInfo v) => lines := lines.push s!"-- opaque {n} : {v.type}"
  | some (.inductInfo v) =>
    lines := lines.push s!"-- inductive {n} : {v.type}"
    lines := lines.push s!"-- ctors: {v.ctors}"
  | some (.ctorInfo v) => lines := lines.push s!"-- constructor {n} : {v.type}"
  | some (.recInfo v) => lines := lines.push s!"-- recursor {n} : {v.type}"
  | some (.quotInfo _) => lines := lines.push s!"-- quot {n}"
  | none => lines := lines.push s!"-- (not found)"
  lines := lines.push ""
  lines := lines.push s!"-- Stub: this file represents the declaration `{n}`"
  lines := lines.push s!"-- In a full split, the body would be extracted from the environment."
  IO.FS.writeFile path (String.intercalate "\n" (lines.toList ++ [""]))

/-- Generate lakefile.toml for the split project -/
def emitLakefile (names : Array Name) (outDir : System.FilePath) : IO Unit := do
  let mut lines : Array String := #["name = \"mathlib-split\"", "version = \"0.1.0\"", "", "[[require]]", "name = \"mathlib\"", "git = \"https://github.com/meta-introspector/mathlib4\"", "rev = \"feature/split\"", ""]
  let mut seen : NameSet := {}
  for n in names do
    let mod := nameToSimpleMod n
    let root := mod.splitOn "." |>.head? |>.getD "Split"
    let rootName := root.toName
    if !seen.contains rootName then
      seen := seen.insert rootName
      lines := lines ++ ["[[lean_lib]]", s!"name = \"{root}\"", ""]
  IO.FS.writeFile (outDir / "lakefile.toml") (String.intercalate "\n" lines.toList ++ "\n")

/-- Generate a DAG summary as JSON -/
def emitDag (env : Environment) (names : Array Name) (universeSet : NameSet) (outDir : System.FilePath) : IO Unit := do
  let mut lines : Array String := #["{"]
  let mut idx := 0
  for n in names.toList do
    let deps := filterDeps (constDeps env n) universeSet
    let depsStr := deps.map (fun d => s!"\"{d}\"") |>.toList
    let comma := if idx + 1 < names.size then "," else ""
    lines := lines.push s!"  \"{n}\": [{String.intercalate ", " depsStr}]{comma}"
    idx := idx + 1
  lines := lines.push "}"
  IO.FS.writeFile (outDir / "dag.json") (String.intercalate "\n" lines.toList ++ "\n")

/-- Main: split declarations into a lattice -/
def main (args : List String) : IO UInt32 := do
  let rootMod := match args with | [] => "Mathlib.Algebra.Vertex.HVertexOperator" | h :: _ => h
  let outDirStr : String := match args with | [] => "./split-out" | [_] => "./split-out" | [_, h] => h | _ => "./split-out"
  let outPath : System.FilePath := System.FilePath.mk outDirStr
  IO.println s!"SplitDecls: root={rootMod} out={outDirStr}"
  let opts := {}
  let env ← importModules #[{module := rootMod.toName}] opts
  let mut allNames : NameSet := {}
  let mut allNamesArr : Array Name := #[]
  for (n, _) in env.constants.map₁.toList do
    if !n.isInternal && !n.toString.startsWith "_" then
      allNames := allNames.insert n
      allNamesArr := allNamesArr.push n
  IO.println s!"  {allNamesArr.size} declarations in environment"
  let rootName := rootMod.toName
  let closure := bfsClosure env rootName allNames
  let closureArr := closure.toList.toArray
  IO.println s!"  {closureArr.size} declarations in closure of {rootMod}"
  let sorted := topoSort env closureArr closure
  IO.println s!"  {sorted.size} declarations after topo sort"
  IO.FS.createDirAll outPath
  let mut count := 0
  for n in sorted do
    let deps := filterDeps (constDeps env n) closure
    emitDeclFile env n deps outPath
    emitDeclFlake n deps outPath
    count := count + 1
    if count % 500 == 0 then IO.println s!"  ... {count}/{sorted.size} files emitted"
  emitLakefile sorted outPath
  emitDag env sorted closure outPath
  IO.println s!"  {count} declaration files written to {outDirStr}"
  IO.println s!"  dag.json written"
  IO.println s!"  lakefile.toml written"
  return 0