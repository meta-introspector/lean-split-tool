# Generated flake.nix for Tactic.CategoryTheory.Monoidal.PureCoherence
{
  description = "Mathlib declaration: Tactic.CategoryTheory.Monoidal.PureCoherence";
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
        pname = "decl-Tactic.CategoryTheory.Monoidal.PureCoherence";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp PureCoherence.lean $out/
        '';
      };
    };
}
