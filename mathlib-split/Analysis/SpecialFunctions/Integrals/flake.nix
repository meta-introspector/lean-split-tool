# Generated flake.nix for Analysis.SpecialFunctions.Integrals.LogTrigonometric
{
  description = "Mathlib declaration: Analysis.SpecialFunctions.Integrals.LogTrigonometric";
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
        pname = "decl-Analysis.SpecialFunctions.Integrals.LogTrigonometric";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp LogTrigonometric.lean $out/
        '';
      };
    };
}
