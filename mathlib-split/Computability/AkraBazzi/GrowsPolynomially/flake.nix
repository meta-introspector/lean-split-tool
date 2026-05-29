# Generated flake.nix for Computability.AkraBazzi.GrowsPolynomially
{
  description = "Mathlib declaration: Computability.AkraBazzi.GrowsPolynomially";
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
        pname = "decl-Computability.AkraBazzi.GrowsPolynomially";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Computability/AkraBazzi/GrowsPolynomially.lean $out/
        '';
      };
    };
}
