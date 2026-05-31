# Next Tasks for lean-split-tool

## High Priority

1. **Vendored Actions Fixes**
   - Build JS artifacts for `meta-introspector/setup-python@v5`
   - Build JS artifacts for `meta-introspector/deploy-pages@v4`
   - Use `actions/configure-pages@v5` instead of vendored version

2. **Lattice Dependencies**
   - Parse imports in each module to determine dependencies
   - Generate flake.nix with proper input URLs for dependencies
   - Topologically sort for build order

3. **Actual Lean Builds**
   - Integrate lean4-nix overlay for Lean toolchain
   - Configure elan/lean for actual compilation
   - Add olean caching between builds

## Medium Priority

4. **3D Graph Enhancement**
   - Add zoom limits and pan controls
   - Implement node search/filter
   - Color nodes by module category
   - Add node details on click

5. **Performance Optimization**
   - Pre-generate category-specific flakes (Algebra, Topology, Graph Theory)
   - Add module subset selection UI
   - Paginate module list (currently 8,113 modules causes slow rendering)

6. **Documentation Examples**
   - Add Graph Theory examples using Combinatorics.SimpleGraph
   - Add Algebra examples using Ring/Basic
   - Add Topology examples using Manifold/Basic

## Low Priority

7. **Testing**
   - Add unit tests for CLI commands
   - Add integration tests for flake generation
   - Test all vendored actions

8. **Additional Features**
   - Add download button for generated flake.nix
   - Add copy-to-clipboard for output box
   - Add module version/tag selection

## Completed (already done)

- ✅ Modular flake generation (8,113 modules)
- ✅ GitHub Pages site with module selector
- ✅ CLI tool for nix commands and flake generation
- ✅ Daily GitHub Actions workflow
- ✅ Example Lean4 proof (GradedMonoid)
- ✅ Test workflow for module builds