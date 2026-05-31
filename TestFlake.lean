/-
TestFlake.lean - Generate a test flake.nix for a single declaration
No mathlib import required - just demonstrates the flake output format
-/
import Lean System

def main (args : List String) : IO UInt32 := do
  let outDir : System.FilePath := System.FilePath.mk "./demo-output"
  let n : Name := `Mathlib.Data.Nat.Prime
  let deps : Array Name := #[]
  
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
  let body := "\n    let\n      system = \"" ++ sys ++ "\";\n      pkgs = nixpkgs.legacyPackages.${system};\n    in {\n      packages.${sys}.default = pkgs.stdenv.mkDerivation {\n        pname = \"decl-" ++ n.toString ++ "\";\n        version = \"0.1.0\";\n        src = ./.;\n        phases = [ \"unpackPhase\" \"installPhase\" ];\n        installPhase = ''\n          mkdir -p $out\n          cp Mathlib/Data/Nat/Prime.lean $out/\n        '';\n      };\n    };\n}"
  let flakeContent := preamble ++ body
  IO.FS.writeFile (declDir / "flake.nix") flakeContent
  
  IO.println s!"Generated flake.nix at {declDir / \"flake.nix\"}"
  return 0