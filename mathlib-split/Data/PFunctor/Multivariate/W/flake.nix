# Generated flake.nix for Data.PFunctor.Multivariate.W
{
  description = "Mathlib declaration: Data.PFunctor.Multivariate.W";
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
        pname = "decl-Data.PFunctor.Multivariate.W";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Data/PFunctor/Multivariate/W.lean $out/
        '';
      };
    };
}
