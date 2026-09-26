"""Publish the enclosure design review; does not edit CAD or print projects."""
from pathlib import Path
import re, json, struct, collections, hashlib
from xml.sax.saxutils import escape
from reportlab.pdfgen import canvas
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak, Flowable
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.colors import HexColor, Color, black, white
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.enums import TA_LEFT

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT/'output'/'design-review'
PDF = ROOT/'output'/'pdf'/'on-air-fdm-design-review.pdf'
MD = ROOT/'DESIGN-REVIEW.md'
OUT.mkdir(parents=True, exist_ok=True)
PDF.parent.mkdir(parents=True, exist_ok=True)
pdfmetrics.registerFont(TTFont('Arial', 'C:/Windows/Fonts/arial.ttf'))
pdfmetrics.registerFont(TTFont('ArialBold', 'C:/Windows/Fonts/arialbd.ttf'))
pdfmetrics.registerFontFamily('Arial',normal='Arial',bold='ArialBold',italic='Arial',boldItalic='ArialBold')

SOURCES = {
1: ('Local enclosure artifacts', 'Existing print projects, oriented STL meshes, assembly instructions and independent audit', 'Reviewed 8 September 2026', None, 'hardware/enclosure/output/print/; output/bambu-studio/audit/independent-audit.json; enclosure README.md. New horizontal-face measurements and hashes are in output/design-review/geometry-observations.json.'),
2: ('Prusa Research', 'Modeling with 3D printing in mind', 'Undated; accessed 8 September 2026', 'https://help.prusa3d.com/article/modeling-with-3d-printing-in-mind_164135', 'Overhangs, chamfers, orientation and fit variability.'),
3: ('Prusa Research', 'PETG', 'Undated; accessed 8 September 2026', 'https://help.prusa3d.com/article/petg_2059', 'PETG support removal and bridging limitations; Prusa temperatures are not transferred to the X1C.'),
4: ('Stratasys Direct', 'FDM Design Guide', '2025 edition identified by file 0725a; pp. 5-9', 'https://www.stratasys.com/siteassets/sdm/content---website-storage/design-guides/dg_sdm_fdm_0725a.pdf?v=490918', 'Boss reinforcement, fillets, orientation and fasteners. Industrial soluble-support capabilities are not assumed for this print.'),
5: ('ACRYLITE / POLYVANTIS', 'Light piping acrylic', 'Undated; accessed 8 September 2026', 'https://www.acrylite.co/resources/knowledge-base/article/what-information-do-you-have-on-light-piping?category=product-properties', 'Standard acrylic, polished entry edges, surface quality and reflective unused edges.'),
6: ('PLEXIGLAS / POLYVANTIS', 'PLEXIGLAS LED: Solid Sheet and Rod, Ref. 212-15', 'July 2024; pp. 3-4', 'https://www.plexiglas.de/files/plexiglas-content/pdf/technische-informationen/212-15-EN-PLEXIGLAS-LED-edge-lighting.pdf', 'Total reflection, surface-scattering grades, edge coupling and effect of bonding. Whole-panel LED-grade performance is not a prediction for ordinary engraved acrylic.'),
7: ('Epilog Laser', 'Laser Cutting Acrylic', 'Undated; accessed 8 September 2026', 'https://www.epiloglaser.com/en-ca/how-it-works/applications/laser-cutting-acrylic/', 'Cast versus extruded engraving, reverse artwork and light engraving.'),
8: ('Trotec Laser', 'Tips and tricks for processing acrylic', 'Undated; accessed 8 September 2026', 'https://www.troteclaser.com/en-tt/helpcenter/materials/material-usage-hints/material-handling-acrylic', 'Thickness variation, cast engraving and edge-quality guidance.'),
9: ('Trotec Laser', 'TroLase: Laserable Plastic for Engraving and Cutting', 'Undated; accessed 8 September 2026', 'https://shop.troteclaser.com/en-US/trolase-laserable-plastic', 'Two-layer engraving sheet exposes a contrasting core. Use black surface over white core.'),
10: ('ACRYLITE / POLYVANTIS', 'Expansion and Contraction of Acrylic', 'Undated; accessed 8 September 2026', 'https://www.acrylite.co/resources/knowledge-base/article/-how-do-i-figure-out-expansion-and-contraction-of-acrylic-for-a-glazing-application?category=glazing', 'Cast acrylic coefficient 0.000040 per degree F, equivalent to 0.000072 per degree C.'),
11: ('Seeed Studio', 'Getting Started with XIAO nRF52840 Series', 'Page updated 7 September 2026; accessed 8 September 2026', 'https://wiki.seeedstudio.com/XIAO_BLE/', 'Reset operation, onboard charger and official mechanical resources. Original nRF52840 must be distinguished from Sense and Plus revisions.'),
12: ('HiLetgo / Amazon listing', 'TP4056 Type-C USB 5V 1A charger, ASIN B07PKND8KG', 'Accessed 8 September 2026', 'https://www.amazon.com/dp/B07PKND8KG', 'Identity of the specified module; listing is not a tolerance-controlled mechanical drawing.'),
13: ('Bambu Lab', 'PETG HF', 'Undated; accessed 8 September 2026', 'https://eu.store.bambulab.com/en-mt/products/petg-hf?variant=49068714557788', 'Drying guidance and filament-specific properties. Does not establish the properties of unidentified Generic PETG.'),
14: ('3M Command', 'How to Use Picture Hanging Strips', 'Undated; accessed 8 September 2026', 'https://www.command.com/3M/en_US/command/how-to-use/picture-hanging-strips/', 'Removable strip application, separation and downward stretch removal.'),
}

