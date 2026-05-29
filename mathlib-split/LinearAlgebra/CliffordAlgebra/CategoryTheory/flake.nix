# Generated flake.nix for LinearAlgebra.CliffordAlgebra.CategoryTheory
{
  description = "Mathlib declaration: LinearAlgebra.CliffordAlgebra.CategoryTheory";
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
        pname = "decl-LinearAlgebra.CliffordAlgebra.CategoryTheory";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp LinearAlgebra/CliffordAlgebra/CategoryTheory.lean $out/
        '';
      };
    };
}
