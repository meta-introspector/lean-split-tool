# Generated flake.nix for Algebra.Homology.ShortComplex.FunctorEquivalence
{
  description = "Mathlib declaration: Algebra.Homology.ShortComplex.FunctorEquivalence";
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
        pname = "decl-Algebra.Homology.ShortComplex.FunctorEquivalence";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Homology/ShortComplex/FunctorEquivalence.lean $out/
        '';
      };
    };
}
