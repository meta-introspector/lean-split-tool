# Generated flake.nix for Probability.Moments.CovarianceBilinDual
{
  description = "Mathlib declaration: Probability.Moments.CovarianceBilinDual";
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
        pname = "decl-Probability.Moments.CovarianceBilinDual";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Probability/Moments/CovarianceBilinDual.lean $out/
        '';
      };
    };
}
