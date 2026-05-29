# Generated flake.nix for Topology.Category.Profinite.Nobeling.Basic
{
  description = "Mathlib declaration: Topology.Category.Profinite.Nobeling.Basic";
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
        pname = "decl-Topology.Category.Profinite.Nobeling.Basic";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/Category/Profinite/Nobeling/Basic.lean $out/
        '';
      };
    };
}
