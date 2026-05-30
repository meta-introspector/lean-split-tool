#!/usr/bin/env python3
import os
import re
from collections import defaultdict

SOURCE_DIR = "/mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib"
OUTPUT_DIR = "site"


def parse_imports(filepath):
    imports = []
    with open(filepath, "r") as f:
        content = f.read()
    for m in re.finditer(r"import\s+(Mathlib\.[^\s]+)", content):
        imp = m.group(1).replace("Mathlib.", "", 1)
        imports.append(imp)
    return imports


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
                for imp in parse_imports(path):
                    graph[module].add(imp)
    return graph, all_modules


def generate_dot(graph, all_modules):
    edges = set()
    for m, deps in graph.items():
        for d in deps:
            if d in all_modules:
                edges.add(f'  "{d}" -> "{m}";')
    dot = f'''digraph MathlibModules {{
  rankdir=TB;
  node [shape=box, style=filled, fillcolor=lightblue];
  "{list(all_modules)[0] if all_modules else "root"}";
{chr(10).join(sorted(edges)) if edges else ""}
}}
'''
    return dot


def generate_tree_html(graph, all_modules):
    """Generate interactive HTML tree from DOT dependency graph"""
    # Build reverse graph (what depends on what)
    depended_on = defaultdict(set)
    for m, deps in graph.items():
        for d in deps:
            if d in all_modules:
                depended_on[d].add(m)

    html = """<!DOCTYPE html>
<html>
<head>
<title>Mathlib Module Dependency Tree</title>
<style>
body { font-family: sans-serif; margin: 20px; background: #f5f5f5; }
.container { max-width: 1400px; margin: 0 auto; }
h1 { color: #333; }
.tree { background: white; padding: 20px; border-radius: 8px; }
.tree-node { margin: 5px 0; padding-left: 20px; border-left: 2px solid #ddd; }
.tree-toggle { cursor: pointer; color: #2196f3; }
.tree-children { margin-left: 20px; display: none; }
.module-link { color: #333; text-decoration: none; font-family: monospace; }
.module-link:hover { text-decoration: underline; }
.search-box { width: 100%; padding: 10px; margin: 10px 0; font-size: 16px; }
</style>
</head>
<body>
<div class="container">
<h1>Mathlib Module Dependency Tree</h1>
<p>Interactive dependency tree. Root modules (no dependencies) are at the top.</p>
<input type="text" class="search-box" id="search" onkeyup="filterTree()" placeholder="Search modules...">
<div class="tree" id="tree">
"""

    # Find root modules (no incoming edges in the original graph, i.e., no dependencies)
    roots = [
        m for m in all_modules if m not in {d for deps in graph.values() for d in deps}
    ]

    def render_tree(modules, depth=0):
        result = ""
        for m in sorted(modules)[:100]:  # Limit for performance
            children = depended_on.get(m, set())
            result += f'<div class="tree-node" style="padding-left: {depth * 30}px">'
            if children:
                result += (
                    f'<span class="tree-toggle" onclick="toggleTree(this)">▶</span> '
                )
            mod_path = m.replace(".", "/")
            result += (
                f'<a class="module-link" href="index.html#{m}" data-name="{m}">{m}</a>'
            )
            if children:
                result += f'<div class="tree-children">{render_tree(children, depth + 1)}</div>'
            result += "</div>\n"
        return result

    html += render_tree(roots)
    html += """</div>
<script>
function toggleTree(el) {
  const next = el.nextElementSibling;
  if (next && next.classList.contains('tree-children')) {
    next.style.display = next.style.display === 'none' ? 'block' : 'none';
    el.textContent = next.style.display === 'none' ? '▶' : '▼';
  }
}
function filterTree() {
  const term = document.getElementById('search').value.toLowerCase();
  document.querySelectorAll('.tree-node').forEach(node => {
    const name = node.querySelector('.module-link').dataset.name;
    node.style.display = name.toLowerCase().includes(term) ? '' : 'none';
  });
}
</script>
</div>
</body>
</html>
"""
    return html


