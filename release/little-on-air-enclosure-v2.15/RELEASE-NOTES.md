# Enclosure v2.15

The v2.14 wire-channel roofs did not bridge reliably in the user’s physical print. This revision removes those roofs and the ceilings above their LED/side access openings, changing only frame 01. The widened 129 × 69 mm footprint, 1.8 mm floor, outer walls, optical floors and fitted screw/control/guide areas remain.

Channels open toward the rear. The narrower rear housing does not cover them completely; use small hot-glue anchors to keep insulated wires recessed. See [FRONT-WIRING.md](guides/FRONT-WIRING.md). No other part needs reprinting or laser cutting.

The supplied front-only and all-plate Bambu projects are re-sliced. No support or wire-roof bridge is generated for the frame; the special 45° bridge override is removed. All other meshes, painting, materials and plate positions are preserved. Native checks and mesh/slicer audits pass; this new revision still needs a physical print/assembly check.

Previous CAD/slicer passes did not establish real bridge performance. Historical validation records are preserved for unchanged interfaces, not as evidence that the v2.14 roofs printed successfully. Firmware and electrical wiring are unchanged.
