# Generated flake.nix for MeasureTheory.Function.LpSpace.DomAct.Continuous
{
  description = "Mathlib declaration: MeasureTheory.Function.LpSpace.DomAct.Continuous";
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
        pname = "decl-MeasureTheory.Function.LpSpace.DomAct.Continuous";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp MeasureTheory/Function/LpSpace/DomAct/Continuous.lean $out/
        '';
      };
    };
}
