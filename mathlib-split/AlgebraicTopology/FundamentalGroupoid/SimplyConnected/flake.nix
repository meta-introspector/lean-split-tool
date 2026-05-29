# Generated flake.nix for AlgebraicTopology.FundamentalGroupoid.SimplyConnected
{
  description = "Mathlib declaration: AlgebraicTopology.FundamentalGroupoid.SimplyConnected";
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
        pname = "decl-AlgebraicTopology.FundamentalGroupoid.SimplyConnected";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicTopology/FundamentalGroupoid/SimplyConnected.lean $out/
        '';
      };
    };
}
