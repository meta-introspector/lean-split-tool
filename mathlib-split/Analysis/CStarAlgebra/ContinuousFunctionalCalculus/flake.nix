# Generated flake.nix for Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Continuity
{
  description = "Mathlib declaration: Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Continuity";
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
        pname = "decl-Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Continuity";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Continuity.lean $out/
        '';
      };
    };
}
