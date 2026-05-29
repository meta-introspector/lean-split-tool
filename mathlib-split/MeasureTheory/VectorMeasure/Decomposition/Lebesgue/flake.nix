# Generated flake.nix for MeasureTheory.VectorMeasure.Decomposition.Lebesgue
{
  description = "Mathlib declaration: MeasureTheory.VectorMeasure.Decomposition.Lebesgue";
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
        pname = "decl-MeasureTheory.VectorMeasure.Decomposition.Lebesgue";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp MeasureTheory/VectorMeasure/Decomposition/Lebesgue.lean $out/
        '';
      };
    };
}
