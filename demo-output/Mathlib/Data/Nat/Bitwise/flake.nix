# Generated flake.nix for Mathlib.Data.Nat.Bitwise with dependencies
{
  description = "Mathlib declaration: Mathlib.Data.Nat.Bitwise";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    Mathlib-Data-Nat-Prime.url = "git+file:///mnt/data1/git/github.com/leanprover-community/mathlib4/?ref=feature/split&dir=Mathlib/Data/Nat/Prime";
  };
  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "decl-Mathlib.Data.Nat.Bitwise";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Mathlib/Data/Nat/Bitwise.lean $out/
        '';
      };
    };
}