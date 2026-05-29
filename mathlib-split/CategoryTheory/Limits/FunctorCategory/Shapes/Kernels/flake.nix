# Generated flake.nix for CategoryTheory.Limits.FunctorCategory.Shapes.Kernels
{
  description = "Mathlib declaration: CategoryTheory.Limits.FunctorCategory.Shapes.Kernels";
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
        pname = "decl-CategoryTheory.Limits.FunctorCategory.Shapes.Kernels";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Limits/FunctorCategory/Shapes/Kernels.lean $out/
        '';
      };
    };
}