def generate_html(graph, all_modules):
    modules_by_prefix = defaultdict(list)
    for m in sorted(all_modules):
        parts = m.split(".")
        if len(parts) > 1:
            prefix = ".".join(parts[:-1])
            modules_by_prefix[prefix].append(m)
        else:
            modules_by_prefix["_root_"].append(m)

    html = """<!DOCTYPE html>
<html>
<head>
<title>Lean Mathlib Module Selector</title>
<style>
body { font-family: sans-serif; margin: 20px; background: #f5f5f5; }
.container { max-width: 1200px; margin: 0 auto; }
h1 { color: #333; }
.search-box { width: 100%; padding: 10px; margin: 10px 0; font-size: 16px; }
.module-tree { background: white; padding: 20px; border-radius: 8px; }
.module { padding: 5px 10px; cursor: pointer; border-bottom: 1px solid #eee; }
.module:hover { background: #e3f2fd; }
.module.selected { background: #2196f3; color: white; }
.btn { background: #2196f3; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin: 5px; }
.btn:hover { background: #1976d2; }
#selected { margin-top: 20px; padding: 10px; background: white; border-radius: 8px; }
pre { background: #eee; padding: 10px; border-radius: 4px; overflow-x: auto; }
code { font-family: monospace; }
</style>
</head>
<body>
<div class="container">
<h1>Lean Mathlib Module Selector</h1>
<p>Select modules to build. <a href="llm.txt">LLM Instructions</a> | Dependency tree: <a href="tree.html">tree.html</a> | DOT graph: <a href="modules.dot">modules.dot</a></p>
<input type="text" class="search-box" id="search" onkeyup="filterModules()" placeholder="Search modules (e.g., Algebra, Graph, SimpleGraph)...">
<div class="module-tree" id="modules">
"""
    for prefix in sorted(modules_by_prefix.keys()):
        html += f'<div class="module-category"><strong>{prefix}:</strong></div>\n'
        for m in modules_by_prefix[prefix]:
            deps = ", ".join([d for d in graph.get(m, set()) if d in all_modules][:3])
            html += f'<div class="module" onclick="toggle(this)" data-name="{m}">{m} <small>({deps}...)</small></div>\n'

    html += """</div>
<div id="selected">
<h3>Selected Modules</h3>
<p id="selection"></p>
<button class="btn" onclick="downloadNix()">Generate Nix Commands</button>
<button class="btn" onclick="generateFlake()">Generate Flake.nix</button>
</div>
<div id="output" style="margin-top: 20px; display: none;">
<h3>Generated Output</h3>
<pre id="result"><code></code></pre>
</div>
<script>
function toggle(el) {
  el.classList.toggle('selected');
  updateSelection();
}
function updateSelection() {
  const sel = Array.from(document.querySelectorAll('.module.selected')).map(m => m.dataset.name);
  document.getElementById('selection').textContent = sel.join(', ') || 'None selected';
}
function filterModules() {
  const term = document.getElementById('search').value.toLowerCase();
  document.querySelectorAll('.module').forEach(m => {
    m.style.display = m.dataset.name.toLowerCase().includes(term) ? '' : 'none';
  });
}
function downloadNix() {
  const sel = Array.from(document.querySelectorAll('.module.selected')).map(m => m.dataset.name);
  if (sel.length === 0) {
    alert('No modules selected. Click on modules to select them.');
    return;
  }
  const cmd = 'nix build ' + sel.map(m => `\`github:meta-introspector/mathlib4?ref=feature/split&dir=\${m.replace(".", "/")}\``).join(' \\\n  ');
  showOutput(cmd);
}
function generateFlake() {
  const sel = Array.from(document.querySelectorAll('.module.selected')).map(m => m.dataset.name);
  if (sel.length === 0) {
    alert('No modules selected. Click on modules to select them.');
    return;
  }
  let flake = `{
  description = "Generated mathlib module flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
`;
  for (const m of sel) {
    const modName = m.replace(/\./g, '_').replace(/-/g, '_');
    flake += `    ${modName}.url = "github:meta-introspector/mathlib4?ref=feature/split&dir=${m.replace('.', '/')}";\n`;
  }
  flake += `  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "mathlib-modules";
        version = "0.1.0";
        src = ./.;
      };
    };
}`;
  showOutput(flake);
}
function showOutput(content) {
  document.getElementById('result').textContent = content;
  document.getElementById('output').style.display = 'block';
}
</script>
</div>
</body>
</html>
"""
    return html


if __name__ == "__main__":
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    graph, all_modules = build_dep_graph()

    with open(os.path.join(OUTPUT_DIR, "modules.dot"), "w") as f:
        f.write(generate_dot(graph, all_modules))

    with open(os.path.join(OUTPUT_DIR, "index.html"), "w") as f:
        f.write(generate_html(graph, all_modules))

    with open(os.path.join(OUTPUT_DIR, "tree.html"), "w") as f:
        f.write(generate_tree_html(graph, all_modules))

    print(f"Generated {len(all_modules)} modules in {OUTPUT_DIR}/")
