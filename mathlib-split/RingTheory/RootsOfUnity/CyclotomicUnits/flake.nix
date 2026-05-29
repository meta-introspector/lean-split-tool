# Generated flake.nix for RingTheory.RootsOfUnity.CyclotomicUnits
{
  description = "Mathlib declaration: RingTheory.RootsOfUnity.CyclotomicUnits";
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
        pname = "decl-RingTheory.RootsOfUnity.CyclotomicUnits";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/RootsOfUnity/CyclotomicUnits.lean $out/
        '';
      };
    };
}
