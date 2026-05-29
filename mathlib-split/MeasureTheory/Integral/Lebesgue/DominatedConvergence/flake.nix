# Generated flake.nix for MeasureTheory.Integral.Lebesgue.DominatedConvergence
{
  description = "Mathlib declaration: MeasureTheory.Integral.Lebesgue.DominatedConvergence";
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
        pname = "decl-MeasureTheory.Integral.Lebesgue.DominatedConvergence";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp MeasureTheory/Integral/Lebesgue/DominatedConvergence.lean $out/
        '';
      };
    };
}
