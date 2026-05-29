# Generated flake.nix for Algebra.Category.ContinuousCohomology.Basic
{
  description = "Mathlib declaration: Algebra.Category.ContinuousCohomology.Basic";
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
        pname = "decl-Algebra.Category.ContinuousCohomology.Basic";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Category/ContinuousCohomology/Basic.lean $out/
        '';
      };
    };
}
