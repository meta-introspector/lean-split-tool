# Generated flake.nix for Algebra.Ring.Subsemiring.MulOpposite
{
  description = "Mathlib declaration: Algebra.Ring.Subsemiring.MulOpposite";
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
        pname = "decl-Algebra.Ring.Subsemiring.MulOpposite";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Ring/Subsemiring/MulOpposite.lean $out/
        '';
      };
    };
}
