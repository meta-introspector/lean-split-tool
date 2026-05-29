# Generated flake.nix for Combinatorics.SimpleGraph.VertexCover
{
  description = "Mathlib declaration: Combinatorics.SimpleGraph.VertexCover";
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
        pname = "decl-Combinatorics.SimpleGraph.VertexCover";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Combinatorics/SimpleGraph/VertexCover.lean $out/
        '';
      };
    };
}
