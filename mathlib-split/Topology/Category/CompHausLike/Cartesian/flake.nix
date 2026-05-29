# Generated flake.nix for Topology.Category.CompHausLike.Cartesian
{
  description = "Mathlib declaration: Topology.Category.CompHausLike.Cartesian";
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
        pname = "decl-Topology.Category.CompHausLike.Cartesian";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/Category/CompHausLike/Cartesian.lean $out/
        '';
      };
    };
}
