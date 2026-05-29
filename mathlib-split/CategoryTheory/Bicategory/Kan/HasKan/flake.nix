# Generated flake.nix for CategoryTheory.Bicategory.Kan.HasKan
{
  description = "Mathlib declaration: CategoryTheory.Bicategory.Kan.HasKan";
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
        pname = "decl-CategoryTheory.Bicategory.Kan.HasKan";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Bicategory/Kan/HasKan.lean $out/
        '';
      };
    };
}
