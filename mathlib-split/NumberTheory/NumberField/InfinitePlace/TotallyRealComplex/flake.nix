# Generated flake.nix for NumberTheory.NumberField.InfinitePlace.TotallyRealComplex
{
  description = "Mathlib declaration: NumberTheory.NumberField.InfinitePlace.TotallyRealComplex";
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
        pname = "decl-NumberTheory.NumberField.InfinitePlace.TotallyRealComplex";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/NumberField/InfinitePlace/TotallyRealComplex.lean $out/
        '';
      };
    };
}
