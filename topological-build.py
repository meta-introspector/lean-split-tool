#!/usr/bin/env python3
import os
import re
from collections import defaultdict

SOURCE_DIR = "/mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib"
REPO_PATH = "/mnt/data1/git/github.com/leanprover-community/mathlib4.git"
BRANCH = "feature/split"


def parse_imports(filepath):
    imports = []
    with open(filepath, "r") as f:
        for line in f:
            m = re.match(r"import\s+(Mathlib\.[^.]+(?:\.[^.]+)*)", line)
            if m:
                imports.append(m.group(1))
            m = re.match(r"import\s+Mathlib\.([^/\n]+)", line)
            if m:
                imports.append("Mathlib." + m.group(1))
    return imports


def get_module_path(module_name):
    return module_name.replace(".", "/")


def build_dep_graph():
    graph = defaultdict(set)
    all_modules = set()

    for root, dirs, files in os.walk(SOURCE_DIR):
        for f in files:
            if f.endswith(".lean"):
                path = os.path.join(root, f)
                rel = path[len(SOURCE_DIR) + 1 :]
                module = rel[:-5].replace("/", ".")
                all_modules.add(module)
                imports = parse_imports(path)
                for imp in imports:
                    graph[module].add(imp)

    return graph, all_modules


def topological_sort(graph, all_modules):
    in_degree = defaultdict(int)
    for m in all_modules:
        in_degree[m] = 0

    for m, deps in graph.items():
        for d in deps:
            if d in all_modules:
                in_degree[m] += 1

    queue = [m for m in all_modules if in_degree[m] == 0]
    result = []

    while queue:
        m = queue.pop(0)
        result.append(m)
        for dependent in all_modules:
            if m in graph.get(dependent, set()):
                in_degree[dependent] -= 1
                if in_degree[dependent] == 0:
                    queue.append(dependent)

    return result


def build_modules(module_list):
    built = 0
    for module in module_list:
        module_path = get_module_path(module)
        url = f"git+file://{REPO_PATH}?ref={BRANCH}&dir={module_path}"
        print(f"Building {module} -> {url}")
        os.system(f"nix build --no-write-lock-file '{url}' 2>&1 | tail -3")
        built += 1
    print(f"Built {built} modules")


if __name__ == "__main__":
    graph, all_modules = build_dep_graph()
    sorted_modules = topological_sort(graph, all_modules)
    print(f"Topologically sorted {len(sorted_modules)} modules")
    print("Building in dependency order (first 20):")
    build_modules(sorted_modules[:20])
    print("\nShowing modules that depend on Init:")
    init_deps = [m for m in sorted_modules if "Init" in graph.get(m, set())]
    print(f"Modules importing Init: {init_deps[:10]}")
    print(f"\nVerifying topological order - first 10 modules (roots with no deps):")
    for m in sorted_modules[:10]:
        print(f"  {m} -> deps: {graph.get(m, set())}")