# Reproducible observations about the supplied print orientation, not a support simulation.
observations = []
for path in sorted((ROOT/'output'/'print').glob('*.stl')):
    data=path.read_bytes(); planes=collections.defaultdict(float)
    for i in range(struct.unpack_from('<I',data,80)[0]):
        f=struct.unpack_from('<12fH',data,84+i*50)
        a,b,c=[f[j:j+3] for j in (3,6,9)]
        u=[b[j]-a[j] for j in range(3)]; v=[c[j]-a[j] for j in range(3)]
        nz=u[0]*v[1]-u[1]*v[0]
        if max(a[2],b[2],c[2])-min(a[2],b[2],c[2])<0.0001 and nz<0:
            planes[round(a[2],3)]+=abs(nz)/2
    observations.append(dict(part=path.name,sha256=hashlib.sha256(data).hexdigest(),
        downward_horizontal_area_mm2_by_height={str(z):round(a,3) for z,a in sorted(planes.items()) if a>1}))
(OUT/'geometry-observations.json').write_text(json.dumps(dict(
    method='Sum downward-facing horizontal STL triangle areas by height in supplied print orientation. Does not classify bridge reach or compute required support volume.',
    observations=observations,
    calculations={'air_gap_parallax_at_45_deg_mm':{'gap_0.5':0.5,'gap_0.3':0.3},
        'acrylic_104mm_expansion_for_30C_mm':104*30*0.000072,
        'conservative_depth_stack_mm':{'front_lip':1.6,'acrylic':3.175,'air_gap':0.3,'printed_graphic':2.0,'retainer':1.6,'separation':0.5,'edge_on_xiao':17.8,'rear_seat_allowance':0.8,'rear_skin':2.4},
        'conservative_depth_stack_total_mm':30.175}),indent=2))

PAGES=[]
def page(title, blocks, refs=()): PAGES.append((title,blocks,refs))
def p(t): return ('p',t)
def h(t): return ('h',t)
def table(headers,rows,widths=None): return ('table',(headers,rows,widths))
def diagram(name): return ('diagram',name)

page('ON AIR enclosure design review', [
p('<b>Rebuild the enclosure around an integrated rear electronics housing and a shallow, self-contained front display assembly.</b> The battery cradle, PCB supports, switch nest, cable channels and screw bosses belong on that rear housing. The acrylic and its matching graphic belong together in the front assembly. This is a design recommendation; the current Fusion model, STLs and Bambu projects still contain the previous architecture.'),
p('The present files are printable prototypes, but their passing mesh and slicing checks do not establish a good FDM design. The main carrier has approximately <b>4,140 mm2 of horizontal underside at 2.925 mm above the bed</b>, supported initially by only about 66.6 mm2 of model contact. That broad suspended surface is an architectural problem worth removing.<super>1</super>'),
diagram('architecture'),
p('The proposed baseline has <b>six printed mechanical parts</b>: front bezel, rear housing, optical retainer, electronics retaining yoke, reset plunger and power slider. A printed black-and-white graphic makes seven printed pieces; a laser-engraved graphic instead keeps the count at six. The acrylic is always a separate laser-cut part. One small removable yoke is useful because fixed nests alone cannot hold components against every direction of motion.'),
p('Keep the 120 x 60 mm face. Budget approximately <b>32 mm depth</b> initially, then reduce it only after the actual hardware fits. A conservative stack through an edge-on XIAO totals about 30.2 mm before additional manufacturing margin. The earlier 30 mm depth was a modeling choice, not a required external dimension.'),
p('Priorities are repeatable optical alignment, reliable board restraint, accessible assembly and broad first-layer contact. A lower piece count or a shorter slicing estimate is valuable only when those properties survive.')
], [1])

