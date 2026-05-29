# Generated flake.nix for Algebra.Homology.DerivedCategory.Ext.ExactSequences
{
  description = "Mathlib declaration: Algebra.Homology.DerivedCategory.Ext.ExactSequences";
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
        pname = "decl-Algebra.Homology.DerivedCategory.Ext.ExactSequences";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Homology/DerivedCategory/Ext/ExactSequences.lean $out/
        '';
      };
    };
}
