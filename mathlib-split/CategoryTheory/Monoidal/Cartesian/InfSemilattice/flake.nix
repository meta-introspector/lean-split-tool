# Generated flake.nix for CategoryTheory.Monoidal.Cartesian.InfSemilattice
{
  description = "Mathlib declaration: CategoryTheory.Monoidal.Cartesian.InfSemilattice";
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
        pname = "decl-CategoryTheory.Monoidal.Cartesian.InfSemilattice";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Monoidal/Cartesian/InfSemilattice.lean $out/
        '';
      };
    };
}
