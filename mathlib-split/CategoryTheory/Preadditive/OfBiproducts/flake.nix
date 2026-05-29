# Generated flake.nix for CategoryTheory.Preadditive.OfBiproducts
{
  description = "Mathlib declaration: CategoryTheory.Preadditive.OfBiproducts";
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
        pname = "decl-CategoryTheory.Preadditive.OfBiproducts";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Preadditive/OfBiproducts.lean $out/
        '';
      };
    };
}
