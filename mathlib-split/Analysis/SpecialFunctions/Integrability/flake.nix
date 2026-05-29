# Generated flake.nix for Analysis.SpecialFunctions.Integrability.LogMeromorphic
{
  description = "Mathlib declaration: Analysis.SpecialFunctions.Integrability.LogMeromorphic";
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
        pname = "decl-Analysis.SpecialFunctions.Integrability.LogMeromorphic";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp LogMeromorphic.lean $out/
        '';
      };
    };
}
