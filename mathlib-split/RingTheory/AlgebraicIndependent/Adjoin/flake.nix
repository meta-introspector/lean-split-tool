# Generated flake.nix for RingTheory.AlgebraicIndependent.Adjoin
{
  description = "Mathlib declaration: RingTheory.AlgebraicIndependent.Adjoin";
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
        pname = "decl-RingTheory.AlgebraicIndependent.Adjoin";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/AlgebraicIndependent/Adjoin.lean $out/
        '';
      };
    };
}
