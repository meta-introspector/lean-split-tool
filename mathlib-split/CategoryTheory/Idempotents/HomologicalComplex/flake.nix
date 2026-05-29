# Generated flake.nix for CategoryTheory.Idempotents.HomologicalComplex
{
  description = "Mathlib declaration: CategoryTheory.Idempotents.HomologicalComplex";
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
        pname = "decl-CategoryTheory.Idempotents.HomologicalComplex";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Idempotents/HomologicalComplex.lean $out/
        '';
      };
    };
}
