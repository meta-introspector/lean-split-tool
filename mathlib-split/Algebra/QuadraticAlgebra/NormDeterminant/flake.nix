# Generated flake.nix for Algebra.QuadraticAlgebra.NormDeterminant
{
  description = "Mathlib declaration: Algebra.QuadraticAlgebra.NormDeterminant";
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
        pname = "decl-Algebra.QuadraticAlgebra.NormDeterminant";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/QuadraticAlgebra/NormDeterminant.lean $out/
        '';
      };
    };
}
