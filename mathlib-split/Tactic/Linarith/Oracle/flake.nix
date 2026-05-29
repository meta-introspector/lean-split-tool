# Generated flake.nix for Tactic.Linarith.Oracle.SimplexAlgorithm
{
  description = "Mathlib declaration: Tactic.Linarith.Oracle.SimplexAlgorithm";
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
        pname = "decl-Tactic.Linarith.Oracle.SimplexAlgorithm";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp SimplexAlgorithm.lean $out/
        '';
      };
    };
}
