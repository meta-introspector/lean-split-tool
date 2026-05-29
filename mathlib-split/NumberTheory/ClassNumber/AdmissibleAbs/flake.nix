# Generated flake.nix for NumberTheory.ClassNumber.AdmissibleAbs
{
  description = "Mathlib declaration: NumberTheory.ClassNumber.AdmissibleAbs";
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
        pname = "decl-NumberTheory.ClassNumber.AdmissibleAbs";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/ClassNumber/AdmissibleAbs.lean $out/
        '';
      };
    };
}
