# Generated flake.nix for CategoryTheory.SmallObject.Iteration.FunctorOfCocone
{
  description = "Mathlib declaration: CategoryTheory.SmallObject.Iteration.FunctorOfCocone";
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
        pname = "decl-CategoryTheory.SmallObject.Iteration.FunctorOfCocone";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/SmallObject/Iteration/FunctorOfCocone.lean $out/
        '';
      };
    };
}
