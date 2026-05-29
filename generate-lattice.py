#!/usr/bin/env python3
import os
import re
from collections import defaultdict

SOURCE_DIR = "/mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib"
REPO_URL = "git+file:///mnt/data1/git/github.com/leanprover-community/mathlib4.git"
BRANCH = "feature/split"


def parse_imports(filepath):
    imports = []
    with open(filepath, "r") as f:
        content = f.read()
    for m in re.finditer(r"import\s+Mathlib\.([^/\s]+)", content):
        imports.append("Mathlib." + m.group(1))
    return imports


def generate_flake_with_deps(module, deps, output_path):
    dep_inputs = []
    dep_paths = []
    for dep in deps:
        dep_path = dep.replace(".", "/")
        dep_inputs.append(
            f'    {dep.replace(".", "_").replace("-", "_")} = "{REPO_URL}?ref={BRANCH}&dir={dep_path}";'
        )
        dep_paths.append(
            f"    {dep.replace('.', '_').replace('-', '_')}.packages.x86_64-linux.default"
        )

    inputs_section = "\n".join(dep_inputs)
    deps_section = " ".join(dep_paths)

    flake = f"""# Generated flake.nix for {module}
{{
  description = "Mathlib module: {module}";
  inputs = {{
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
{inputs_section}
  }};
  outputs = {{ self, nixpkgs, flake-utils, ... }}:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${{system}};
      dependencies = [ {deps_section} ];
    in {{
      packages.${{system}}.default = pkgs.stdenv.mkDerivation {{
        pname = "mathlib-module-{module}";
        version = "0.1.0";
        src = ./.;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ""
          mkdir -p $out
          cp *.lean $out/
        "";
      }};
    }};
}}
"""
    with open(output_path, "w") as f:
        f.write(flake)


if __name__ == "__main__":
    for root, dirs, files in os.walk(SOURCE_DIR):
        for f in files:
            if f.endswith(".lean"):
                path = os.path.join(root, f)
                rel = path[len(SOURCE_DIR) + 1 :]
                module = rel[:-5].replace("/", ".")
                imports = parse_imports(path)
                out_dir = os.path.join(
                    "/home/mdupont/projects/lean-split-tool/mathlib-split",
                    os.path.dirname(rel),
                )
                os.makedirs(out_dir, exist_ok=True)
                generate_flake_with_deps(
                    module, imports, os.path.join(out_dir, "flake.nix")
                )
                print(f"Generated: {module} with {len(imports)} deps")
