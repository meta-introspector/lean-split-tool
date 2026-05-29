# Generated flake.nix for Analysis.SpecialFunctions.Log.ENNRealLog
{
  description = "Mathlib declaration: Analysis.SpecialFunctions.Log.ENNRealLog";
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
        pname = "decl-Analysis.SpecialFunctions.Log.ENNRealLog";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp ENNRealLog.lean $out/
        '';
      };
    };
}
