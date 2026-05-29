# Generated flake.nix for Analysis.Distribution.AEEqOfIntegralContDiff
{
  description = "Mathlib declaration: Analysis.Distribution.AEEqOfIntegralContDiff";
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
        pname = "decl-Analysis.Distribution.AEEqOfIntegralContDiff";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AEEqOfIntegralContDiff.lean $out/
        '';
      };
    };
}
