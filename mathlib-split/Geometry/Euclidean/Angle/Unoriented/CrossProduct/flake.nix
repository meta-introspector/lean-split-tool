# Generated flake.nix for Geometry.Euclidean.Angle.Unoriented.CrossProduct
{
  description = "Mathlib declaration: Geometry.Euclidean.Angle.Unoriented.CrossProduct";
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
        pname = "decl-Geometry.Euclidean.Angle.Unoriented.CrossProduct";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Geometry/Euclidean/Angle/Unoriented/CrossProduct.lean $out/
        '';
      };
    };
}
