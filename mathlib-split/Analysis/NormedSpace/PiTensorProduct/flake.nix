# Generated flake.nix for Analysis.NormedSpace.PiTensorProduct.ProjectiveSeminorm
{
  description = "Mathlib declaration: Analysis.NormedSpace.PiTensorProduct.ProjectiveSeminorm";
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
        pname = "decl-Analysis.NormedSpace.PiTensorProduct.ProjectiveSeminorm";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp ProjectiveSeminorm.lean $out/
        '';
      };
    };
}
