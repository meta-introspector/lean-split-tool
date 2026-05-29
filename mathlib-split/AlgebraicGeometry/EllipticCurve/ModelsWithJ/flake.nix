# Generated flake.nix for AlgebraicGeometry.EllipticCurve.ModelsWithJ
{
  description = "Mathlib declaration: AlgebraicGeometry.EllipticCurve.ModelsWithJ";
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
        pname = "decl-AlgebraicGeometry.EllipticCurve.ModelsWithJ";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicGeometry/EllipticCurve/ModelsWithJ.lean $out/
        '';
      };
    };
}
