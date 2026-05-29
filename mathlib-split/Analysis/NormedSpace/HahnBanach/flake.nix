# Generated flake.nix for Analysis.NormedSpace.HahnBanach.Separation
{
  description = "Mathlib declaration: Analysis.NormedSpace.HahnBanach.Separation";
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
        pname = "decl-Analysis.NormedSpace.HahnBanach.Separation";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Separation.lean $out/
        '';
      };
    };
}
