# Generated flake.nix for RingTheory.DiscreteValuationRing.TFAE
{
  description = "Mathlib declaration: RingTheory.DiscreteValuationRing.TFAE";
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
        pname = "decl-RingTheory.DiscreteValuationRing.TFAE";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/DiscreteValuationRing/TFAE.lean $out/
        '';
      };
    };
}
