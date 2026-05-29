# Generated flake.nix for Algebra.Homology.HomotopyCategory.ShiftSequence
{
  description = "Mathlib declaration: Algebra.Homology.HomotopyCategory.ShiftSequence";
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
        pname = "decl-Algebra.Homology.HomotopyCategory.ShiftSequence";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Homology/HomotopyCategory/ShiftSequence.lean $out/
        '';
      };
    };
}
