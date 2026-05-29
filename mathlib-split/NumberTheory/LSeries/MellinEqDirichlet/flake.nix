# Generated flake.nix for NumberTheory.LSeries.MellinEqDirichlet
{
  description = "Mathlib declaration: NumberTheory.LSeries.MellinEqDirichlet";
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
        pname = "decl-NumberTheory.LSeries.MellinEqDirichlet";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/LSeries/MellinEqDirichlet.lean $out/
        '';
      };
    };
}
