# Generated flake.nix for NumberTheory.ModularForms.EisensteinSeries.Summable
{
  description = "Mathlib declaration: NumberTheory.ModularForms.EisensteinSeries.Summable";
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
        pname = "decl-NumberTheory.ModularForms.EisensteinSeries.Summable";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp NumberTheory/ModularForms/EisensteinSeries/Summable.lean $out/
        '';
      };
    };
}
