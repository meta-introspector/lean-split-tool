# Lean Modular Flakes Example

This example demonstrates building a Lean4 project using modular mathlib flakes.

## Prerequisites

- Nix with flake support
- A mathlib fork with modular flakes (default: meta-introspector/mathlib4)

## Quick Start

```bash
# Build using modular flakes
nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Algebra/GradedMonoid" --no-write-lock-file

# Or use the CLI tool
nix run github:meta-introspector/lean-split-tool -- nix "Algebra.GradedMonoid"

# Or create a flake from selected modules
nix run github:meta-introspector/lean-split-tool -- flake "Algebra.GradedMonoid Init" -o flake.nix
```

## Project Structure

```
example/
├── README.md          # This file
└── TestGraded.lean    # Example proof using GradedMonoid
```

## Building the Example

The example proves the `trivialGradedMonoid` is a valid graded monoid instance:

```bash
# Build the grad monoid module
nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Algebra/GradedMonoid" --no-write-lock-file

# View the built lean file
ls /tmp/result/*.lean
```

## How It Works

1. Each Mathlib module is available as a separate Nix flake
2. Modules are organized by namespace (e.g., `Algebra/GradedMonoid`)
3. Dependencies are resolved via the lattice structure in `feature/split` branch
4. Build any subset of modules independently

## Available Modules

Browse https://meta-introspector.github.io/lean-split-tool/ to select modules.

Level 4 modules include:
- `Algebra.BigOperators.Group.Finset.Basic`
- `Topology.Algebra.Module.Multilinear.Basic`
- `Algebra.BigOperators.Group.Finset.Lemmas`

## License

AGPL v3