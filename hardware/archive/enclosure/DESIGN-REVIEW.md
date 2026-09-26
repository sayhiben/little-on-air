# ON AIR enclosure design review

**Implementation note:** This review records the earlier design findings. The resulting 34 mm-deep v2 enclosure and manufacturing files are now available in [the v2 build guide](output/v2/BUILD-AND-ASSEMBLY.md). Its retaining yoke also closes the port assembly notches, following insertion-path validation.

**Rebuild the enclosure around an integrated rear electronics housing and a shallow, self-contained front display assembly.** The battery cradle, PCB supports, switch nest, cable channels and screw bosses belong on that rear housing. The acrylic and its matching graphic belong together in the front assembly. This is a design recommendation; the current Fusion model, STLs and Bambu projects still contain the previous architecture.

The present files are printable prototypes, but their passing mesh and slicing checks do not establish a good FDM design. The main carrier has approximately **4,140 mm2 of horizontal underside at 2.925 mm above the bed**, supported initially by only about 66.6 mm2 of model contact. That broad suspended surface is an architectural problem worth removing.[^1]

*An explanatory diagram is included in the PDF.*

The proposed baseline has **six printed mechanical parts**: front bezel, rear housing, optical retainer, electronics retaining yoke, reset plunger and power slider. A printed black-and-white graphic makes seven printed pieces; a laser-engraved graphic instead keeps the count at six. The acrylic is always a separate laser-cut part. One small removable yoke is useful because fixed nests alone cannot hold components against every direction of motion.

Keep the 120 x 60 mm face. Budget approximately **32 mm depth** initially, then reduce it only after the actual hardware fits. A conservative stack through an edge-on XIAO totals about 30.2 mm before additional manufacturing margin. The earlier 30 mm depth was a modeling choice, not a required external dimension.

Priorities are repeatable optical alignment, reliable board restraint, accessible assembly and broad first-layer contact. A lower piece count or a shorter slicing estimate is valuable only when those properties survive.


## Existing design and print-plate findings

| Current plate | What it actually contains | Design consequence |
| --- | --- | --- |
| 1 | 90 M3 sample; 91 LED/acrylic sample; 92 reset-guide sample | These are test pieces, not backing or enclosure parts. Put them in a separate calibration project. |
| 2 | 01 body/front frame; 10 backplate | The existing full-depth front shell owns the ports while the carrier owns the boards. |
| 3 | 04 carrier; 05 charger keeper; 06 XIAO keeper; 07 plunger; 08 slider; 09 switch keeper | Move fixed mounts into the rear housing; replace the separate stationary keepers with a deliberate retention system. |
| 4 | 03 black-and-white graphic backing | This is the optical insert, not the rear cover. Its flat print orientation is appropriate. |

### The principal geometry defects

The carrier combines a large optical partition with forward LED fingers and rearward electronics fixtures. Its selected orientation puts the partition above the bed. Flipping it transfers the support problem to the fixtures. Adding small chamfers does not solve a suspended sheet spanning most of the enclosure; the front-side and rear-side functions need to be separated.[^1][^2]

The charger and switch keepers use locating legs but depend on ribs in the backplate to stop withdrawal. The XIAO fork depends on a case stop. These are real retention features, but they distribute one function across three different parts and complicate assembly. The new rear housing should own both the component position and its external port.[^1]

The power slider has a 9 x 5.2 mm external pad and an 8.2 x 5.2 mm internal flange around a 7.6 x 2.6 mm closed guide slot. Straight insertion from either side is unavailable. A tilted insertion maneuver might exist, but it was not demonstrated; the assembly instructions currently assume insertion without proving it. Redesign the capture geometry rather than relying on that maneuver.[^1]

The fit samples also need scrutiny. Sample 91 has roughly 245 mm2 of horizontal slot ceiling 5.4 mm above its bed. Sample 92 tests a vertical-axis bore, while the real side-button bore prints with a horizontal axis. Such samples cannot establish the finish or fit of those production surfaces. New samples must reproduce the actual orientation and assembly sequence.[^1]

These are manufacturing and assembly findings. They do not invalidate the earlier observation that the meshes are closed and the modeled solids do not collide.


## Part architecture and integration decision

