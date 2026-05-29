# Generated flake.nix for Analysis.SpecialFunctions.ContinuousFunctionalCalculus.Abs
{
  description = "Mathlib declaration: Analysis.SpecialFunctions.ContinuousFunctionalCalculus.Abs";
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
        pname = "decl-Analysis.SpecialFunctions.ContinuousFunctionalCalculus.Abs";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Abs.lean $out/
        '';
      };
    };
}
