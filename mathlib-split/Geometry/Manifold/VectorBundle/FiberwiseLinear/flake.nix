# Generated flake.nix for Geometry.Manifold.VectorBundle.FiberwiseLinear
{
  description = "Mathlib declaration: Geometry.Manifold.VectorBundle.FiberwiseLinear";
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
        pname = "decl-Geometry.Manifold.VectorBundle.FiberwiseLinear";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Geometry/Manifold/VectorBundle/FiberwiseLinear.lean $out/
        '';
      };
    };
}
