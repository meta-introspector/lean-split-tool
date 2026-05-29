# Generated flake.nix for CategoryTheory.Abelian.EpiWithInjectiveKernel
{
  description = "Mathlib declaration: CategoryTheory.Abelian.EpiWithInjectiveKernel";
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
        pname = "decl-CategoryTheory.Abelian.EpiWithInjectiveKernel";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Abelian/EpiWithInjectiveKernel.lean $out/
        '';
      };
    };
}
