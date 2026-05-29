# Generated flake.nix for Topology.ContinuousMap.Bounded.ArzelaAscoli
{
  description = "Mathlib declaration: Topology.ContinuousMap.Bounded.ArzelaAscoli";
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
        pname = "decl-Topology.ContinuousMap.Bounded.ArzelaAscoli";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/ContinuousMap/Bounded/ArzelaAscoli.lean $out/
        '';
      };
    };
}