page('Existing design and print-plate findings', [
table(['Current plate','What it actually contains','Design consequence'],[
['1','90 M3 sample; 91 LED/acrylic sample; 92 reset-guide sample','These are test pieces, not backing or enclosure parts. Put them in a separate calibration project.'],
['2','01 body/front frame; 10 backplate','The existing full-depth front shell owns the ports while the carrier owns the boards.'],
['3','04 carrier; 05 charger keeper; 06 XIAO keeper; 07 plunger; 08 slider; 09 switch keeper','Move fixed mounts into the rear housing; replace the separate stationary keepers with a deliberate retention system.'],
['4','03 black-and-white graphic backing','This is the optical insert, not the rear cover. Its flat print orientation is appropriate.']
], [55,167,290]),
h('The principal geometry defects'),
p('The carrier combines a large optical partition with forward LED fingers and rearward electronics fixtures. Its selected orientation puts the partition above the bed. Flipping it transfers the support problem to the fixtures. Adding small chamfers does not solve a suspended sheet spanning most of the enclosure; the front-side and rear-side functions need to be separated.<super>1,2</super>'),
p('The charger and switch keepers use locating legs but depend on ribs in the backplate to stop withdrawal. The XIAO fork depends on a case stop. These are real retention features, but they distribute one function across three different parts and complicate assembly. The new rear housing should own both the component position and its external port.<super>1</super>'),
p('The power slider has a 9 x 5.2 mm external pad and an 8.2 x 5.2 mm internal flange around a 7.6 x 2.6 mm closed guide slot. Straight insertion from either side is unavailable. A tilted insertion maneuver might exist, but it was not demonstrated; the assembly instructions currently assume insertion without proving it. Redesign the capture geometry rather than relying on that maneuver.<super>1</super>'),
p('The fit samples also need scrutiny. Sample 91 has roughly 245 mm2 of horizontal slot ceiling 5.4 mm above its bed. Sample 92 tests a vertical-axis bore, while the real side-button bore prints with a horizontal axis. Such samples cannot establish the finish or fit of those production surfaces. New samples must reproduce the actual orientation and assembly sequence.<super>1</super>'),
p('These are manufacturing and assembly findings. They do not invalidate the earlier observation that the meshes are closed and the modeled solids do not collide.')
], [1,2])

page('Part architecture and integration decision', [
table(['Architecture','Benefits','Limitations / decision'],[
['Separate optical/electronics carrier (current)','Electronics lift out together; rear stays relatively flat.','Broad supported underside; extra partition, latches and keepers. Replace.'],
['Mounts on graphic backing','Combines a large plate with support structures.','Bends and loads the optical datum; complicates two-color face printing; ties graphics to electronics revisions. Reject.'],
['Fixed mounts on rear cover, ports in front shell','Consolidates fixtures and gives the rear a flat print base.','Still requires aligning mounted boards to another part during closure. Acceptable fallback.'],
['Rear housing with fixed mounts AND ports; separate front optics','Common datum for USB and controls; structures grow from a flat rear base; front optics can remain assembled.','Needs a defined front/rear seam and one serviceable retention yoke. Recommended.']
], [127,172,213]),
h('Proposed manufactured parts'),
table(['Part','Integrated features','Reason to remain separate'],[
['Front bezel','LED pockets, acrylic seat, common graphic datums, optical-retainer fixing points','Print front down; remove front optics for service.'],
['Rear housing','Flat wall face, side walls, board nests, battery cradle, switch nest, wire guides, nut bosses, ports','Print wall face down with all fixtures growing upward.'],
['Optical retainer','Perimeter clamp and four broad LED hold-down pads','Print flat with pads upward; retain acrylic and graphic without an electronics partition.'],
['Electronics yoke','Contact pads for safe PCB edges and switch body','Removable restraint, screwed into the rear housing; no reliance on spring friction.'],
['Reset plunger / power slider','Captive moving interfaces with positive stops','Motion requires separate parts.'],
['Graphic / clear acrylic','Matching keyed outline and common text master','Independent optical fabrication and replacement.']
], [105,223,184]),
p('The yoke should be an open frame, not another full sheet. Print its broad frame down and its contact legs upward; install it with the legs facing the components. Its load is component lift-out restraint. USB insertion and withdrawal loads go into short stops on the rear housing. If one yoke would require a long flexible arm or obstruct soldering, use two short bars; do not trade reliability for a nominal part-count target.')
])

page('Rear housing and component layout', [
diagram('layout'),
p('Keep the broad battery footprint near the center/lower half, the charger near the top left, the DPDT near the top center, and the XIAO at the right with its USB facing upward. The drawing is a packaging proposal in front-view coordinates, not a dimensionally completed CAD layout. It preserves useful parts of the existing placement while changing what supports them.'),
p('<b>Battery:</b> start with a 54 x 23 mm pocket for the supplied 52 x 21 mm pouch and reserve at least 11.5 mm thickness including free space, before any chosen pad. Use short rounded fences and a loose nonconductive strap. Put strap slots in raised lugs with short self-supporting roofs; keep the wall-facing skin intact. A hard clamp must not preload the pouch. Keep its lead exit and insulated connections clear of every closure rib.'),
p('<b>Charger:</b> the specified listing identifies a USB-C TP4056 board. The old 16.5 x 25 mm footprint is a provisional envelope, not a verified tolerance drawing. Seat the actual board on bare support areas, leave its underside and solder pads clear, add stops on both sides of USB insertion travel, and use the yoke only at component-free contact locations.<super>12</super>'),
p('<b>XIAO:</b> keep the edge-on orientation initially. It exposes the reset button to a direct side plunger while leaving USB at the top. A flat PCB would reduce depth, but its face-normal reset would then require a bell crank or a different switch arrangement. That adds moving parts and calibration. The official Seeed page provides a reset reference and a mechanical DXF; identify the physical board revision before using these resources as final dimensions.<super>11</super>'),
p('<b>DPDT:</b> cradle the 8.6 x 3.1 x 2.7 mm body, not its six terminals. Keep an open solder/insulation bay below it. Its 1.4 mm actuator height does not specify its throw. The slider socket should transmit only operating force; a larger housing guide must absorb accidental finger side loads.'),
p('Keep both USB receptacles, their board seats, button guides and travel stops on the rear housing. Fit the actual cable overmolds through chamfered openings and check full seating. Keep metal hardware, reflective foil and the battery away from the XIAO antenna area where practical, then verify radio performance in the closed sign.')
], [11,12])