| Architecture | Benefits | Limitations / decision |
| --- | --- | --- |
| Separate optical/electronics carrier (current) | Electronics lift out together; rear stays relatively flat. | Broad supported underside; extra partition, latches and keepers. Replace. |
| Mounts on graphic backing | Combines a large plate with support structures. | Bends and loads the optical datum; complicates two-color face printing; ties graphics to electronics revisions. Reject. |
| Fixed mounts on rear cover, ports in front shell | Consolidates fixtures and gives the rear a flat print base. | Still requires aligning mounted boards to another part during closure. Acceptable fallback. |
| Rear housing with fixed mounts AND ports; separate front optics | Common datum for USB and controls; structures grow from a flat rear base; front optics can remain assembled. | Needs a defined front/rear seam and one serviceable retention yoke. Recommended. |

### Proposed manufactured parts

| Part | Integrated features | Reason to remain separate |
| --- | --- | --- |
| Front bezel | LED pockets, acrylic seat, common graphic datums, optical-retainer fixing points | Print front down; remove front optics for service. |
| Rear housing | Flat wall face, side walls, board nests, battery cradle, switch nest, wire guides, nut bosses, ports | Print wall face down with all fixtures growing upward. |
| Optical retainer | Perimeter clamp and four broad LED hold-down pads | Print flat with pads upward; retain acrylic and graphic without an electronics partition. |
| Electronics yoke | Contact pads for safe PCB edges and switch body | Removable restraint, screwed into the rear housing; no reliance on spring friction. |
| Reset plunger / power slider | Captive moving interfaces with positive stops | Motion requires separate parts. |
| Graphic / clear acrylic | Matching keyed outline and common text master | Independent optical fabrication and replacement. |

The yoke should be an open frame, not another full sheet. Print its broad frame down and its contact legs upward; install it with the legs facing the components. Its load is component lift-out restraint. USB insertion and withdrawal loads go into short stops on the rear housing. If one yoke would require a long flexible arm or obstruct soldering, use two short bars; do not trade reliability for a nominal part-count target.


## Rear housing and component layout

*An explanatory diagram is included in the PDF.*

Keep the broad battery footprint near the center/lower half, the charger near the top left, the DPDT near the top center, and the XIAO at the right with its USB facing upward. The drawing is a packaging proposal in front-view coordinates, not a dimensionally completed CAD layout. It preserves useful parts of the existing placement while changing what supports them.

**Battery:** start with a 54 x 23 mm pocket for the supplied 52 x 21 mm pouch and reserve at least 11.5 mm thickness including free space, before any chosen pad. Use short rounded fences and a loose nonconductive strap. Put strap slots in raised lugs with short self-supporting roofs; keep the wall-facing skin intact. A hard clamp must not preload the pouch. Keep its lead exit and insulated connections clear of every closure rib.

**Charger:** the specified listing identifies a USB-C TP4056 board. The old 16.5 x 25 mm footprint is a provisional envelope, not a verified tolerance drawing. Seat the actual board on bare support areas, leave its underside and solder pads clear, add stops on both sides of USB insertion travel, and use the yoke only at component-free contact locations.[^12]

**XIAO:** keep the edge-on orientation initially. It exposes the reset button to a direct side plunger while leaving USB at the top. A flat PCB would reduce depth, but its face-normal reset would then require a bell crank or a different switch arrangement. That adds moving parts and calibration. The official Seeed page provides a reset reference and a mechanical DXF; identify the physical board revision before using these resources as final dimensions.[^11]

**DPDT:** cradle the 8.6 x 3.1 x 2.7 mm body, not its six terminals. Keep an open solder/insulation bay below it. Its 1.4 mm actuator height does not specify its throw. The slider socket should transmit only operating force; a larger housing guide must absorb accidental finger side loads.

Keep both USB receptacles, their board seats, button guides and travel stops on the rear housing. Fit the actual cable overmolds through chamfered openings and check full seating. Keep metal hardware, reflective foil and the battery away from the XIAO antenna area where practical, then verify radio performance in the closed sign.


## Acrylic optics and edge coupling

*An explanatory diagram is included in the PDF.*

For this sign, ordinary clear cast acrylic with selectively engraved lettering is a sound starting material. The smooth sheet guides light, and the engraving scatters light out where the letters are. The white graphic behind it reflects some escaping light and supplies an unlit white-on-black appearance. It is not a second light guide.[^5][^7]

