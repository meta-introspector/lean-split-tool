# Generated flake.nix for Algebra.MvPolynomial.NoZeroDivisors
{
  description = "Mathlib declaration: Algebra.MvPolynomial.NoZeroDivisors";
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
        pname = "decl-Algebra.MvPolynomial.NoZeroDivisors";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/MvPolynomial/NoZeroDivisors.lean $out/
        '';
      };
    };
}
