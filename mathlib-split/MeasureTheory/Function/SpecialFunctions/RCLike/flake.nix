# Generated flake.nix for MeasureTheory.Function.SpecialFunctions.RCLike
{
  description = "Mathlib declaration: MeasureTheory.Function.SpecialFunctions.RCLike";
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
        pname = "decl-MeasureTheory.Function.SpecialFunctions.RCLike";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp MeasureTheory/Function/SpecialFunctions/RCLike.lean $out/
        '';
      };
    };
}