Special light-guide sheets containing scattering particles serve a different purpose: they intentionally illuminate their whole surface. Their uniformity claims should not be applied to four separate LEDs illuminating ordinary engraved acrylic. Retain clear unengraved background regions for the intended dark field.[^6]

Keep the four LED pockets in the front bezel so the acrylic edge and emitter share one locating structure. Use two LEDs along each long edge as the initial layout. Align the **emitting window center** to the measured sheet midplane. An 8 x 8 x 2 mm module envelope does not reveal that optical center. Start with a 0.2-0.3 mm non-contact edge gap, then tune with the actual modules and soldered leads.

ACRYLITE recommends polished entry edges and reflective treatment on unused edges. Keep coupling windows clear; place nonconductive white reflector strips behind unused edge regions and between LED sites where space allows. Keep those strips out of the wiring and antenna area. A clean laser-cut edge may be sufficient, but inspect and test it before deciding whether additional finishing is needed.[^5]

Do not laminate the display faces together. PLEXIGLAS notes that bonding and surface treatments change light transmission; the air interfaces are part of the optical system. Use a small controlled air gap and perimeter contact outside the visible field. Do not let retaining pads bear on the engraved letters.[^6]

The 60 mm case height leaves little spare LED space: 38 mm acrylic + two 8 mm modules + two 0.2 mm entry gaps + two 2.4 mm outer walls = **59.2 mm**, before pocket clearance. Route solder leads sideways along the edge rather than assuming there is room behind each module. Verify the actual separated modules before preserving this width of bezel.


## Graphic backing, spacing and artwork

**Keep the graphic separate, flat and replaceable.** A laser-engraved sheet with a black surface and white core is the preferred finish option: removing the surface reveals the white letters, and both optical parts can use the same vector geometry. Trotec describes this two-layer construction. Reflectance and the final illuminated appearance still require a sample; no product page establishes the performance of this particular stack.[^9]

The existing FDM concept remains a reasonable no-new-material alternative: a 1.6 mm black substrate with 0.4 mm white raised letters, printed back down. Keep that separate from electronics holders. Check whether two white layers are opaque enough over black; use a 0.4 versus 0.6 mm lettering sample if necessary. The chosen relief changes the spacer height and color-change plan.

| Interface | Proposed control | Why it matters |
| --- | --- | --- |
| Acrylic / graphic XY | Two shared perpendicular datum edges; compliant pads on opposing edges | A clipped corner controls orientation only. It does not remove translational play. |
| Perimeter clearance | Start around 0.25 mm per side away from locating datums; measure and tune | Two independently floating panels can differ by 0.5 mm on one axis even when their outlines match. |
| Engraving / white-face gap | Test 0.3 and 0.5 mm, set by perimeter stops and shims | Smaller gap reduces apparent doubling; sufficient clearance prevents contact due to bow. |
| Clamping | Broad low-force perimeter pads; hard closure stops outside optics | Screw torque must not bend the graphic or load the acrylic. |

For a first-order air-gap calculation, lateral separation is g x tan(theta). At a 45-degree viewing angle a 0.5 mm gap produces about 0.5 mm apparent offset between the rear engraving plane and graphic; a 0.3 mm gap produces about 0.3 mm. Engraving depth and actual optical paths add detail to this estimate. Identical text contours alone therefore cannot eliminate oblique-view doubling.

Thermal clearance also has a scale: ACRYLITE gives a cast-sheet coefficient equivalent to 0.000072 per degree C. A 104 mm panel changes length by about 0.225 mm for a 30 C change. This is an illustrative free-sheet calculation, not the relative movement against PETG. A compliant edge restraint is preferable to a hard interference fit.[^10]

Maintain one front-view text master as vector outlines. The acrylic rear-engraving file mirrors **both text and asymmetric cut key**. A front-engraved black/white laminate uses the unmirrored master. FDM text uses that same master. Keep cut and filled-engrave layers separate, preserve millimeters and apply measured laser kerf compensation once. The old artwork contour audit is useful, but does not validate physical registration.[^1][^7]

Epilog and Trotec agree that cast acrylic produces strong frosted engraving, but differ in how broadly they promise polished cut edges. Treat edge quality as machine- and sheet-dependent. Measure the actual thickness; 3.000 mm and 1/8 inch (3.175 mm) are different, and cast sheet also varies.[^7][^8]


