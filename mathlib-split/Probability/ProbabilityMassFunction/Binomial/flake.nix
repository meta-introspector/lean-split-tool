# Generated flake.nix for Probability.ProbabilityMassFunction.Binomial
{
  description = "Mathlib declaration: Probability.ProbabilityMassFunction.Binomial";
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
        pname = "decl-Probability.ProbabilityMassFunction.Binomial";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Probability/ProbabilityMassFunction/Binomial.lean $out/
        '';
      };
    };
}
