# lean4-split Action

Build Lean mathlib modules individually with Nix flakes in topological order.

## Usage

```yaml
- uses: meta-introspector/lean-split-tool/.github/actions/lean4-split
  with:
    modules: "Algebra/Ring/Basic Data/Nat/Basic"
    repo: "meta-introspector/mathlib4"
    branch: "feature/split"
```

## Inputs

- `modules`: Space-separated list of module paths to build
- `pattern`: Pattern to match modules under mathlib-split/ (e.g., "Algebra/Group")
- `max-modules`: Maximum number of modules to build (default: 100)
- `repo`: GitHub repo for module sources
- `branch`: Branch containing modular flakes

## Outputs

- `modules-built`: Number of modules successfully built