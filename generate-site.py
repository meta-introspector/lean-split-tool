#!/usr/bin/env python3
import os
import re
import json
import urllib.request
from collections import defaultdict

SOURCE_DIR = os.environ.get("SOURCE_DIR", "/mnt/data1/time-2026/03-march/23/voa-borcherds-archive/mathlib4/Mathlib")
)
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


def generate_3d_html(graph, all_modules):
    """Generate interactive 3D graph using vis.js with hierarchical layout"""
    nodes = [
        {"id": m, "label": m, "level": m.count(".")} for m in list(all_modules)[:5000]
    ]
    edges = [
        {"from": d, "to": m}
        for m, deps in graph.items()
        for d in deps
        if d in all_modules
    ][:10000]

    with open(os.path.join(OUTPUT_DIR, "graph-data.json"), "w") as f:
        json.dump({"nodes": nodes, "edges": edges}, f)

    return f"""<!DOCTYPE html>
<html>
<head>
<title>Mathlib Dependency Graph</title>
<style>
body {{ margin: 0; font-family: sans-serif; }}
#graph3d {{ width: 100vw; height: 100vh; }}
.overlay {{ position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.9); padding: 10px; border-radius: 5px; z-index: 1000; }}
</style>
</head>
<body>
<div class="overlay">
<h3>Mathlib Dependency Graph (Hierarchical)</h3>
<p>Level = module depth. Drag to move, scroll to zoom. <a href="index.html">Back to selector</a></p>
</div>
<div id="graph3d"></div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vis.js/9.1.6/vis-network.min.js"></script>
<script>
fetch('graph-data.json').then(r => r.json()).then(data => {{
  var nodes = new vis.DataSet(data.nodes);
  var edges = new vis.DataSet(data.edges);
  var container = document.getElementById('graph3d');
  var networkData = {{ nodes: nodes, edges: edges }};
  var options = {{
    layout: {{ 
      hierarchical: {{ 
        direction: "UD", 
        sortMethod: "hubsize",
        nodeSpacing: 150,
        levelSeparation: 200
      }} 
    }},
    physics: {{ stabilization: {{ iterations: 100 }} }},
    interaction: {{ hover: true, navigationButtons: true }},
    nodes: {{ 
      font: {{ size: 12 }},
      shape: "box",
      margin: 10
    }},
    edges: {{ 
      smooth: {{ type: "cubicBezier" }},
      arrows: {{ to: {{ enabled: true, scaleFactor: 0.5 }} }}
    }}
  }};
  var network = new vis.Network(container, networkData, options);
}});
</script>
</body>
</html>
"""


