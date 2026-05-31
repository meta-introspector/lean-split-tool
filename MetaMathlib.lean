/-
MetaMathlib.lean — Use Lean's Environment API to introspect Mathlib's own import graph,
topologically sort it into layers, and emit a split manifest.

Usage:
  lake env lean --run tools/lean4_split/MetaMathlib.lean -- ./meta-out
-/
import Lean
import Mathlib

open Lean System

/-- Get direct imports of a module from the environment -/
def moduleImports (env : Environment) (mod : Name) : Array Name :=
  match env.getModuleIdx? mod with
  | none => #[]
  | some idx => env.header.moduleData[idx]!.imports.map (·.module)

/-- Topological sort: returns modules in dependency order (leaves first) -/
def topoSort (modules : Array Name) (deps : Name → Array Name) : Array Name := Id.run do
  let mut visited : NameSet := {}
  let mut result : Array Name := #[]
  let mut stack : Array (Name × Bool) := #[]

  for m in modules do
    stack := stack.push (m, false)

  while !stack.isEmpty do
    let (m, processed) := stack.back!
    stack := stack.pop
    if processed then
      if !visited.contains m then
        visited := visited.insert m
        result := result.push m
    else if !visited.contains m then
      stack := stack.push (m, true)
      for dep in deps m do
        if !visited.contains dep then
          stack := stack.push (dep, false)

  return result

/-- Assign layer numbers: layer = 1 + max(layer of deps), 0 if no deps -/
def computeLayers (sorted : Array Name) (deps : Name → Array Name) : Std.HashMap Name Nat := Id.run do
  let mut layers : Std.HashMap Name Nat := {}
  for m in sorted do
    let d := deps m
    let maxDep := d.foldl (fun acc dep => max acc (layers.getD dep 0)) 0
    layers := layers.insert m (if d.isEmpty then 0 else maxDep + 1)
  return layers

def main (args : List String) : IO Unit := do
  let outDir := args.headD "./meta-out"
  IO.println s!"Loading Mathlib environment..."

  let env ← importModules #[{ module := `Mathlib }] {}

  -- Collect all Mathlib modules
  let allMods := env.header.moduleNames
  let mathlibMods := allMods.filter (fun n => n.toString.startsWith "Mathlib")

  IO.println s!"Found {mathlibMods.size} Mathlib modules"

  -- Build dep function scoped to mathlib modules
  let mathlibSet := mathlibMods.foldl (fun s m => s.insert m) (NameSet.empty)
  let deps := fun m => (moduleImports env m).filter (mathlibSet.contains ·)

  -- Topo sort
  let sorted := topoSort mathlibMods deps
  IO.println s!"Topologically sorted {sorted.size} modules"

  -- Compute layers
  let layers := computeLayers sorted deps
  let maxLayer := layers.fold (fun acc _ v => max acc v) 0
  IO.println s!"Layer depth: {maxLayer}"

  -- Group by layer
  let mut byLayer : Array (Array Name) := Array.replicate (maxLayer + 1) #[]
  for m in sorted do
    let l := layers.getD m 0
    byLayer := byLayer.set! l (byLayer[l]! |>.push m)

  -- Emit summary
  IO.FS.createDirAll (FilePath.mk outDir)

  -- Write layer manifest
  let mut manifest := "# Mathlib Layer Manifest\n\n"
  manifest := manifest ++ s!"Total modules: {mathlibMods.size}\nLayer depth: {maxLayer}\n\n"
  for i in List.range (maxLayer + 1) do
    let mods := byLayer[i]!
    manifest := manifest ++ s!"## Layer {i} ({mods.size} modules)\n"
    for m in mods do
      manifest := manifest ++ s!"  - {m}\n"
    manifest := manifest ++ "\n"
  IO.FS.writeFile (FilePath.mk outDir / "layers.md") manifest

  -- Write machine-readable layer JSON
  let mut json := "{\n"
  for i in List.range (maxLayer + 1) do
    let mods := byLayer[i]!
    let modList := mods.toList.map (fun m => s!"\"{m}\"") |> String.intercalate ", "
    json := json ++ s!"  \"layer_{i}\": [{modList}]"
    json := json ++ (if i < maxLayer then ",\n" else "\n")
  json := json ++ "}\n"
  IO.FS.writeFile (FilePath.mk outDir / "layers.json") json

  -- Write split targets for common layer boundaries
  let splitLayers := [0, 1, 2, 5, 10, 20]
  let mut splits := "# Common Split Targets\n\n"
  splits := splits ++ "These are the modules at key layer boundaries — good candidates for `split_mathlib.sh`:\n\n"
  for l in splitLayers do
    if l ≤ maxLayer then
      let mods := byLayer[l]!
      splits := splits ++ s!"### Layer {l} ({mods.size} modules)\n"
      for m in mods[:10] do
        splits := splits ++ s!"  tools/lean4_split/split_mathlib.sh {m} ./split-layer-{l}\n"
      splits := splits ++ "\n"
  IO.FS.writeFile (FilePath.mk outDir / "split-targets.md") splits

  IO.println s!"Written to {outDir}/"
  IO.println s!"  layers.md      — human-readable layer breakdown"
  IO.println s!"  layers.json    — machine-readable"
  IO.println s!"  split-targets.md — suggested split commands"
