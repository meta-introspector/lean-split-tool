# Generated flake.nix for CategoryTheory.Preadditive.Projective.Preserves
{
  description = "Mathlib declaration: CategoryTheory.Preadditive.Projective.Preserves";
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
        pname = "decl-CategoryTheory.Preadditive.Projective.Preserves";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Preadditive/Projective/Preserves.lean $out/
        '';
      };
    };
}
