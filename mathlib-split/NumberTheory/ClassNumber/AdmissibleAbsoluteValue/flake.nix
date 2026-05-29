# Generated flake.nix for NumberTheory.ClassNumber.AdmissibleAbsoluteValue
{
  description = "Mathlib declaration: NumberTheory.ClassNumber.AdmissibleAbsoluteValue";
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
        pname = "decl-NumberTheory.ClassNumber.AdmissibleAbsoluteValue";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/ClassNumber/AdmissibleAbsoluteValue.lean $out/
        '';
      };
    };
}
