# Generated flake.nix for Algebra.Order.Monoid.Unbundled.TypeTags
{
  description = "Mathlib declaration: Algebra.Order.Monoid.Unbundled.TypeTags";
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
        pname = "decl-Algebra.Order.Monoid.Unbundled.TypeTags";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Order/Monoid/Unbundled/TypeTags.lean $out/
        '';
      };
    };
}
