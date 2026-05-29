# Generated flake.nix for Algebra.Category.ModuleCat.Presheaf.Pushforward
{
  description = "Mathlib declaration: Algebra.Category.ModuleCat.Presheaf.Pushforward";
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
        pname = "decl-Algebra.Category.ModuleCat.Presheaf.Pushforward";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp Algebra/Category/ModuleCat/Presheaf/Pushforward.lean $out/
        '';
      };
    };
}
