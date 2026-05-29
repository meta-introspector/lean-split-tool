# Generated flake.nix for Analysis.CStarAlgebra.SpecialFunctions.PosPart
{
  description = "Mathlib declaration: Analysis.CStarAlgebra.SpecialFunctions.PosPart";
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
        pname = "decl-Analysis.CStarAlgebra.SpecialFunctions.PosPart";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp PosPart.lean $out/
        '';
      };
    };
}
