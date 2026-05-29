# Generated flake.nix for Algebra.GroupWithZero.Pointwise.Set.Basic
{
  description = "Mathlib declaration: Algebra.GroupWithZero.Pointwise.Set.Basic";
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
        pname = "decl-Algebra.GroupWithZero.Pointwise.Set.Basic";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/GroupWithZero/Pointwise/Set/Basic.lean $out/
        '';
      };
    };
}
