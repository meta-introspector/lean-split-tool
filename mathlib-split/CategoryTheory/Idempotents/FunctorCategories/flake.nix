# Generated flake.nix for CategoryTheory.Idempotents.FunctorCategories
{
  description = "Mathlib declaration: CategoryTheory.Idempotents.FunctorCategories";
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
        pname = "decl-CategoryTheory.Idempotents.FunctorCategories";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Idempotents/FunctorCategories.lean $out/
        '';
      };
    };
}
