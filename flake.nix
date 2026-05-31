{
  description = "Lean4 split tool for generating per-declaration flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lean4-nix.url = "github:lenianiva/lean4-nix";
  };

  outputs = inputs@{ nixpkgs, lean4-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      leanOverlays = lean4-nix.readToolchainFile ./lean-toolchain;
      leanPkgs = import nixpkgs { inherit system; overlays = [ leanOverlays ]; };
    in
    {
      packages.${system}.default = leanPkgs.lean.lean-all;
      
      apps.${system}.run-split = {
        type = "app";
        program = pkgs.writeShellScript "run-split" ''
          exec ${leanPkgs.lean.lean-all}/bin/lean --run ${./TestFlake.lean}
        '';
      };
      
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          leanPkgs.lean.lean-all
          leanPkgs.lean.lake
          pkgs.git
        ];
      };
    };
}