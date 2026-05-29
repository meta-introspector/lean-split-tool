#!/usr/bin/env nix-shell
#!nix-shell -p nix
#!nix-shell -i bash
set -e

OUTPUT_DIR="${1:-./mathlib-split}"
BARE_REPO="/mnt/data1/git/github.com/leanprover-community/mathlib4.git"
BRANCH="feature/split"

mkdir -p "$OUTPUT_DIR"

# List all .lean files in Mathlib and generate flakes
find /mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib -name "*.lean" -type f | while read -r leanFile; do
  # Get relative path from Mathlib
  relPath="${leanFile#/mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib/}"
  # Convert to module name (replace / with .)
  moduleName="${relPath%.lean//.}"
  # Create output directory
  outDir="$OUTPUT_DIR/${relPath%/*.lean}"
  mkdir -p "$outDir"
  
  # Generate flake.nix
  cat > "$outDir/flake.nix" << FLAKE
# Generated flake.nix for $moduleName
{
  description = "Mathlib declaration: $moduleName";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "decl-$moduleName";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp ${relPath} $out/
        '';
      };
    };
}
FLAKE
  
  # Copy lean file
  cp "$leanFile" "$outDir/"
  
  echo "Generated: $moduleName"
done

# Create root flake
cat > "$OUTPUT_DIR/flake.nix" << 'ROOTFLAKE'
{
  description = "Mathlib split - one flake per declaration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.lean4 pkgs.git ];
      };
    };
}
ROOTFLAKE

echo "Done. Output in $OUTPUT_DIR"