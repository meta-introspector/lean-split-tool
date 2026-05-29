# Generated flake.nix for Combinatorics.Enumerative.Partition.Glaisher
{
  description = "Mathlib declaration: Combinatorics.Enumerative.Partition.Glaisher";
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
        pname = "decl-Combinatorics.Enumerative.Partition.Glaisher";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Combinatorics/Enumerative/Partition/Glaisher.lean $out/
        '';
      };
    };
}
