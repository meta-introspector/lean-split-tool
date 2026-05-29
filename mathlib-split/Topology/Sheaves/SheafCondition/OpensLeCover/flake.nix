# Generated flake.nix for Topology.Sheaves.SheafCondition.OpensLeCover
{
  description = "Mathlib declaration: Topology.Sheaves.SheafCondition.OpensLeCover";
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
        pname = "decl-Topology.Sheaves.SheafCondition.OpensLeCover";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/Sheaves/SheafCondition/OpensLeCover.lean $out/
        '';
      };
    };
}
