# Generated flake.nix for AlgebraicTopology.DoldKan.EquivalencePseudoabelian
{
  description = "Mathlib declaration: AlgebraicTopology.DoldKan.EquivalencePseudoabelian";
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
        pname = "decl-AlgebraicTopology.DoldKan.EquivalencePseudoabelian";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicTopology/DoldKan/EquivalencePseudoabelian.lean $out/
        '';
      };
    };
}
