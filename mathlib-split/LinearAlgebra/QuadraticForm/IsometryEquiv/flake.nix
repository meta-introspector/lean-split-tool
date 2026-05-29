# Generated flake.nix for LinearAlgebra.QuadraticForm.IsometryEquiv
{
  description = "Mathlib declaration: LinearAlgebra.QuadraticForm.IsometryEquiv";
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
        pname = "decl-LinearAlgebra.QuadraticForm.IsometryEquiv";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp LinearAlgebra/QuadraticForm/IsometryEquiv.lean $out/
        '';
      };
    };
}
