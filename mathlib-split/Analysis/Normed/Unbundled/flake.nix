# Generated flake.nix for Analysis.Normed.Unbundled.FiniteExtension
{
  description = "Mathlib declaration: Analysis.Normed.Unbundled.FiniteExtension";
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
        pname = "decl-Analysis.Normed.Unbundled.FiniteExtension";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp FiniteExtension.lean $out/
        '';
      };
    };
}
