# Generated flake.nix for Data.QPF.Multivariate.Constructions.Cofix
{
  description = "Mathlib declaration: Data.QPF.Multivariate.Constructions.Cofix";
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
        pname = "decl-Data.QPF.Multivariate.Constructions.Cofix";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Cofix.lean $out/
        '';
      };
    };
}
