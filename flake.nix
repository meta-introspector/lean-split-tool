{
  description = "Mathlib modular flakes - generate per-module Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      apps.${system}.generate-split = {
        type = "app";
        program = "${./split-mathlib.sh}";
      };
      
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.lean4 pkgs.git ];
        shellHook = ''
          echo "Modular mathlib flake tool"
          echo "Run: nix run .#generate-split to publish flakes to bare repo"
        '';
      };
    };
}