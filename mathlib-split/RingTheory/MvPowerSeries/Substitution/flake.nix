# Generated flake.nix for RingTheory.MvPowerSeries.Substitution
{
  description = "Mathlib declaration: RingTheory.MvPowerSeries.Substitution";
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
        pname = "decl-RingTheory.MvPowerSeries.Substitution";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/MvPowerSeries/Substitution.lean $out/
        '';
      };
    };
}