## Fasteners, moving controls and service access

*An explanatory diagram is included in the PDF.*

The closure screws must pass through the front bezel and engage metal nuts retained by solid bosses in the rear housing. The nuts pull against the front-facing roof of those bosses. The rear skin remains closed. This gives a direct load path from screw head to front compression seat to rear boss to nut; the acrylic, graphic and battery are outside that path.

Keep the existing M3 socket-head approach with recessed cylindrical counterbores. Add gussets from tall bosses to the rear floor or side walls. Stratasys recommends supporting FDM bosses and using metal fastening interfaces. Preserve a flat bearing surface under the head; a self-supporting bridge detail can be added above the counterbore without replacing the bearing surface with a cone.[^4]

The existing 30 mm model places the screw bearing plane at 3.2 mm and uses a 25 mm screw, so the tip reaches 28.2 mm. Its blind bore ends at 28.7 mm and its rear skin starts there, leaving the modeled 0.5 mm tip gap and 1.3 mm skin. This explains why the back stays attached without an exterior rear hole. A revised depth or boss position requires recalculating nut engagement and tip clearance; do not transfer the hardware length blindly.[^1]

**Reset:** use a single captive inner flange larger than the guide bore, a stem that passes through from inside, and a small contact tip. Add a 45-degree underside transition to make the flange printable with the outer stem end down. The housing provides an inward hard stop; tune the tip for no resting preload and full release. The tactile switch provides the return force, which must exceed guide friction. Verify paced resets and rapid double reset on the real board.[^11]

**Power:** remove the insertion ambiguity. Use one oversized inner flange, with the outer grip small enough to pass through the elongated wall opening. The opening length must cover grip length + measured switch travel + running clearance. Alternatively, use a guide open to the case seam and close it with the mating part. The chosen path must be demonstrated in CAD and with a small printed sample.

Use two accessible internal screws for the optical retainer and two for the electronics yoke, with blind captive-nut or specified insert features. Their lengths are separate from the four external closure screws. First install optics in the bezel, then electronics and controls in the rear housing, connect a flexible LED harness, and join the halves. Disconnect external USB cables before opening. Provide enough harness slack to support the front during disconnection.

A rear housing fixed directly to the wall leaves electronics on the wall during service. Keep the yoke and wiring accessible from the front. Preserve a flat adhesive area and accessible strip-removal tabs; select a strip format that fits the 60 mm height. 3M distinguishes detaching picture-strip pairs from stretching the adhesive strip downward for removal.[^14]


## FDM geometry and slicing strategy

| Part | Print orientation | Geometry objective |
| --- | --- | --- |
| Front bezel | Visible front face down | Walls and LED pocket rails rise from the bed; remove old carrier-latch shelves. |
| Rear housing | Wall-facing exterior down | Floor first, then side walls, nests and gusseted bosses. No broad suspended partition. |
| Optical retainer | Broad frame down, LED pads up | Open center, short supported-at-root contact pads; no underside fingers. |
| Electronics yoke | Broad frame down, contact legs up | Open access to cables; no long horizontal roofs over electronics. |
| Reset plunger | Outer stem end down, chamfered flange above | Add a brim if needed; protect the contact tip from support scars. |
| Power slider | Broad captive flange down, grip up | Use an open or short-bridge actuator socket and chamfer any expanding shoulder. |
| Printed graphic | Black flat back down, white letters up | One color change after the black base; no supports. |

Use 45-degree self-supporting slopes as a conservative design starting point, measured from the horizontal build plane. Apply them beneath outward shelves and to entry edges. Add fillets at upward-growing rib roots to reduce stress concentration where they do not introduce unsupported undersides. A chamfer is a shape change; joining a holder to the rear housing requires a real solid connection and adequate root area.[^2][^4]

Start structural skins near 2.4 mm and useful fixture ribs near 1.6-2.4 mm, with local reinforcement around USB stops and fasteners. These are proposed dimensions, not material allowables. Inspect generated extrusion paths rather than assuming a dimension corresponds to an exact number of nozzle widths. Avoid long 0.8 mm spring leaves as the primary component restraint.

For the X1 Carbon and 0.4 mm nozzle, retain 0.20 mm layers, four walls and five top/bottom layers as a conservative first build. Start near 20-25% infill for large parts, with local solid regions for small bosses and solid small controls. Use the actual filament preset. The earlier Generic PETG selection and color availability were assumptions, not a confirmed material inventory.

