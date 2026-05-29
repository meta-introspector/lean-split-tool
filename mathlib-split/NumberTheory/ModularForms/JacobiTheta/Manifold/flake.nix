# Generated flake.nix for NumberTheory.ModularForms.JacobiTheta.Manifold
{
  description = "Mathlib declaration: NumberTheory.ModularForms.JacobiTheta.Manifold";
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
        pname = "decl-NumberTheory.ModularForms.JacobiTheta.Manifold";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/ModularForms/JacobiTheta/Manifold.lean $out/
        '';
      };
    };
}
