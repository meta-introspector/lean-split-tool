#!/usr/bin/env python3
import os
import shutil

OUTPUT_DIR = os.environ.get("OUTPUT_DIR", "./mathlib-split")
SOURCE_DIR = "/mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib"

os.makedirs(OUTPUT_DIR, exist_ok=True)

# Find all .lean files
lean_files = []
for root, dirs, files in os.walk(SOURCE_DIR):
    for f in files:
        if f.endswith(".lean"):
            lean_files.append(os.path.join(root, f))

print(f"Found {len(lean_files)} .lean files")

for lean_file in lean_files:
    rel_path = lean_file[len(SOURCE_DIR) + 1 :]
    module_name = rel_path[:-5].replace("/", ".")
    out_dir = os.path.join(OUTPUT_DIR, os.path.dirname(rel_path))
    os.makedirs(out_dir, exist_ok=True)

    flake_content = f"""# Generated flake.nix for {module_name}
{{
  description = "Mathlib declaration: {module_name}";
  inputs = {{
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  }};
  outputs = {{ self, nixpkgs, flake-utils }}:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${{system}};
    in {{
      packages.${{system}}.default = pkgs.stdenv.mkDerivation {{
        pname = "decl-{module_name}";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp {os.path.basename(rel_path)} $out/
        '';
      }};
    }};
}}
"""
    flake_path = os.path.join(out_dir, "flake.nix")
    with open(flake_path, "w") as f:
        f.write(flake_content)

    shutil.copy(lean_file, out_dir)
    print(f"Generated: {module_name}")

print(f"Done. Generated flakes for {len(lean_files)} modules")