page('Acrylic optics and edge coupling', [
diagram('optics'),
p('For this sign, ordinary clear cast acrylic with selectively engraved lettering is a sound starting material. The smooth sheet guides light, and the engraving scatters light out where the letters are. The white graphic behind it reflects some escaping light and supplies an unlit white-on-black appearance. It is not a second light guide.<super>5,7</super>'),
p('Special light-guide sheets containing scattering particles serve a different purpose: they intentionally illuminate their whole surface. Their uniformity claims should not be applied to four separate LEDs illuminating ordinary engraved acrylic. Retain clear unengraved background regions for the intended dark field.<super>6</super>'),
p('Keep the four LED pockets in the front bezel so the acrylic edge and emitter share one locating structure. Use two LEDs along each long edge as the initial layout. Align the <b>emitting window center</b> to the measured sheet midplane. An 8 x 8 x 2 mm module envelope does not reveal that optical center. Start with a 0.2-0.3 mm non-contact edge gap, then tune with the actual modules and soldered leads.'),
p('ACRYLITE recommends polished entry edges and reflective treatment on unused edges. Keep coupling windows clear; place nonconductive white reflector strips behind unused edge regions and between LED sites where space allows. Keep those strips out of the wiring and antenna area. A clean laser-cut edge may be sufficient, but inspect and test it before deciding whether additional finishing is needed.<super>5</super>'),
p('Do not laminate the display faces together. PLEXIGLAS notes that bonding and surface treatments change light transmission; the air interfaces are part of the optical system. Use a small controlled air gap and perimeter contact outside the visible field. Do not let retaining pads bear on the engraved letters.<super>6</super>'),
p('The 60 mm case height leaves little spare LED space: 38 mm acrylic + two 8 mm modules + two 0.2 mm entry gaps + two 2.4 mm outer walls = <b>59.2 mm</b>, before pocket clearance. Route solder leads sideways along the edge rather than assuming there is room behind each module. Verify the actual separated modules before preserving this width of bezel.')
], [5,6,7])

page('Graphic backing, spacing and artwork', [
p('<b>Keep the graphic separate, flat and replaceable.</b> A laser-engraved sheet with a black surface and white core is the preferred finish option: removing the surface reveals the white letters, and both optical parts can use the same vector geometry. Trotec describes this two-layer construction. Reflectance and the final illuminated appearance still require a sample; no product page establishes the performance of this particular stack.<super>9</super>'),
p('The existing FDM concept remains a reasonable no-new-material alternative: a 1.6 mm black substrate with 0.4 mm white raised letters, printed back down. Keep that separate from electronics holders. Check whether two white layers are opaque enough over black; use a 0.4 versus 0.6 mm lettering sample if necessary. The chosen relief changes the spacer height and color-change plan.'),
table(['Interface','Proposed control','Why it matters'],[
['Acrylic / graphic XY','Two shared perpendicular datum edges; compliant pads on opposing edges','A clipped corner controls orientation only. It does not remove translational play.'],
['Perimeter clearance','Start around 0.25 mm per side away from locating datums; measure and tune','Two independently floating panels can differ by 0.5 mm on one axis even when their outlines match.'],
['Engraving / white-face gap','Test 0.3 and 0.5 mm, set by perimeter stops and shims','Smaller gap reduces apparent doubling; sufficient clearance prevents contact due to bow.'],
['Clamping','Broad low-force perimeter pads; hard closure stops outside optics','Screw torque must not bend the graphic or load the acrylic.']
], [120,206,186]),
p('For a first-order air-gap calculation, lateral separation is g x tan(theta). At a 45-degree viewing angle a 0.5 mm gap produces about 0.5 mm apparent offset between the rear engraving plane and graphic; a 0.3 mm gap produces about 0.3 mm. Engraving depth and actual optical paths add detail to this estimate. Identical text contours alone therefore cannot eliminate oblique-view doubling.'),
p('Thermal clearance also has a scale: ACRYLITE gives a cast-sheet coefficient equivalent to 0.000072 per degree C. A 104 mm panel changes length by about 0.225 mm for a 30 C change. This is an illustrative free-sheet calculation, not the relative movement against PETG. A compliant edge restraint is preferable to a hard interference fit.<super>10</super>'),
p('Maintain one front-view text master as vector outlines. The acrylic rear-engraving file mirrors <b>both text and asymmetric cut key</b>. A front-engraved black/white laminate uses the unmirrored master. FDM text uses that same master. Keep cut and filled-engrave layers separate, preserve millimeters and apply measured laser kerf compensation once. The old artwork contour audit is useful, but does not validate physical registration.<super>1,7</super>'),
p('Epilog and Trotec agree that cast acrylic produces strong frosted engraving, but differ in how broadly they promise polished cut edges. Treat edge quality as machine- and sheet-dependent. Measure the actual thickness; 3.000 mm and 1/8 inch (3.175 mm) are different, and cast sheet also varies.<super>7,8</super>')
], [1,7,8,9,10])

