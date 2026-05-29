# Generated flake.nix for RingTheory.Noetherian.UniqueFactorizationDomain
{
  description = "Mathlib declaration: RingTheory.Noetherian.UniqueFactorizationDomain";
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
        pname = "decl-RingTheory.Noetherian.UniqueFactorizationDomain";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/Noetherian/UniqueFactorizationDomain.lean $out/
        '';
      };
    };
}
