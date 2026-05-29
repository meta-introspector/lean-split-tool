# Generated flake.nix for RingTheory.LocalRing.ResidueField.Ideal
{
  description = "Mathlib declaration: RingTheory.LocalRing.ResidueField.Ideal";
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
        pname = "decl-RingTheory.LocalRing.ResidueField.Ideal";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/LocalRing/ResidueField/Ideal.lean $out/
        '';
      };
    };
}
