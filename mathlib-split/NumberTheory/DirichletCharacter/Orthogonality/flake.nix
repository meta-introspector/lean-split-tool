# Generated flake.nix for NumberTheory.DirichletCharacter.Orthogonality
{
  description = "Mathlib declaration: NumberTheory.DirichletCharacter.Orthogonality";
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
        pname = "decl-NumberTheory.DirichletCharacter.Orthogonality";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/DirichletCharacter/Orthogonality.lean $out/
        '';
      };
    };
}
