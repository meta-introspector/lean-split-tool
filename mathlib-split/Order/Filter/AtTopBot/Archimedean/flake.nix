# Generated flake.nix for Order.Filter.AtTopBot.Archimedean
{
  description = "Mathlib declaration: Order.Filter.AtTopBot.Archimedean";
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
        pname = "decl-Order.Filter.AtTopBot.Archimedean";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Order/Filter/AtTopBot/Archimedean.lean $out/
        '';
      };
    };
}
