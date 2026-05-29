# Generated flake.nix for LinearAlgebra.Dimension.FreeAndStrongRankCondition
{
  description = "Mathlib declaration: LinearAlgebra.Dimension.FreeAndStrongRankCondition";
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
        pname = "decl-LinearAlgebra.Dimension.FreeAndStrongRankCondition";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp LinearAlgebra/Dimension/FreeAndStrongRankCondition.lean $out/
        '';
      };
    };
}