page('Fasteners, moving controls and service access', [
diagram('fastener'),
p('The closure screws must pass through the front bezel and engage metal nuts retained by solid bosses in the rear housing. The nuts pull against the front-facing roof of those bosses. The rear skin remains closed. This gives a direct load path from screw head to front compression seat to rear boss to nut; the acrylic, graphic and battery are outside that path.'),
p('Keep the existing M3 socket-head approach with recessed cylindrical counterbores. Add gussets from tall bosses to the rear floor or side walls. Stratasys recommends supporting FDM bosses and using metal fastening interfaces. Preserve a flat bearing surface under the head; a self-supporting bridge detail can be added above the counterbore without replacing the bearing surface with a cone.<super>4</super>'),
p('The existing 30 mm model places the screw bearing plane at 3.2 mm and uses a 25 mm screw, so the tip reaches 28.2 mm. Its blind bore ends at 28.7 mm and its rear skin starts there, leaving the modeled 0.5 mm tip gap and 1.3 mm skin. This explains why the back stays attached without an exterior rear hole. A revised depth or boss position requires recalculating nut engagement and tip clearance; do not transfer the hardware length blindly.<super>1</super>'),
p('<b>Reset:</b> use a single captive inner flange larger than the guide bore, a stem that passes through from inside, and a small contact tip. Add a 45-degree underside transition to make the flange printable with the outer stem end down. The housing provides an inward hard stop; tune the tip for no resting preload and full release. The tactile switch provides the return force, which must exceed guide friction. Verify paced resets and rapid double reset on the real board.<super>11</super>'),
p('<b>Power:</b> remove the insertion ambiguity. Use one oversized inner flange, with the outer grip small enough to pass through the elongated wall opening. The opening length must cover grip length + measured switch travel + running clearance. Alternatively, use a guide open to the case seam and close it with the mating part. The chosen path must be demonstrated in CAD and with a small printed sample.'),
p('Use two accessible internal screws for the optical retainer and two for the electronics yoke, with blind captive-nut or specified insert features. Their lengths are separate from the four external closure screws. First install optics in the bezel, then electronics and controls in the rear housing, connect a flexible LED harness, and join the halves. Disconnect external USB cables before opening. Provide enough harness slack to support the front during disconnection.'),
p('A rear housing fixed directly to the wall leaves electronics on the wall during service. Keep the yoke and wiring accessible from the front. Preserve a flat adhesive area and accessible strip-removal tabs; select a strip format that fits the 60 mm height. 3M distinguishes detaching picture-strip pairs from stretching the adhesive strip downward for removal.<super>14</super>')
], [1,4,11,14])

