# Generated flake.nix for GroupTheory.GroupAction.DomAct.ActionHom
{
  description = "Mathlib declaration: GroupTheory.GroupAction.DomAct.ActionHom";
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
        pname = "decl-GroupTheory.GroupAction.DomAct.ActionHom";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp GroupTheory/GroupAction/DomAct/ActionHom.lean $out/
        '';
      };
    };
}
