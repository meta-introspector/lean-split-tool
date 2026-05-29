# Generated flake.nix for AlgebraicTopology.SimplicialSet.FiniteColimits
{
  description = "Mathlib declaration: AlgebraicTopology.SimplicialSet.FiniteColimits";
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
        pname = "decl-AlgebraicTopology.SimplicialSet.FiniteColimits";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicTopology/SimplicialSet/FiniteColimits.lean $out/
        '';
      };
    };
}