PETG is suitable for this prototype, but its difficult support removal and weaker bridging behavior make support-heavy precision pockets undesirable. Bambu PETG HF has its own drying and print guidance; do not assign those properties or temperatures to every PETG spool. The main improvement here is removing difficult support interfaces from the model.[^3][^13]

Aim for no generated support on the major optical or board locating surfaces. Check short bridges over nut traps and port openings individually; use teardrop/45-degree roofs or accessible local support where necessary. Do not describe the redesign as support-free until its actual sliced layers confirm it.

Package the new job as **Structure** (bezel and rear housing), **Retainers and controls**, and **Graphic** if printed. Put fit samples in a separate named calibration project. Keep graphics alone on the color-change plate so tall black fixtures do not inherit the white layers. New time and material estimates require the new geometry; the previous estimates cannot be reused.


## Prototype sequence and release criteria

The redesign can proceed parametrically, but exact interfaces remain dependent on the actual components. Record the following measurements once and use them consistently across seats, openings, restraints and test pieces.

| Measurement | Required detail |
| --- | --- |
| Acrylic / laser | Thickness at several points; cut-edge size and kerf; flatness; engraving result. |
| Four LED modules | Maximum footprint after separation and soldering; emitter center and emitting direction; insulated lead envelope. |
| XIAO | Board revision; populated height both sides; bare PCB support zones; USB projection; reset center, force and travel. |
| Charger | Actual board size, thickness, underside parts, pads and soldered wires; USB projection and cable overmold. |
| DPDT | Body and terminals after soldering; both actuator endpoints; throw; necessary access to six connections. |
| Mounting / hardware | Actual M3 heads and nuts; intended adhesive-strip footprint and release tabs; real filament and plate surface. |

### Three economical validation builds

**1. Optical slice:** print a short section of the revised bezel and retainer in their production orientations. Use the actual acrylic and one soldered LED. Compare 0.3 and 0.5 mm optical gaps, edge-coupling alignment, and both graphic methods if available. Check unlit readability and the illuminated letters at normal and oblique viewing angles. This replaces the old covered-slot coupon.

**2. Mechanical interfaces:** print the actual rear-housing wall section containing each port/board seat and the complete control capture features. Demonstrate board insertion, yoke attachment, full USB seating, reset return and slider installation. Repeat button and switch operation and cable insertion enough to expose looseness or binding; a proposed screening target is 50 operations, not a life rating.

**3. Full assembly:** build one enclosure only after the interfaces fit. Verify the four LEDs across the entire text; four discrete emitters cannot be assumed to give uniform brightness. Inspect for pressure marks, rattling, alignment shift, cable pinching and light leakage. Check the intended firmware colors, reset gestures and radio connection in the mounted position.

The final CAD review must include the swept space of the moving controls and the insertion/removal path of each component, not only static interference. The final slicer review must check first layers, bridge direction, isolated islands, support accessibility, mating surfaces and actual color changes. Every delivered part needs an assembly role and a clear plate name.

Check closed-case temperature during the intended lighting and charging operation using the actual circuit. The XIAO already has charging hardware, and this design also reserves the requested external charger. The enclosure review does not determine how those power paths should be connected or the appropriate cell charge current. Keep wiring decisions and component clearances consistent with the established circuit.[^11][^12]

**Design disposition:** revise the case architecture before committing to the current full-size print. Preserve the existing CAD and print files as the v1 baseline. The research supports the integration strategy, but the proposed rear housing, retainer and yoke have not yet been modeled or physically validated.


## Sources and evidence scope

Manufacturer guidance informs the process choices. Proposed dimensions, part architecture, tolerance examples and acceptance steps are engineering recommendations for this enclosure. They are not manufacturer guarantees. The local face-area calculation measures horizontal surfaces only; it does not estimate support volume or certify printability.

