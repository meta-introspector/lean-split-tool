# Generated flake.nix for AlgebraicTopology.Quasicategory.StrictBicategory
{
  description = "Mathlib declaration: AlgebraicTopology.Quasicategory.StrictBicategory";
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
        pname = "decl-AlgebraicTopology.Quasicategory.StrictBicategory";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicTopology/Quasicategory/StrictBicategory.lean $out/
        '';
      };
    };
}
