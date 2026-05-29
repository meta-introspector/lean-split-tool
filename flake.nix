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
      
      apps.${system}.topological-build = {
        type = "app";
        program = "${pkgs.python3}/bin/python3 ${./topological-build.py}";
      };
      
      apps.${system}.generate-lattice = {
        type = "app";
        program = "${pkgs.python3}/bin/python3 ${./generate-lattice.py}";
      };
      
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.lean4 pkgs.git pkgs.python3 ];
        shellHook = ''
          echo "Modular mathlib flake tool"
          echo "Run: nix run .#generate-split to publish flakes to bare repo"
          echo "Run: nix run .#topological-build to build in dependency order"
        '';
      };
    };
}