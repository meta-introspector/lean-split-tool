# Generated flake.nix for Combinatorics.Enumerative.Partition.Basic
{
  description = "Mathlib declaration: Combinatorics.Enumerative.Partition.Basic";
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
        pname = "decl-Combinatorics.Enumerative.Partition.Basic";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Combinatorics/Enumerative/Partition/Basic.lean $out/
        '';
      };
    };
}
