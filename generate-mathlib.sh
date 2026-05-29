#!/usr/bin/env nix-shell
#!nix-shell -p nix
#!nix-shell -i bash
set -e

OUTPUT_DIR="${1:-./mathlib-split}"
SOURCE_DIR="/mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib"

mkdir -p "$OUTPUT_DIR"

# Generate flake.nix for each .lean file
for leanFile in "$SOURCE_DIR"/*.lean "$SOURCE_DIR"/*/*.lean "$SOURCE_DIR"/*/*/*.lean "$SOURCE_DIR"/*/*/*/*.lean; do
  [ -f "$leanFile" ] || continue
  relPath="${leanFile#$SOURCE_DIR/}"
  moduleName="${relPath//\//.}"
  moduleName=${moduleName%.lean}
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
  
  cp "$leanFile" "$outDir/"
  echo "Generated: $moduleName"
done

# Create root flake
cat > "$OUTPUT_DIR/flake.nix" << 'ROOTFLAKE'
{
  description = "Mathlib split - one flake per declaration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.lean4 ];
      };
    };
}
ROOTFLAKE

echo "Done. Generated $(find $OUTPUT_DIR -name 'flake.nix' | wc -l) flakes"
