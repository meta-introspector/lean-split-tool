# Generated flake.nix for RingTheory.Ideal.Quotient.ChineseRemainder
{
  description = "Mathlib declaration: RingTheory.Ideal.Quotient.ChineseRemainder";
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
        pname = "decl-RingTheory.Ideal.Quotient.ChineseRemainder";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/Ideal/Quotient/ChineseRemainder.lean $out/
        '';
      };
    };
}
