# Generated flake.nix for AlgebraicTopology.SimplicialSet.AnodyneExtensions.Rank
{
  description = "Mathlib declaration: AlgebraicTopology.SimplicialSet.AnodyneExtensions.Rank";
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
        pname = "decl-AlgebraicTopology.SimplicialSet.AnodyneExtensions.Rank";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicTopology/SimplicialSet/AnodyneExtensions/Rank.lean $out/
        '';
      };
    };
}