page('FDM geometry and slicing strategy', [
table(['Part','Print orientation','Geometry objective'],[
['Front bezel','Visible front face down','Walls and LED pocket rails rise from the bed; remove old carrier-latch shelves.'],
['Rear housing','Wall-facing exterior down','Floor first, then side walls, nests and gusseted bosses. No broad suspended partition.'],
['Optical retainer','Broad frame down, LED pads up','Open center, short supported-at-root contact pads; no underside fingers.'],
['Electronics yoke','Broad frame down, contact legs up','Open access to cables; no long horizontal roofs over electronics.'],
['Reset plunger','Outer stem end down, chamfered flange above','Add a brim if needed; protect the contact tip from support scars.'],
['Power slider','Broad captive flange down, grip up','Use an open or short-bridge actuator socket and chamfer any expanding shoulder.'],
['Printed graphic','Black flat back down, white letters up','One color change after the black base; no supports.']
], [103,168,241]),
p('Use 45-degree self-supporting slopes as a conservative design starting point, measured from the horizontal build plane. Apply them beneath outward shelves and to entry edges. Add fillets at upward-growing rib roots to reduce stress concentration where they do not introduce unsupported undersides. A chamfer is a shape change; joining a holder to the rear housing requires a real solid connection and adequate root area.<super>2,4</super>'),
p('Start structural skins near 2.4 mm and useful fixture ribs near 1.6-2.4 mm, with local reinforcement around USB stops and fasteners. These are proposed dimensions, not material allowables. Inspect generated extrusion paths rather than assuming a dimension corresponds to an exact number of nozzle widths. Avoid long 0.8 mm spring leaves as the primary component restraint.'),
p('For the X1 Carbon and 0.4 mm nozzle, retain 0.20 mm layers, four walls and five top/bottom layers as a conservative first build. Start near 20-25% infill for large parts, with local solid regions for small bosses and solid small controls. Use the actual filament preset. The earlier Generic PETG selection and color availability were assumptions, not a confirmed material inventory.'),
p('PETG is suitable for this prototype, but its difficult support removal and weaker bridging behavior make support-heavy precision pockets undesirable. Bambu PETG HF has its own drying and print guidance; do not assign those properties or temperatures to every PETG spool. The main improvement here is removing difficult support interfaces from the model.<super>3,13</super>'),
p('Aim for no generated support on the major optical or board locating surfaces. Check short bridges over nut traps and port openings individually; use teardrop/45-degree roofs or accessible local support where necessary. Do not describe the redesign as support-free until its actual sliced layers confirm it.'),
p('Package the new job as <b>Structure</b> (bezel and rear housing), <b>Retainers and controls</b>, and <b>Graphic</b> if printed. Put fit samples in a separate named calibration project. Keep graphics alone on the color-change plate so tall black fixtures do not inherit the white layers. New time and material estimates require the new geometry; the previous estimates cannot be reused.')
], [2,3,4,13])

page('Prototype sequence and release criteria', [
p('The redesign can proceed parametrically, but exact interfaces remain dependent on the actual components. Record the following measurements once and use them consistently across seats, openings, restraints and test pieces.'),
table(['Measurement','Required detail'],[
['Acrylic / laser','Thickness at several points; cut-edge size and kerf; flatness; engraving result.'],
['Four LED modules','Maximum footprint after separation and soldering; emitter center and emitting direction; insulated lead envelope.'],
['XIAO','Board revision; populated height both sides; bare PCB support zones; USB projection; reset center, force and travel.'],
['Charger','Actual board size, thickness, underside parts, pads and soldered wires; USB projection and cable overmold.'],
['DPDT','Body and terminals after soldering; both actuator endpoints; throw; necessary access to six connections.'],
['Mounting / hardware','Actual M3 heads and nuts; intended adhesive-strip footprint and release tabs; real filament and plate surface.']
], [120,392]),
h('Three economical validation builds'),
p('<b>1. Optical slice:</b> print a short section of the revised bezel and retainer in their production orientations. Use the actual acrylic and one soldered LED. Compare 0.3 and 0.5 mm optical gaps, edge-coupling alignment, and both graphic methods if available. Check unlit readability and the illuminated letters at normal and oblique viewing angles. This replaces the old covered-slot coupon.'),
p('<b>2. Mechanical interfaces:</b> print the actual rear-housing wall section containing each port/board seat and the complete control capture features. Demonstrate board insertion, yoke attachment, full USB seating, reset return and slider installation. Repeat button and switch operation and cable insertion enough to expose looseness or binding; a proposed screening target is 50 operations, not a life rating.'),
p('<b>3. Full assembly:</b> build one enclosure only after the interfaces fit. Verify the four LEDs across the entire text; four discrete emitters cannot be assumed to give uniform brightness. Inspect for pressure marks, rattling, alignment shift, cable pinching and light leakage. Check the intended firmware colors, reset gestures and radio connection in the mounted position.'),
p('The final CAD review must include the swept space of the moving controls and the insertion/removal path of each component, not only static interference. The final slicer review must check first layers, bridge direction, isolated islands, support accessibility, mating surfaces and actual color changes. Every delivered part needs an assembly role and a clear plate name.'),
p('Check closed-case temperature during the intended lighting and charging operation using the actual circuit. The XIAO already has charging hardware, and this design also reserves the requested external charger. The enclosure review does not determine how those power paths should be connected or the appropriate cell charge current. Keep wiring decisions and component clearances consistent with the established circuit.<super>11,12</super>'),
p('<b>Design disposition:</b> revise the case architecture before committing to the current full-size print. Preserve the existing CAD and print files as the v1 baseline. The research supports the integration strategy, but the proposed rear housing, retainer and yoke have not yet been modeled or physically validated.')
], [11,12])

page('Sources and evidence scope', [
p('Manufacturer guidance informs the process choices. Proposed dimensions, part architecture, tolerance examples and acceptance steps are engineering recommendations for this enclosure. They are not manufacturer guarantees. The local face-area calculation measures horizontal surfaces only; it does not estimate support volume or certify printability.'),
('sources',None),
p('Official mechanical resource retained for the next CAD revision: Seeed Studio, <link href="https://files.seeedstudio.com/wiki/XIAO-BLE/XIAO-nRF52840-DXF.zip" color="#222222">XIAO nRF52840 DXF archive</link>, accessed 8 September 2026. The archive contains top and bottom drawings. It must be matched to the actual board; the current Fusion electronics are still simplified envelopes.')
])

