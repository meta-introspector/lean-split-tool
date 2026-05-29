# Generated flake.nix for Analysis.Calculus.BumpFunction.FiniteDimension
{
  description = "Mathlib declaration: Analysis.Calculus.BumpFunction.FiniteDimension";
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
        pname = "decl-Analysis.Calculus.BumpFunction.FiniteDimension";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp FiniteDimension.lean $out/
        '';
      };
    };
}
