# Generated flake.nix for CategoryTheory.Bicategory.Functor.StrictPseudofunctor
{
  description = "Mathlib declaration: CategoryTheory.Bicategory.Functor.StrictPseudofunctor";
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
        pname = "decl-CategoryTheory.Bicategory.Functor.StrictPseudofunctor";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Bicategory/Functor/StrictPseudofunctor.lean $out/
        '';
      };
    };
}
