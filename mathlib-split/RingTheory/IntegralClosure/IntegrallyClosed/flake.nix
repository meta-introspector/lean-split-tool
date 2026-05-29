# Generated flake.nix for RingTheory.IntegralClosure.IntegrallyClosed
{
  description = "Mathlib declaration: RingTheory.IntegralClosure.IntegrallyClosed";
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
        pname = "decl-RingTheory.IntegralClosure.IntegrallyClosed";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp RingTheory/IntegralClosure/IntegrallyClosed.lean $out/
        '';
      };
    };
}
