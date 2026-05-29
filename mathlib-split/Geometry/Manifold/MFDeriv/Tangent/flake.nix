# Generated flake.nix for Geometry.Manifold.MFDeriv.Tangent
{
  description = "Mathlib declaration: Geometry.Manifold.MFDeriv.Tangent";
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
        pname = "decl-Geometry.Manifold.MFDeriv.Tangent";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Geometry/Manifold/MFDeriv/Tangent.lean $out/
        '';
      };
    };
}
