# Generated flake.nix for Topology.Algebra.Order.ArchimedeanDiscrete
{
  description = "Mathlib declaration: Topology.Algebra.Order.ArchimedeanDiscrete";
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
        pname = "decl-Topology.Algebra.Order.ArchimedeanDiscrete";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/Algebra/Order/ArchimedeanDiscrete.lean $out/
        '';
      };
    };
}
