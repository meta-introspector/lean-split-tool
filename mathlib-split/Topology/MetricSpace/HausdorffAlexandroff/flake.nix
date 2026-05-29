# Generated flake.nix for Topology.MetricSpace.HausdorffAlexandroff
{
  description = "Mathlib declaration: Topology.MetricSpace.HausdorffAlexandroff";
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
        pname = "decl-Topology.MetricSpace.HausdorffAlexandroff";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/MetricSpace/HausdorffAlexandroff.lean $out/
        '';
      };
    };
}
