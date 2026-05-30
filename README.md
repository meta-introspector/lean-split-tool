# Lean Mathlib Split - Per-Module Nix Flakes

Tool to generate Nix flakes for each Lean module in Mathlib, enabling modular building and dependency tracking.

## Quick Start

```bash
# Generate and publish modular flakes to bare repo
nix run .#generate-split

# Build any module afterward
nix build "git+file:///mnt/data1/git/github.com/leanprover-community/mathlib4/?ref=feature/split&dir=Algebra/Ring/Basic"
```

## Structure

- `split-mathlib.sh` - Publish modular flakes to bare git repo
- `SplitDecls.lean` - Lean program for per-declaration lattice splitting
- `generate.py` - Python script to generate flakes locally
- `topological-build.py` - Build modules in dependency order via git+file URLs
- `generate-lattice.py` - Generate flakes with input dependencies for lattice structure
- `.github/workflows/build.yml` - GitHub Actions CI

## Usage

### Generate flakes
```bash
nix run .#generate-split
# Pushes to feature/split branch in bare repo
```

### Build modules
```bash
# Build single module
nix build "git+file:///mnt/data1/git/github.com/leanprover-community/mathlib4/?ref=feature/split&dir=Data/Nat/Basic"

# Build from local generated flakes
nix build .#path/to/module
```

### Topological build (dependency order)
```bash
nix run .#topological-build
# Builds modules in topological order - dependencies first
```

## Topological Order Verification

Modules are built in dependency order:
- Root modules (no imports) are built first: `Tactic.Linter.DirectoryDependency`
- Modules importing `Init` come later: `Algebra.Expr`, `Logic.OpClass`, etc.
- Final modules depend on many others: `Tactic` (323 imports), `Analysis.Normed.Module.FiniteDimension` (14 imports)

## Per-Declaration Lattice

The `SplitDecls.lean` tool creates flakes with dependencies:

```nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  Dep-Name.url = "git+file:///mnt/data1/git/github.com/leanprover-community/mathlib4/?ref=feature/split&dir=Dep/Path";
};
```

Each declaration references its prior dependencies via the lattice.

## CI/CD

GitHub Actions workflow validates building and publishes changes.

## License

AGPL v3