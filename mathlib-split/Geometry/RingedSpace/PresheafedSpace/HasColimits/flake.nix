# Generated flake.nix for Geometry.RingedSpace.PresheafedSpace.HasColimits
{
  description = "Mathlib declaration: Geometry.RingedSpace.PresheafedSpace.HasColimits";
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
        pname = "decl-Geometry.RingedSpace.PresheafedSpace.HasColimits";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Geometry/RingedSpace/PresheafedSpace/HasColimits.lean $out/
        '';
      };
    };
}
