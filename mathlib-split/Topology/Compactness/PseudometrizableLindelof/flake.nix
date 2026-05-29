# Generated flake.nix for Topology.Compactness.PseudometrizableLindelof
{
  description = "Mathlib declaration: Topology.Compactness.PseudometrizableLindelof";
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
        pname = "decl-Topology.Compactness.PseudometrizableLindelof";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Topology/Compactness/PseudometrizableLindelof.lean $out/
        '';
      };
    };
}
