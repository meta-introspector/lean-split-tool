# Generated flake.nix for LinearAlgebra.CliffordAlgebra.Inversion
{
  description = "Mathlib declaration: LinearAlgebra.CliffordAlgebra.Inversion";
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
        pname = "decl-LinearAlgebra.CliffordAlgebra.Inversion";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp LinearAlgebra/CliffordAlgebra/Inversion.lean $out/
        '';
      };
    };
}
