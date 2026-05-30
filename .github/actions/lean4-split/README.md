# lean4-split Action

Build Lean mathlib modules individually with Nix in topological order.

## Usage

In any workflow:

```yaml
- uses: meta-introspector/lean-split-tool/.github/actions/lean4-split
  with:
    modules: "Algebra/Ring/Basic Init Data/Nat/Basic"
    repo: "meta-introspector/mathlib4"
    branch: "feature/split"
```

## Inputs

- `modules` (required): Space-separated module paths to build (e.g., "Algebra/Ring/Basic Data/Nat/Basic")
- `repo`: GitHub repo in `owner/repo` format (default: meta-introspector/mathlib4)
- `branch`: Branch containing modular flakes (default: feature/split)

## Example: Build Graph Theory modules

```yaml
- uses: meta-introspector/lean-split-tool/.github/actions/lean4-split
  with:
    modules: "Combinatorics/SimpleGraph Initiate SetTheory/Cardinal"
    repo: "meta-introspector/mathlib4"
```