/-
SplitDecls.lean — Generates per-declaration flakes for mathlib lattice
-/
import Lean System

def nameToFile (n : Name) : String :=
  n.toString.replace "." "/" ++ ".lean"

def emitDeclFlake (n : Name) (outDir : System.FilePath) : IO Unit := do
  let declDir := outDir / n.toString.replace "." "/"
  IO.FS.createDirAll declDir
  let fileName := nameToFile n
  let flakeContent : String := "# Generated flake.nix for " ++ n.toString ++ "\n{\n  description = \"Mathlib declaration: " ++ n.toString ++ "\";\n  inputs = {\n    nixpkgs.url = \"github:NixOS/nixpkgs/nixos-unstable\";\n    flake-utils.url = \"github:numtide/flake-utils\";\n  };\n  outputs = { self, nixpkgs, flake-utils }:\n    let\n      system = \"x86_64-linux\";\n      pkgs = nixpkgs.legacyPackages.${system};\n    in {\n      packages.${system}.default = pkgs.stdenv.mkDerivation {\n        pname = \"decl-" ++ n.toString ++ "\";\n        version = \"0.1.0\";\n        src = ./.;\n        phases = [ \"unpackPhase\" \"installPhase\" ];\n        installPhase = \"\"\"\n          mkdir -p $out\n          cp " ++ fileName ++ " $out/\n        \"\"\";\n      };\n    };\n}"
  IO.FS.writeFile (declDir / "flake.nix") flakeContent
  let leanContent : String := "-- Declaration stub for " ++ n.toString ++ "\n" ++ n.toString
  IO.FS.writeFile (declDir / fileName) leanContent

def main : IO UInt32 := do
  let outDir : System.FilePath := System.FilePath.mk "./demo-output"
  let n : Name := `Mathlib.Data.Nat.Prime
  emitDeclFlake n outDir
  IO.println s!"Generated {outDir / n.toString.replace "." "/" / "flake.nix"}"
  return 0