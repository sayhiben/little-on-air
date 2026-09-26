# Enclosure v2.15 — open-backed frame channels

Physical feedback: v2.14's wire-tunnel roofs did not bridge reliably. v2.15 removes only those roofs and the associated access-window ceilings. All other parts and the widened footprint remain unchanged. Wires lay in from the rear and are retained by small hot-glue anchors.

The user retained this complete case and selected it as current again on
September 26, 2026. The original v2.15 housing and yoke are part of that selection.
The CAD and print files are preserved; this is not a new geometry revision or
a new physical validation result.

Production files: [release v2.15](../../../release/little-on-air-enclosure-v2.15/README.md).

Use the [published wiring guide](../../../release/little-on-air-enclosure-v2.15/guides/FRONT-WIRING.md)
for assembly. `FRONT-WIRING.md` in this source directory is the packaging template;
its links resolve inside the release bundle.

## Development workflow

Current outputs are in `../output/v215/`. The tooling imports geometry, mesh,
G-code and diagram helpers from `../../archive/enclosure/`, including the
v2.14 native validation record. Retain those archived dependencies.

To regenerate in a configured Fusion MCP environment, run from the repository root:

```sh
python hardware/archive/enclosure/fusion_client.py run hardware/enclosure/v215/open_channels.py
python hardware/enclosure/v215/prepare_prints.py
python hardware/enclosure/v215/audit_prints.py
python hardware/enclosure/v215/routing_diagram.py
```

Use the installed NumPy Python for mesh/print audits and diagrams. Print
preparation invokes the existing Bambu Studio slicer and generates projects;
it does not send a printer job. Render `hardware/enclosure/output/v215/front-wiring.svg` to PNG
before packaging. The one-time candidate scripts remain in the archive.

`package_release.py` and `audit_release.py` write the release directory,
manifest, checksums and ZIP. They are publishing tools, not read-only checks.
Preserve the existing v2.15 release bytes when restoring this case; for future
revisions, choose new output/release paths deliberately and complete the native
and slicer checks before packaging. Provenance lookup in the audit supports
the archived locations of older source files without rewriting their records.

The Bambu generation starts from the preserved v2.13 user layout and applies the same placements used by v2.14, substituting the v2.15 front mesh. All other mesh/paint payloads are checked byte-for-byte. The frame's former 45° bridge override returns to automatic (0); the former roof layer must have no bridge extrusions. No printer or laser job is started by this workflow.
