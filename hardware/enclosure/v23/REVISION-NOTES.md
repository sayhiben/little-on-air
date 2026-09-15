# v2.3 — changes from the physical fit tests

This revision replaces parts **05 (rear housing), 06 (retaining yoke) and 07 (reset button)** together. Omit part **08 (printed DPDT slider)**. The optical bezel, printed graphic, optical retainer, fasteners and laser artwork retain their existing interfaces.

| Interface | Revision |
|---|---|
| MODE DPDT | Move the actual switch toward the top wall. Its own actuator is exposed for a fingernail; no printed actuator or actuator socket. Nominal actuator exposure is 0.58 mm. Full 2.58 mm switch travel remains available. |
| Reset | Keyed 2.8 mm stem, 3.2 mm guide, 4.8 mm bearing length, rounded external cap, internal captive flange and positive inward stop. The nominal free movement before contact is 0.15 mm; total inward travel is 0.45 mm. |
| XIAO | Move 0.6 mm toward the right wall and 1.3 mm toward the top. Replace the narrow isolated supports with a continuous 2.5 mm frame, solder-access windows and diagonal braces. The lower stop is on the removable yoke. Insert the XIAO 8 mm below its final position from the open front, then slide it up 8 mm into the USB opening before fitting the reset button and yoke. |
| Charger | Measured PCB 28.1 × 17.5 mm, with 1.25 mm USB overhang. Use 0.30 mm lateral clearance and approximately 0.25 mm clearance at each end. Support posts and keeper stems are 2 mm square. The PCB thickness remains provisionally 1 mm. |
| POWER SPDT | Measured body 10.6 × 6 × 5.05 mm, flange 19.73 mm, terminal projection 2.6 mm, actuator 2.95 mm square × 5 mm tall. A 5.8 mm overall slot means 2.85 mm movement. Use 0.20 mm body clearance at the side stops; bring the flange face 1.4 mm closer to the top wall. |
| USB openings | Use measured metal sockets: charger 8.85 × 3.1 mm, XIAO 8.97 × 3.17 mm; overhangs 1.25 and 1.75 mm respectively. Allow 0.30 mm per side. Socket mouths are about 0.35 mm (charger) and 0.45 mm (XIAO) behind the outer wall. Verify with the actual cable before tightening the yoke. |

The new fit plate contains the four changed mount sections, complete yoke and reset button. Its material settings use the user's eSUN PLA+ profile. Automatic first-layer inspection remains disabled after the successful recovery print; bed leveling remains available. Watch the first two layers manually.

The reset button uses 0.10 mm layers and prints standing on its external cap to keep the keyed guide section in the printer's XY plane. Remove its brim and any flange support carefully. The rear housing and XIAO fit section allow local support under the deeper guide projection; remove this before testing the button. Deburr only the first-layer rim; do not indiscriminately sand the guide faces. Test sliding movement before installing the XIAO, then verify that the reset switch is released at rest and returns after every press.

The 0.20 mm mechanical running clearances are design targets informed by this user's fit feedback, not a guarantee across every spool. The same final fit check is required for PLA, PLA+ and PETG. [Prusa's design guidance](https://help.prusa3d.com/article/modeling-with-3d-printing-in-mind_164135) explains why printed fits require allowance and orientation checks. [Seeed's XIAO documentation](https://wiki.seeedstudio.com/XIAO_BLE/) supplies the nominal PCB size; socket, reset and solder envelopes still require the real part.

Wiring and laser artwork are unaffected electrically/optically. Route the DPDT leads into its newly raised solder bay before lowering the yoke. Do not run wire across the new reset guide or use the XIAO frame as a clamp on exposed solder joints. Exact available routes are checked in the accompanying native validation report before release.
