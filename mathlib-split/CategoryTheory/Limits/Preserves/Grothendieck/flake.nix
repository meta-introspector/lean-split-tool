# Generated flake.nix for CategoryTheory.Limits.Preserves.Grothendieck
{
  description = "Mathlib declaration: CategoryTheory.Limits.Preserves.Grothendieck";
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
        pname = "decl-CategoryTheory.Limits.Preserves.Grothendieck";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Limits/Preserves/Grothendieck.lean $out/
        '';
      };
    };
}
