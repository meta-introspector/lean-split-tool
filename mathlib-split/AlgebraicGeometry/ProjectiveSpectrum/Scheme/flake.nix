# Generated flake.nix for AlgebraicGeometry.ProjectiveSpectrum.Scheme
{
  description = "Mathlib declaration: AlgebraicGeometry.ProjectiveSpectrum.Scheme";
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
        pname = "decl-AlgebraicGeometry.ProjectiveSpectrum.Scheme";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicGeometry/ProjectiveSpectrum/Scheme.lean $out/
        '';
      };
    };
}