def generate_tree_html(graph, all_modules):
    """Generate interactive HTML tree from DOT dependency graph"""
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

    roots = [
        m for m in all_modules if m not in {d for deps in graph.values() for d in deps}
    ]

    def render_tree(modules, depth=0):
        result = ""
        for m in sorted(modules)[:100]:
            children = depended_on.get(m, set())
            result += f'<div class="tree-node" style="padding-left: {depth * 30}px">'
            if children:
                result += (
                    f'<span class="tree-toggle" onclick="toggleTree(this)">▶</span> '
                )
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
.output-box { background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
.output-content { background: #eee; padding: 10px; border-radius: 4px; overflow-x: auto; font-family: monospace; white-space: pre; }
.btn { background: #2196f3; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin: 5px; }
.btn:hover { background: #1976d2; }
.search-box { width: 100%; padding: 10px; margin: 10px 0; font-size: 16px; }
.module-tree { background: white; padding: 20px; border-radius: 8px; max-height: 600px; overflow-y: auto; }
.module { padding: 5px 10px; cursor: pointer; border-bottom: 1px solid #eee; }
.module:hover { background: #e3f2fd; }
.module.selected { background: #2196f3; color: white; }
.controls { background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
</style>
</head>
<body>
<div class="container">
<h1>Lean Mathlib Module Selector</h1>
<p>Select modules to build. <a href="llm.txt">LLM Instructions</a> | <a href="graph3d.html">3D Graph</a> | <a href="tree.html">Tree</a> | <a href="modules.dot">DOT</a></p>

<div class="controls">
<h3>Generate Commands</h3>
<div id="output" class="output-box" style="display: none; margin-top: 10px;">
<h4>Output:</h4>
<div class="output-content" id="result"></div>
</div>
<button class="btn" onclick="downloadNix()">Generate Nix Commands</button>
<button class="btn" onclick="generateFlake()">Generate Flake.nix</button>
<p id="selection" style="margin-top: 10px; color: #666;">No modules selected. Click modules below to select them.</p>
</div>

<input type="text" class="search-box" id="search" onkeyup="filterModules()" placeholder="Search modules (e.g., Algebra.GradedMonoid, Graph)...">
<div class="module-tree" id="modules">
"""
    for prefix in sorted(modules_by_prefix.keys()):
        html += f'<div class="module-category"><strong>{prefix}:</strong></div>\n'
        for m in modules_by_prefix[prefix]:
            deps = ", ".join([d for d in graph.get(m, set()) if d in all_modules][:3])
            html += f'<div class="module" onclick="toggle(this)" data-name="{m}">{m} <small>({deps}...)</small></div>\n'

    html += """</div>
<script>
function toggle(el) {
  el.classList.toggle('selected');
  updateSelection();
}
function updateSelection() {
  const sel = Array.from(document.querySelectorAll('.module.selected')).map(m => m.dataset.name);
  const selEl = document.getElementById('selection');
  if (sel.length > 0) {
    selEl.textContent = sel.join(', ');
    selEl.style.color = '#333';
  }
}
function filterModules() {
  const term = document.getElementById('search').value.toLowerCase();
  document.querySelectorAll('.module').forEach(m => {
    m.style.display = m.dataset.name.toLowerCase().includes(term) ? '' : 'none';
  });
}
function showOutput(content) {
  document.getElementById('result').textContent = content;
  document.getElementById('output').style.display = 'block';
}
function downloadNix() {
  const sel = Array.from(document.querySelectorAll('.module.selected')).map(m => m.dataset.name);
  if (sel.length === 0) {
    alert('No modules selected. Click on modules to select them.');
    return;
  }
  const cmd = 'nix build ' + sel.map(m => `"github:meta-introspector/mathlib4?ref=feature/split&dir=${m.replace(".", "/")}"`).join(' \\\n  ') + ' --no-write-lock-file';
  showOutput(cmd);
}
function generateFlake() {
  const sel = Array.from(document.querySelectorAll('.module.selected')).map(m => m.dataset.name);
  if (sel.length === 0) {
    alert('No modules selected. Click on modules to select them.');
    return;
  }
  let flakeLines = [
    '{',
    '  description = "Generated mathlib module flake";',
    '  inputs = {',
    '    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";'
  ];
  for (const m of sel) {
    const modName = m.replace(/\./g, '_').replace(/-/g, '_');
    flakeLines.push(`    ${modName}.url = "github:meta-introspector/mathlib4?ref=feature/split&dir=${m.replace('.', '/')}";`);
  }
  flakeLines.push('  };');
  flakeLines.push('  outputs = { self, nixpkgs, ... }@inputs:');
  flakeLines.push('    let');
  flakeLines.push('      system = "x86_64-linux";');
  flakeLines.push('      pkgs = nixpkgs.legacyPackages.${system};');
  flakeLines.push('    in {');
  flakeLines.push('      packages.${system}.default = pkgs.stdenv.mkDerivation {');
  flakeLines.push('        pname = "mathlib-modules";');
  flakeLines.push('        version = "0.1.0";');
  flakeLines.push('        src = ./.;');
  flakeLines.push('      };');
  flakeLines.push('    };');
  flakeLines.push('}');
  showOutput(flakeLines.join('\n'));
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

    with open(os.path.join(OUTPUT_DIR, "graph3d.html"), "w") as f:
        f.write(generate_3d_html(graph, all_modules))

    print(f"Generated {len(all_modules)} modules in {OUTPUT_DIR}/")
