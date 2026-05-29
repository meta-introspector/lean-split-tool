# Generated flake.nix for RepresentationTheory.Homological.GroupHomology.LowDegree
{
  description = "Mathlib declaration: RepresentationTheory.Homological.GroupHomology.LowDegree";
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
        pname = "decl-RepresentationTheory.Homological.GroupHomology.LowDegree";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RepresentationTheory/Homological/GroupHomology/LowDegree.lean $out/
        '';
      };
    };
}
