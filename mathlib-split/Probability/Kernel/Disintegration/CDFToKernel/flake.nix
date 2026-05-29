# Generated flake.nix for Probability.Kernel.Disintegration.CDFToKernel
{
  description = "Mathlib declaration: Probability.Kernel.Disintegration.CDFToKernel";
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
        pname = "decl-Probability.Kernel.Disintegration.CDFToKernel";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Probability/Kernel/Disintegration/CDFToKernel.lean $out/
        '';
      };
    };
}
