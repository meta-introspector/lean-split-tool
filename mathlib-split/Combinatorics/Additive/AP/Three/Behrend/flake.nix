# Generated flake.nix for Combinatorics.Additive.AP.Three.Behrend
{
  description = "Mathlib declaration: Combinatorics.Additive.AP.Three.Behrend";
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
        pname = "decl-Combinatorics.Additive.AP.Three.Behrend";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Combinatorics/Additive/AP/Three/Behrend.lean $out/
        '';
      };
    };
}
