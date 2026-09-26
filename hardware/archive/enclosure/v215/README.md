# Enclosure v2.15 — open-backed frame channels

Physical feedback: v2.14's wire-tunnel roofs did not bridge reliably. v2.15 removes only those roofs and the associated access-window ceilings. All other parts and the widened footprint remain unchanged. Wires lay in from the rear and are retained by small hot-glue anchors.

Production files: [release v2.15](../../../release/little-on-air-enclosure-v2.15/README.md).

Regenerate with Fusion MCP through `../fusion_client.py run v215/open_channels.py`, then run `prepare_prints.py`, `audit_prints.py`, `routing_diagram.py`, `package_release.py` and `audit_release.py`. Use the bundled NumPy Python for mesh/print audits and diagrams, and render `front-wiring.svg` to PNG before packaging. Production packaging requires native and slicer checks to pass.

The Bambu generation starts from the preserved v2.13 user layout and applies the same placements used by v2.14, substituting the v2.15 front mesh. All other mesh/paint payloads are checked byte-for-byte. The frame's former 45° bridge override returns to automatic (0); the former roof layer must have no bridge extrusions. No printer or laser job is started by this workflow.