BODY=ParagraphStyle('body',fontName='Arial',fontSize=10,leading=13.2,spaceAfter=6,textColor=HexColor('#222222'))
TITLE=ParagraphStyle('title',parent=BODY,fontName='ArialBold',fontSize=21,leading=25,spaceAfter=15)
HEAD=ParagraphStyle('heading',parent=BODY,fontName='ArialBold',fontSize=11.5,leading=15,spaceBefore=4,spaceAfter=7)
SMALL=ParagraphStyle('small',parent=BODY,fontSize=8,leading=10.2,spaceAfter=4)
CELL=ParagraphStyle('cell',parent=BODY,fontSize=9,leading=11.2,spaceAfter=0)
GRAY=HexColor('#DDE0E3'); DARK=HexColor('#353B40'); BLUE=HexColor('#D8E6EC')

class Drawing(Flowable):
    def __init__(self,name):
        Flowable.__init__(self); self.name=name; self.width=512
        self.height={'architecture':158,'layout':172,'optics':166,'fastener':116}[name]
    def draw(self):
        c=self.canv; c.setLineWidth(.75); c.setStrokeColor(DARK)
        def txt(x,y,t,size=9,bold=False):
            c.setFillColor(DARK);c.setFont('ArialBold' if bold else 'Arial',size);c.drawString(x,y,t)
        def rect(x,y,w,h,color=GRAY):
            c.setFillColor(color);c.rect(x,y,w,h,stroke=1,fill=1)
        def line(x,y,xx,yy):c.line(x,y,xx,yy)
        def arrow(x,y,xx,yy):
            line(x,y,xx,yy)
            import math
            a=math.atan2(yy-y,xx-x)
            for da in (.5,-.5):line(xx,yy,xx-5*math.cos(a+da),yy-5*math.sin(a+da))
        if self.name=='architecture':
            txt(0,144,'PROPOSED ASSEMBLY',10,True)
            rect(4,41,78,65,DARK);rect(13,54,60,39,white);txt(9,23,'Front bezel')
            rect(104,47,10,54,BLUE);txt(93,8,'Acrylic')
            rect(144,47,10,54,DARK);txt(127,23,'Graphic')
            rect(181,42,10,64,GRAY);txt(166,8,'Optical retainer')
            rect(234,49,10,55,GRAY);txt(222,23,'Yoke')
            rect(300,34,13,78,DARK);rect(260,34,40,8,DARK);rect(260,104,40,8,DARK)
            rect(282,48,18,11);rect(277,82,23,13);txt(261,8,'Rear housing')
            arrow(211,123,313,123);txt(222,137,'Assembly direction',8)
            txt(345,104,'Fixed mounts + ports',10,True)
            txt(345,88,'on rear housing')
            txt(345,63,'Moving plunger and slider')
            txt(345,48,'remain separate.')
            txt(345,24,'Schematic; not to scale',8)
        elif self.name=='layout':
            txt(0,158,'REAR HOUSING: FRONT-VIEW COORDINATES',10,True)
            ox,oy,sc=0,19,2.08
            rect(ox,oy,120*sc,60*sc,white)
            def box(x,y,w,h,label):
                rect(ox+x*sc,oy+y*sc,w*sc,h*sc);txt(ox+x*sc+3,oy+y*sc+h*sc/2-3,label,8)
            box(34,10,54,23,'Battery')
            box(12,32,20,25,'Charger')
            box(53,48,17,9,'DPDT')
            box(107,33,8,24,'XIAO')
            for x,y in ((6,6),(114,6),(6,54),(96,54)):
                c.circle(ox+x*sc,oy+y*sc,3.3,stroke=1,fill=0)
            arrow(21*sc,142,21*sc,150);arrow(111*sc,142,111*sc,150)
            txt(277,126,'USB ports at the top',10,True)
            txt(277,106,'XIAO edge-on: direct side reset')
            txt(277,86,'Open yoke above components')
            txt(277,66,'Short stops take USB loads')
            txt(277,46,'Flat rear skin stays continuous')
            txt(0,3,'Placement zones only; solder, cables, yoke and ribs still require detailed CAD.',8)
        elif self.name=='optics':
            txt(0,152,'OPTICAL CROSS-SECTION',10,True)
            rect(38,29,30,95,BLUE);txt(26,11,'Clear acrylic',8)
            rect(86,29,9,95,DARK);rect(81,72,5,15,white);txt(83,0,'White letter / black base',8)
            rect(106,22,10,16);rect(106,115,10,16)
            rect(21,131,45,11,DARK);rect(21,16,45,11,DARK)
            rect(39,127,27,10,GRAY);arrow(53,129,53,106)
            txt(143,125,'LED points through the edge',10,True)
            line(69,101,69,91);line(69,80,69,72)
            txt(143,102,'Rear engraving is the light extraction pattern')
            line(71,95,134,99)
            txt(143,79,'0.3 / 0.5 mm air-gap samples')
            line(76,79,134,77)
            txt(143,56,'Perimeter retainer; no center pressure')
            line(117,29,134,54)
            arrow(30,81,0,81);txt(0,63,'View',8)
            txt(143,30,'LED retention and panel datums stay in the front assembly.',8)
        else:
            txt(0,102,'CLOSURE LOAD PATH',10,True)
            rect(27,36,26,42);rect(53,38,68,40);rect(121,30,201,53,GRAY);rect(322,30,15,53,DARK)
            rect(27,46,18,24,white);rect(45,53,258,9,white)
            rect(30,49,15,17,DARK);rect(45,55,248,5,DARK)
            rect(268,45,15,25,white)
            c.setFillColor(DARK); c.rect(268,55,15,5,stroke=0,fill=1)
            txt(0,16,'Recessed head',8);txt(130,16,'Rear boss / compression column',8)
            txt(56,89,'Front seat',8);line(83,83,83,78)
            txt(260,89,'Captive nut',8);line(275,83,275,70)
            txt(352,72,'Blind tip clearance',9);line(292,57,345,69)
            txt(352,46,'Closed rear skin',9);line(337,45,347,45)
            txt(352,25,'No rear protrusion',9)

