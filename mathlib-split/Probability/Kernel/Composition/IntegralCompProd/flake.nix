# Generated flake.nix for Probability.Kernel.Composition.IntegralCompProd
{
  description = "Mathlib declaration: Probability.Kernel.Composition.IntegralCompProd";
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
        pname = "decl-Probability.Kernel.Composition.IntegralCompProd";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Probability/Kernel/Composition/IntegralCompProd.lean $out/
        '';
      };
    };
}
