# Generated flake.nix for MeasureTheory.Function.StronglyMeasurable.Lp
{
  description = "Mathlib declaration: MeasureTheory.Function.StronglyMeasurable.Lp";
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
        pname = "decl-MeasureTheory.Function.StronglyMeasurable.Lp";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp MeasureTheory/Function/StronglyMeasurable/Lp.lean $out/
        '';
      };
    };
}
