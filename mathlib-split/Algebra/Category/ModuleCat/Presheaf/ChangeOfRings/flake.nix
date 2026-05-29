# Generated flake.nix for Algebra.Category.ModuleCat.Presheaf.ChangeOfRings
{
  description = "Mathlib declaration: Algebra.Category.ModuleCat.Presheaf.ChangeOfRings";
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
        pname = "decl-Algebra.Category.ModuleCat.Presheaf.ChangeOfRings";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Category/ModuleCat/Presheaf/ChangeOfRings.lean $out/
        '';
      };
    };
}