Official mechanical resource retained for the next CAD revision: Seeed Studio, [XIAO nRF52840 DXF archive](https://files.seeedstudio.com/wiki/XIAO-BLE/XIAO-nRF52840-DXF.zip), accessed 8 September 2026. The archive contains top and bottom drawings. It must be matched to the actual board; the current Fusion electronics are still simplified envelopes.


## Reference notes

[^1]: Local enclosure artifacts. Existing print projects, oriented STL meshes, assembly instructions and independent audit. Reviewed 8 September 2026. hardware/enclosure/output/print/; output/bambu-studio/audit/independent-audit.json; enclosure README.md. New horizontal-face measurements and hashes are in output/design-review/geometry-observations.json.

[^2]: Prusa Research. [Modeling with 3D printing in mind](https://help.prusa3d.com/article/modeling-with-3d-printing-in-mind_164135). Undated; accessed 8 September 2026. Overhangs, chamfers, orientation and fit variability.

[^3]: Prusa Research. [PETG](https://help.prusa3d.com/article/petg_2059). Undated; accessed 8 September 2026. PETG support removal and bridging limitations; Prusa temperatures are not transferred to the X1C.

[^4]: Stratasys Direct. [FDM Design Guide](https://www.stratasys.com/siteassets/sdm/content---website-storage/design-guides/dg_sdm_fdm_0725a.pdf?v=490918). 2025 edition identified by file 0725a; pp. 5-9. Boss reinforcement, fillets, orientation and fasteners. Industrial soluble-support capabilities are not assumed for this print.

[^5]: ACRYLITE / POLYVANTIS. [Light piping acrylic](https://www.acrylite.co/resources/knowledge-base/article/what-information-do-you-have-on-light-piping?category=product-properties). Undated; accessed 8 September 2026. Standard acrylic, polished entry edges, surface quality and reflective unused edges.

[^6]: PLEXIGLAS / POLYVANTIS. [PLEXIGLAS LED: Solid Sheet and Rod, Ref. 212-15](https://www.plexiglas.de/files/plexiglas-content/pdf/technische-informationen/212-15-EN-PLEXIGLAS-LED-edge-lighting.pdf). July 2024; pp. 3-4. Total reflection, surface-scattering grades, edge coupling and effect of bonding. Whole-panel LED-grade performance is not a prediction for ordinary engraved acrylic.

[^7]: Epilog Laser. [Laser Cutting Acrylic](https://www.epiloglaser.com/en-ca/how-it-works/applications/laser-cutting-acrylic/). Undated; accessed 8 September 2026. Cast versus extruded engraving, reverse artwork and light engraving.

[^8]: Trotec Laser. [Tips and tricks for processing acrylic](https://www.troteclaser.com/en-tt/helpcenter/materials/material-usage-hints/material-handling-acrylic). Undated; accessed 8 September 2026. Thickness variation, cast engraving and edge-quality guidance.

[^9]: Trotec Laser. [TroLase: Laserable Plastic for Engraving and Cutting](https://shop.troteclaser.com/en-US/trolase-laserable-plastic). Undated; accessed 8 September 2026. Two-layer engraving sheet exposes a contrasting core. Use black surface over white core.

[^10]: ACRYLITE / POLYVANTIS. [Expansion and Contraction of Acrylic](https://www.acrylite.co/resources/knowledge-base/article/-how-do-i-figure-out-expansion-and-contraction-of-acrylic-for-a-glazing-application?category=glazing). Undated; accessed 8 September 2026. Cast acrylic coefficient 0.000040 per degree F, equivalent to 0.000072 per degree C.

[^11]: Seeed Studio. [Getting Started with XIAO nRF52840 Series](https://wiki.seeedstudio.com/XIAO_BLE/). Page updated 7 September 2026; accessed 8 September 2026. Reset operation, onboard charger and official mechanical resources. Original nRF52840 must be distinguished from Sense and Plus revisions.

[^12]: HiLetgo / Amazon listing. [TP4056 Type-C USB 5V 1A charger, ASIN B07PKND8KG](https://www.amazon.com/dp/B07PKND8KG). Accessed 8 September 2026. Identity of the specified module; listing is not a tolerance-controlled mechanical drawing.

[^13]: Bambu Lab. [PETG HF](https://eu.store.bambulab.com/en-mt/products/petg-hf?variant=49068714557788). Undated; accessed 8 September 2026. Drying guidance and filament-specific properties. Does not establish the properties of unidentified Generic PETG.

[^14]: 3M Command. [How to Use Picture Hanging Strips](https://www.command.com/3M/en_US/command/how-to-use/picture-hanging-strips/). Undated; accessed 8 September 2026. Removable strip application, separation and downward stretch removal.
