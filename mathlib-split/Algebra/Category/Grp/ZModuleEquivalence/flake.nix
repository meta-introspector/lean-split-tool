# Generated flake.nix for Algebra.Category.Grp.ZModuleEquivalence
{
  description = "Mathlib declaration: Algebra.Category.Grp.ZModuleEquivalence";
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
        pname = "decl-Algebra.Category.Grp.ZModuleEquivalence";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Category/Grp/ZModuleEquivalence.lean $out/
        '';
      };
    };
}
