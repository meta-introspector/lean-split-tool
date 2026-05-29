# Generated flake.nix for RingTheory.GradedAlgebra.Noetherian
{
  description = "Mathlib declaration: RingTheory.GradedAlgebra.Noetherian";
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
        pname = "decl-RingTheory.GradedAlgebra.Noetherian";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/GradedAlgebra/Noetherian.lean $out/
        '';
      };
    };
}
