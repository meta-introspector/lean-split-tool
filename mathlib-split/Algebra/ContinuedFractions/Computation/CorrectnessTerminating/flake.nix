# Generated flake.nix for Algebra.ContinuedFractions.Computation.CorrectnessTerminating
{
  description = "Mathlib declaration: Algebra.ContinuedFractions.Computation.CorrectnessTerminating";
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
        pname = "decl-Algebra.ContinuedFractions.Computation.CorrectnessTerminating";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/ContinuedFractions/Computation/CorrectnessTerminating.lean $out/
        '';
      };
    };
}
