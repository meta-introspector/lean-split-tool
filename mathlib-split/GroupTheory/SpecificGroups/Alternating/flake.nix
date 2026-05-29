# Generated flake.nix for GroupTheory.SpecificGroups.Alternating.Centralizer
{
  description = "Mathlib declaration: GroupTheory.SpecificGroups.Alternating.Centralizer";
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
        pname = "decl-GroupTheory.SpecificGroups.Alternating.Centralizer";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Centralizer.lean $out/
        '';
      };
    };
}
