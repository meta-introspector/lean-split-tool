# Generated flake.nix for MeasureTheory.MeasurableSpace.EventuallyMeasurable
{
  description = "Mathlib declaration: MeasureTheory.MeasurableSpace.EventuallyMeasurable";
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
        pname = "decl-MeasureTheory.MeasurableSpace.EventuallyMeasurable";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp MeasureTheory/MeasurableSpace/EventuallyMeasurable.lean $out/
        '';
      };
    };
}
