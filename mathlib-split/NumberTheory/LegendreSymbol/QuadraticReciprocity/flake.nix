# Generated flake.nix for NumberTheory.LegendreSymbol.QuadraticReciprocity
{
  description = "Mathlib declaration: NumberTheory.LegendreSymbol.QuadraticReciprocity";
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
        pname = "decl-NumberTheory.LegendreSymbol.QuadraticReciprocity";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/LegendreSymbol/QuadraticReciprocity.lean $out/
        '';
      };
    };
}
