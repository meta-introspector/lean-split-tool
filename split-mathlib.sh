#!/usr/bin/env bash
set -e

MATHLIB_REPO="${1:-https://github.com/meta-introspector/mathlib4.git}"
OUTPUT_BRANCH="${2:-feature/split}"
SOURCE_DIR="${3:-/mnt/data1/time-2026/05-may/06/fuzztest/dag_cbrrr_fuzz_project/IMPL/99/other/leanprover-community/mathlib4/Mathlib}"
WORK_DIR=$(mktemp -d)

echo "Generating modular flakes in $WORK_DIR"

# Use provided source or clone latest mathlib
if [[ -d "$SOURCE_DIR" ]]; then
    echo "Using mathlib source from $SOURCE_DIR"
    cp -r "$SOURCE_DIR" "$WORK_DIR/Mathlib"
else
    echo "Cloning latest mathlib..."
    git clone --depth 1 https://github.com/leanprover-community/mathlib4.git "$WORK_DIR/mathlib-latest"
    cp -r "$WORK_DIR/mathlib-latest/Mathlib" "$WORK_DIR/"
fi

# Generate flake.nix for each module
mkdir -p "$WORK_DIR/split"
cd "$WORK_DIR"

find Mathlib -name "*.lean" -type f | while read f; do
    rel="${f#Mathlib/}"
    mod="${rel%.lean}"
    mod="${mod//\//.}"
    out_dir="$WORK_DIR/split/${rel%.lean}"
    mkdir -p "$out_dir"
    
    # Copy lean-toolchain from root if exists
    if [[ -f "Mathlib/../lean-toolchain" ]]; then
        cp "Mathlib/../lean-toolchain" "$out_dir/" 2>/dev/null || true
    fi
    
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
    in
    {
      packages.\${system}.default = pkgs.stdenv.mkDerivation {
        pname = "mathlib-module-$mod";
        version = "0.1.0";
        src = ./.;
        nativeBuildInputs = [ pkgs.lean4 ];
        dontInstall = true;
        buildPhase = ''
          runHook preBuild
          lean --make $(basename "\$src") 2>&1 || echo "Build note: may need dependencies"
          runHook postBuild
        '';
        installPhase = ''
          mkdir -p \$out
          cp *.lean \$out/ 2>/dev/null || true
          cp -r *.olean \$out/ 2>/dev/null || true
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