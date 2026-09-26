# Enclosure v2.14 — front cable-routing revision

Only component 01 changes. Source archive: the preserved v2.13 release. New front size 129 × 69 mm; 4.2 × 6.3 mm covered perimeter cable channel; removed LED side lips above the unchanged seating floors; existing control, optical and fastening interfaces retained.

The production files and assembly instructions are in [release v2.14](../../../release/little-on-air-enclosure-v2.14/README.md).

Regeneration uses Fusion MCP on localhost:27182 through `../fusion_client.py`. Run `build_front_routing.py`, `validate_front_routing.py`, and `finish.py` against the active revision, then `prepare_prints.py`, `audit_prints.py`, `audit_bridges.py`, `routing_diagram.py` and `package_release.py`. Use the bundled NumPy Python for the mesh/print audits and diagrams. Render the two reference SVGs with Sharp before packaging. The package script requires every native, mesh and slicer check to pass.

`clear_reset_collar.py` records the in-session correction applied to the first candidate. The same keepout is now incorporated into `build_front_routing.py` before the new rim is joined. It is unnecessary to apply the correction a second time when regenerating with the current builder. The final native validation records the original wire tests and proves the correction only removes newly added material.

The final projects keep a 45° bridge-angle override on part 01. The automatic direction in the first slice produced long unsupported roof runs. Existing meshes, painting and material profiles are retained for every other part. Rear housing 05 moves 9 mm in plate Y to preserve spacing beside the wider frame.
