#!/usr/bin/env python3
"""CLI client for lean-split-tool module selection and flake generation."""

import argparse
import os
import re
import sys

SITE_URL = "https://meta-introspector.github.io/lean-split-tool"


def parse_dot_file(dot_path):
    """Parse modules.dot to extract module list"""
    modules = set()
    with open(dot_path, "r") as f:
        content = f.read()
    for m in re.finditer(r'"([^"]+)"\s*->|node\s+"([^"]+)"', content):
        modules.add(m.group(1) or m.group(2))
    return sorted(modules)


def search_modules(modules, term):
    """Search modules by term"""
    term = term.lower()
    return [m for m in modules if term in m.lower()]


def generate_nix_cmd(modules):
    """Generate nix build commands"""
    return (
        "nix build "
        + " \\\n  ".join(
            f'"github:meta-introspector/mathlib4?ref=feature/split&dir={m.replace(".", "/")}"'
            for m in modules
        )
        + " --no-write-lock-file"
    )


def generate_flake(modules, repo=None, branch=None):
    """Generate flake.nix content"""
    repo = repo or "meta-introspector/mathlib4"
    branch = branch or "feature/split"
    inputs = ['    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";']
    for m in modules:
        mod_name = m.replace(".", "_").replace("-", "_")
        inputs.append(
            f'    {mod_name}.url = "github:{repo}?ref={branch}&dir={m.replace(".", "/")}";'
        )

    return f"""{{
  description = "Generated mathlib module flake";
  inputs = {{
{chr(10).join(inputs)}
  }};
  outputs = {{ self, nixpkgs, ... }}@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${{system}};
    in {{
      packages.${{system}}.default = pkgs.stdenv.mkDerivation {{
        pname = "mathlib-modules";
        version = "0.1.0";
        src = ./.;
      }};
    }};
}}"""


def main():
    parser = argparse.ArgumentParser(
        description="Lean Split CLI - Select and build Lean modules"
    )
    parser.add_argument(
        "command",
        choices=["list", "search", "nix", "flake", "build", "split"],
        help="Command to run",
    )
    parser.add_argument(
        "query", nargs="?", help="Search term, module list, or path (for split)"
    )
    parser.add_argument(
        "--dot", default="site/modules.dot", help="Path to modules.dot file"
    )
    parser.add_argument("--output", "-o", help="Output file for flake generation")
    parser.add_argument(
        "--repo",
        default="meta-introspector/mathlib4",
        help="Custom mathlib fork (owner/repo format)",
    )
    parser.add_argument(
        "--branch",
        default="feature/split",
        help="Branch for modular flakes",
    )

    args = parser.parse_args()

    if os.path.exists(args.dot):
        modules = parse_dot_file(args.dot)
    else:
        try:
            import urllib.request

            with urllib.request.urlopen(f"{SITE_URL}/modules.dot") as resp:
                content = resp.read().decode()
            modules = re.findall(r'"([^"]+)"', content)
        except Exception as e:
            print(f"Error fetching modules: {e}")
            sys.exit(1)

    if args.command == "list":
        for m in modules[:50]:
            print(m)
        print(f"... ({len(modules)} total modules)")

    elif args.command == "search":
        if not args.query:
            print("Error: search term required")
            sys.exit(1)
        results = search_modules(modules, args.query)[:50]
        for m in results:
            print(m)
        print(f"Found {len(results)} modules matching '{args.query}'")

    elif args.command == "nix":
        if not args.query:
            print("Error: module list required")
            sys.exit(1)
        selected = args.query.replace(",", " ").split()
        valid = [
            m for m in selected if m in modules or any(m in mod for mod in modules)
        ]
        if not valid:
            print(f"No valid modules found in: {args.query}")
            print("Use 'search <term>' to find modules")
            sys.exit(1)
        print(generate_nix_cmd(valid))

    elif args.command == "flake":
        if not args.query:
            print("Error: module list required")
            sys.exit(1)
        selected = args.query.replace(",", " ").split()
        valid = [
            m for m in selected if m in modules or any(m in mod for mod in modules)
        ]
        content = generate_flake(valid, args.repo, args.branch)
        if args.output:
            with open(args.output, "w") as f:
                f.write(content)
            print(f"Written to {args.output}")
        else:
            print(content)

    elif args.command == "split":
        if not args.query:
            print("Error: path to mathlib source required")
            print(
                "Usage: nix run .#lean-split-cli split /path/to/mathlib --repo owner/repo"
            )
            sys.exit(1)
        print(f"Splitting mathlib at: {args.query}")
        print(f"Target: {args.repo}#{args.branch}")


if __name__ == "__main__":
    main()