story=[]; markdown=['# ON AIR enclosure design review\n']
for idx,(title,blocks,refs) in enumerate(PAGES):
    if idx:story.append(PageBreak());markdown.append('\n## '+title+'\n')
    story.append(Paragraph(escape(title),TITLE))
    for typ,val in blocks:
        if typ in ('p','h'):
            story.append(Paragraph(val,BODY if typ=='p' else HEAD))
            text=re.sub(r'<super>(.*?)</super>',lambda m:''.join('[^'+v+']' for v in m[1].split(',')),val)
            text=text.replace('<b>','**').replace('</b>','**')
            text=re.sub(r'<link href="([^"]*)"[^>]*>(.*?)</link>',r'[\2](\1)',text)
            markdown.append(('### ' if typ=='h' else '')+text+'\n')
        elif typ=='table':
            headers,rows,widths=val
            data=[[Paragraph('<b>'+escape(x)+'</b>',CELL) for x in headers]]
            data += [[Paragraph(escape(x),CELL) for x in row] for row in rows]
            t=Table(data,colWidths=widths or [512/len(headers)]*len(headers),hAlign='LEFT')
            t.setStyle(TableStyle([('VALIGN',(0,0),(-1,-1),'TOP'),('BACKGROUND',(0,0),(-1,0),HexColor('#ECEEEF')),('LINEBELOW',(0,0),(-1,0),.6,DARK),('LINEBELOW',(0,1),(-1,-1),.3,GRAY),('LEFTPADDING',(0,0),(-1,-1),6),('RIGHTPADDING',(0,0),(-1,-1),6),('TOPPADDING',(0,0),(-1,-1),5),('BOTTOMPADDING',(0,0),(-1,-1),5)]))
            story += [t,Spacer(1,10)]
            markdown.append('| '+' | '.join(headers)+' |\n| '+' | '.join(['---']*len(headers))+' |\n'+'\n'.join('| '+' | '.join(r)+' |' for r in rows)+'\n')
        elif typ=='diagram':
            story += [Drawing(val),Spacer(1,5)]
            markdown.append('*An explanatory diagram is included in the PDF.*\n')
        elif typ=='sources':
            for n,(org,st,date,url,note) in SOURCES.items():
                stxt=f'{n}. <b>{escape(org)}</b>. '+(f'<link href="{escape(url)}" color="#222222">{escape(st)}</link>' if url else escape(st))+f'. {escape(date)}. {escape(note)}'
                story.append(Paragraph(stxt,SMALL))
    if refs:
        story.append(Spacer(1,7))
        for n in refs:
            org,st,date,url,note=SOURCES[n]
            stxt=f'{n}. {escape(org)}, '+(f'<link href="{escape(url)}" color="#222222">{escape(st)}</link>' if url else escape(st))+'.'
            story.append(Paragraph(stxt,SMALL))

markdown.append('\n## Reference notes\n')
for n,(org,st,date,url,note) in SOURCES.items():
    markdown.append(f'[^{n}]: {org}. '+(f'[{st}]({url})' if url else st)+f'. {date}. {note}\n')
MD.write_text('\n'.join(markdown),encoding='utf-8')
doc=SimpleDocTemplate(str(PDF),pagesize=(612,792),rightMargin=50,leftMargin=50,topMargin=39,bottomMargin=32,title='ON AIR enclosure design review',author='')
doc.build(story)
print(json.dumps({'pdf':str(PDF),'markdown':str(MD),'planned_pages':len(PAGES),'geometry_observations':str(OUT/'geometry-observations.json')},indent=2))
