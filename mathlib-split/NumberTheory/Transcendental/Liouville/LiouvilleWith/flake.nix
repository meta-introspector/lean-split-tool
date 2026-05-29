# Generated flake.nix for NumberTheory.Transcendental.Liouville.LiouvilleWith
{
  description = "Mathlib declaration: NumberTheory.Transcendental.Liouville.LiouvilleWith";
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
        pname = "decl-NumberTheory.Transcendental.Liouville.LiouvilleWith";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/Transcendental/Liouville/LiouvilleWith.lean $out/
        '';
      };
    };
}
