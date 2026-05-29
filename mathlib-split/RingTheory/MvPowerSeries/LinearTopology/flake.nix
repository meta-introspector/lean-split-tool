# Generated flake.nix for RingTheory.MvPowerSeries.LinearTopology
{
  description = "Mathlib declaration: RingTheory.MvPowerSeries.LinearTopology";
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
        pname = "decl-RingTheory.MvPowerSeries.LinearTopology";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/MvPowerSeries/LinearTopology.lean $out/
        '';
      };
    };
}
