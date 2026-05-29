# Generated flake.nix for RingTheory.HopfAlgebra.MonoidAlgebra
{
  description = "Mathlib declaration: RingTheory.HopfAlgebra.MonoidAlgebra";
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
        pname = "decl-RingTheory.HopfAlgebra.MonoidAlgebra";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/HopfAlgebra/MonoidAlgebra.lean $out/
        '';
      };
    };
}
