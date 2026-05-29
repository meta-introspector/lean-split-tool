# Generated flake.nix for RingTheory.RootsOfUnity.AlgebraicallyClosed
{
  description = "Mathlib declaration: RingTheory.RootsOfUnity.AlgebraicallyClosed";
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
        pname = "decl-RingTheory.RootsOfUnity.AlgebraicallyClosed";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/RootsOfUnity/AlgebraicallyClosed.lean $out/
        '';
      };
    };
}
