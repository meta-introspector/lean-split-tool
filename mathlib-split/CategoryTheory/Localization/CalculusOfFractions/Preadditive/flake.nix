# Generated flake.nix for CategoryTheory.Localization.CalculusOfFractions.Preadditive
{
  description = "Mathlib declaration: CategoryTheory.Localization.CalculusOfFractions.Preadditive";
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
        pname = "decl-CategoryTheory.Localization.CalculusOfFractions.Preadditive";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp CategoryTheory/Localization/CalculusOfFractions/Preadditive.lean $out/
        '';
      };
    };
}
