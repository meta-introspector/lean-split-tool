# Generated flake.nix for Geometry.RingedSpace.LocallyRingedSpace.ResidueField
{
  description = "Mathlib declaration: Geometry.RingedSpace.LocallyRingedSpace.ResidueField";
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
        pname = "decl-Geometry.RingedSpace.LocallyRingedSpace.ResidueField";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Geometry/RingedSpace/LocallyRingedSpace/ResidueField.lean $out/
        '';
      };
    };
}
