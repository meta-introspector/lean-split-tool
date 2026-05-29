# Generated flake.nix for RepresentationTheory.Homological.GroupCohomology.LongExactSequence
{
  description = "Mathlib declaration: RepresentationTheory.Homological.GroupCohomology.LongExactSequence";
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
        pname = "decl-RepresentationTheory.Homological.GroupCohomology.LongExactSequence";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RepresentationTheory/Homological/GroupCohomology/LongExactSequence.lean $out/
        '';
      };
    };
}
