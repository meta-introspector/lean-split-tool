#!/usr/bin/env bash
set -e

MATHLIB_REPO="${1:-https://github.com/meta-introspector/mathlib4.git}"
OUTPUT_BRANCH="${2:-feature/split}"
WORK_DIR=$(mktemp -d)

echo "Generating modular flakes in $WORK_DIR"

# Clone latest mathlib
echo "Cloning latest mathlib..."
git clone --depth 1 https://github.com/leanprover-community/mathlib4.git "$WORK_DIR/mathlib-latest"

# Copy mathlib source
cp -r "$WORK_DIR/mathlib-latest/Mathlib" "$WORK_DIR/"

# Generate flake.nix for each module
mkdir -p "$WORK_DIR/split"
cd "$WORK_DIR"

find Mathlib -name "*.lean" -type f | while read f; do
    rel="${f#Mathlib/}"
    mod="${rel%.lean}"
    mod="${mod//\//.}"
    out_dir="$WORK_DIR/split/${rel%.lean}"
    mkdir -p "$out_dir"
    
    cat > "$out_dir/flake.nix" << EOF
# Generated flake.nix for $mod
{
  description = "Mathlib module: $mod";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.\${system};
    in {
      packages.\${system}.default = pkgs.stdenv.mkDerivation {
        pname = "mathlib-module-$mod";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p \$out
          cp $(basename "$f") \$out/
        '';
      };
    };
}
EOF
    
    # Copy source file (keep original path)
    cp "$f" "$out_dir/"
done

# Create root flake
cat > "$WORK_DIR/split/flake.nix" << 'ROOTFLAKE'
{
  description = "Mathlib modular split - one flake per module";
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

# Push to bare repo
cd "$WORK_DIR/split"
git init
git add -A
git commit -m "Add modular split flakes for mathlib modules"
git remote add origin "$MATHLIB_REPO"
git push --force origin "HEAD:$OUTPUT_BRANCH"

echo "Pushed split flakes to $MATHLIB_REPO#$OUTPUT_BRANCH"
rm -rf "$WORK_DIR"