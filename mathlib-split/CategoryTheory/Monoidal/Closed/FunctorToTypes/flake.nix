# Generated flake.nix for CategoryTheory.Monoidal.Closed.FunctorToTypes
{
  description = "Mathlib declaration: CategoryTheory.Monoidal.Closed.FunctorToTypes";
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
        pname = "decl-CategoryTheory.Monoidal.Closed.FunctorToTypes";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Monoidal/Closed/FunctorToTypes.lean $out/
        '';
      };
    };
}
