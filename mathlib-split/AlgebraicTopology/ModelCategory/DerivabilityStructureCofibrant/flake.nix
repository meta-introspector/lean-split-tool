# Generated flake.nix for AlgebraicTopology.ModelCategory.DerivabilityStructureCofibrant
{
  description = "Mathlib declaration: AlgebraicTopology.ModelCategory.DerivabilityStructureCofibrant";
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
        pname = "decl-AlgebraicTopology.ModelCategory.DerivabilityStructureCofibrant";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp AlgebraicTopology/ModelCategory/DerivabilityStructureCofibrant.lean $out/
        '';
      };
    };
}
