# Generated flake.nix for MeasureTheory.Integral.Bochner.VitaliCaratheodory
{
  description = "Mathlib declaration: MeasureTheory.Integral.Bochner.VitaliCaratheodory";
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
        pname = "decl-MeasureTheory.Integral.Bochner.VitaliCaratheodory";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp MeasureTheory/Integral/Bochner/VitaliCaratheodory.lean $out/
        '';
      };
    };
}
