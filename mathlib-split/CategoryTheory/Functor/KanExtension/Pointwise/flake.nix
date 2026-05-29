# Generated flake.nix for CategoryTheory.Functor.KanExtension.Pointwise
{
  description = "Mathlib declaration: CategoryTheory.Functor.KanExtension.Pointwise";
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
        pname = "decl-CategoryTheory.Functor.KanExtension.Pointwise";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Functor/KanExtension/Pointwise.lean $out/
        '';
      };
    };
}
