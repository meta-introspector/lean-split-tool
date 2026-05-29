# Generated flake.nix for Topology.MetricSpace.ProperSpace.Lemmas
{
  description = "Mathlib declaration: Topology.MetricSpace.ProperSpace.Lemmas";
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
        pname = "decl-Topology.MetricSpace.ProperSpace.Lemmas";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/MetricSpace/ProperSpace/Lemmas.lean $out/
        '';
      };
    };
}
