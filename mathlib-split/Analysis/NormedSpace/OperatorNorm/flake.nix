# Generated flake.nix for Analysis.NormedSpace.OperatorNorm.NNNorm
{
  description = "Mathlib declaration: Analysis.NormedSpace.OperatorNorm.NNNorm";
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
        pname = "decl-Analysis.NormedSpace.OperatorNorm.NNNorm";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NNNorm.lean $out/
        '';
      };
    };
}
