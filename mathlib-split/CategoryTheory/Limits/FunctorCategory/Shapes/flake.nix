# Generated flake.nix for CategoryTheory.Limits.FunctorCategory.Shapes.Pullbacks
{
  description = "Mathlib declaration: CategoryTheory.Limits.FunctorCategory.Shapes.Pullbacks";
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
        pname = "decl-CategoryTheory.Limits.FunctorCategory.Shapes.Pullbacks";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Pullbacks.lean $out/
        '';
      };
    };
}
