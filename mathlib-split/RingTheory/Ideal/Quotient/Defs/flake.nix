# Generated flake.nix for RingTheory.Ideal.Quotient.Defs
{
  description = "Mathlib declaration: RingTheory.Ideal.Quotient.Defs";
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
        pname = "decl-RingTheory.Ideal.Quotient.Defs";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/Ideal/Quotient/Defs.lean $out/
        '';
      };
    };
}
