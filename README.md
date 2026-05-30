# Lean Mathlib Split - Per-Module Nix Flakes

Tool to generate Nix flakes for each Lean module in Mathlib, enabling modular building and dependency tracking.

## Quick Start

```bash
# Generate and publish modular flakes to meta-introspector/mathlib4 fork
nix run .#generate-split

# Build any module from the fork
nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Algebra/Ring/Basic"
```

## Structure

- `split-mathlib.sh` - Publish modular flakes to meta-introspector/mathlib4 fork
- `SplitDecls.lean` - Lean program for per-declaration lattice splitting
- `generate.py` - Python script to generate flakes locally
- `topological-build.py` - Build modules in topological order via GitHub URLs
- `generate-lattice.py` - Generate flakes with input dependencies for lattice structure
- `.github/workflows/build.yml` - GitHub Actions CI

## Usage

### Generate flakes
```bash
nix run .#generate-split
# Pushes to feature/split branch in meta-introspector/mathlib4
```

### Build modules from GitHub
```bash
# Build single module
nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Data/Nat/Basic"

# Build Init module
nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Init"
```

### Topological build (dependency order)
```bash
nix run .#topological-build
# Builds modules in topological order - dependencies first
```

## Topological Order Verification

Modules are built in dependency order:
- Root modules (no imports) are built first: `Tactic.Linter.DirectoryDependency`
- Modules importing `Init` come later: `Tactic.Eqns`, `Tactic.Variable`, etc.
- Final modules depend on many others: `Tactic` (323 imports), `Analysis.Normed.Module.FiniteDimension` (14 imports)

## Per-Declaration Lattice

The `generate-lattice.py` tool creates flakes with dependencies:

```nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  DepName = "github:meta-introspector/mathlib4?ref=feature/split&dir=DepPath";
};
```

Each module references its prior dependencies via the lattice.

## CI/CD

GitHub Actions workflow validates building and publishes changes.

## GitHub Pages Site

Interactive module selector available at: https://meta-introspector.github.io/lean-split-tool/

Features:
- Search and select modules from 7648 available
- Click modules to select them
- Generate Nix build commands for selected modules
- Graph Theory modules: `Combinatorics.SimpleGraph.Basic`, `Combinatorics.SimpleGraph.Coloring`, etc.

## GitHub Action

```yaml
- uses: meta-introspector/lean-split-tool/.github/actions/lean4-split
  with:
    modules: "Algebra/Ring/Basic Init Data/Nat/Basic"
```

## License

AGPL v3