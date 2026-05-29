# Generated flake.nix for MeasureTheory.Integral.Bochner.ContinuousLinearMap
{
  description = "Mathlib declaration: MeasureTheory.Integral.Bochner.ContinuousLinearMap";
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
        pname = "decl-MeasureTheory.Integral.Bochner.ContinuousLinearMap";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp ContinuousLinearMap.lean $out/
        '';
      };
    };
}
