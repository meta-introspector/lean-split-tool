# Generated flake.nix for AlgebraicTopology.DoldKan.GammaCompN
{
  description = "Mathlib declaration: AlgebraicTopology.DoldKan.GammaCompN";
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
        pname = "decl-AlgebraicTopology.DoldKan.GammaCompN";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicTopology/DoldKan/GammaCompN.lean $out/
        '';
      };
    };
}
