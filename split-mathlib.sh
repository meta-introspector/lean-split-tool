#!/bin/bash
# split_mathlib.sh - Split Mathlib modules into individual declarations

set -e

MATHLIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SPLIT_TOOL="$MATHLIB_ROOT/tools/lean4_split/SplitDecls.lean"

usage() {
    echo "Usage: $0 <module_name> <output_dir>"
    echo "Example: $0 Mathlib.Data.Nat.Prime ./split-out"
    echo "Example: $0 Mathlib.Tactic ./tactic-split"
    echo ""
    echo "This script must be run from the mathlib root directory or use absolute paths."
    exit 1
}

if [ $# -ne 2 ]; then
    usage
fi

MODULE_NAME="$1"
OUTPUT_DIR="$2"

echo "Splitting $MODULE_NAME into $OUTPUT_DIR..."
echo "Mathlib root: $MATHLIB_ROOT"

cd "$MATHLIB_ROOT"

# Build the module first if needed
echo "Building $MODULE_NAME..."
lake build "$MODULE_NAME" || {
    echo "Failed to build $MODULE_NAME"
    echo "Make sure you're in the mathlib root and the module name is correct."
    exit 1
}

# Run the split tool (lakefile.lean + lean-toolchain)
echo "Running split tool..."
lake env lean --run tools/lean4_split/SimpleSplit.lean "$MODULE_NAME" "$OUTPUT_DIR" "$MATHLIB_ROOT"

# Run the lattice flake generator (one flake.nix per declaration)
echo "Generating lattice flakes..."
lake env lean --run tools/lean4_split/SplitDecls.lean "$MODULE_NAME" "$OUTPUT_DIR/lattice"

echo "Updating manifest..."
cd "$OUTPUT_DIR" && lake update

echo "Split complete! Output in $OUTPUT_DIR"
echo "Generated files:"
ls -la "$OUTPUT_DIR" | head -10
