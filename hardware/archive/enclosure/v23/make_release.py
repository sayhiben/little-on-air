"""Package only validated v2.3 artifacts; preserve original release and laser bytes."""
from pathlib import Path
import json,csv,shutil,hashlib,zipfile,importlib.util,html,math
HERE=Path(__file__).resolve().parent;BASE=HERE.parent;OUT=BASE/'output/v23';OLD=BASE/'output/on-air-v22-fabrication';DEST=BASE/'output/on-air-v23-fabrication'

def main():
 native=json.loads((OUT/'native-validation.json').read_text())
 assert not native['feature_issues'] and not native['interferences']
 assert all(c['passed'] for c in native['motion_checks'])
 wires=json.loads((OUT/'harness-validation.json').read_text());assert wires['passed']
 packing=json.loads((OUT/'wire-packing-validation.json').read_text());assert packing['passed']
 meshes=json.loads((OUT/'mesh-validation.json').read_text());assert all(x['watertight'] and x['connected_solids']==1 for x in meshes)
 slices=json.loads((OUT/'bambu-studio/all-projects-validation.json').read_text());assert len(slices)==9
 DEST.mkdir(exist_ok=True)
 for sub in ('stl','fit-samples','optional-laminate'):
  shutil.copytree(OUT/sub,DEST/sub,dirs_exist_ok=True)
 (DEST/'views').mkdir(exist_ok=True)
 for p in (OUT/'views').glob('*.png'):
  if p.name!='native-harness-clearances.png':shutil.copy2(p,DEST/'views'/p.name)
 shutil.copytree(OLD/'laser',DEST/'laser',dirs_exist_ok=True)
 (DEST/'cad').mkdir(exist_ok=True);(DEST/'validation').mkdir(exist_ok=True);(DEST/'bambu-studio').mkdir(exist_ok=True)
 for name in ('little-on-air-v23.f3d','little-on-air-v23-assembly.step','v23-production-fit-sections.f3d'):shutil.copy2(OUT/name,DEST/'cad'/name)
 for name in ('native-validation.json','harness-validation.json','mesh-validation.json'):shutil.copy2(OUT/name,DEST/'validation'/name)
 for name in ('final-reset-sweeps.json','charger-reinforcement-wire-check.json','charger-reinforcement-native-check.json','power-route-validation.json'):
  shutil.copy2(OUT/name,DEST/'validation'/name)
 for name in ('enclosed-void-native-check.json','enclosed-void-fill.json'):
  shutil.copy2(OUT/name,DEST/'validation'/name)
 shutil.copy2(OUT/'wire-packing-validation.json',DEST/'validation/wire-packing-validation.json')
 shutil.copy2(OUT/'bambu-studio/all-projects-validation.json',DEST/'validation/bambu-projects.json')
 for report in slices:
  name=report['project'];shutil.copy2(OUT/'bambu-studio'/('sliced-'+Path(name).stem)/name,DEST/'bambu-studio'/name)
 laser={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (DEST/'laser').iterdir() if p.is_file()}
 assert laser=={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (OLD/'laser').iterdir() if p.is_file()}
 (DEST/'validation/unchanged-laser.json').write_text(json.dumps(laser,indent=2))
 shutil.copy2(OUT/'routing-map.svg',DEST/'routing-map.svg')
 shutil.copy2(OUT/'archive-roundtrip-validation.json',DEST/'validation/archive-roundtrip-validation.json')
 shutil.copy2(OUT/'bambu-gui-validation.json',DEST/'validation/bambu-gui-validation.json')
 shutil.copy2(HERE/'REVISION-NOTES.md',DEST/'REVISION-NOTES.md')
 rows=list(csv.DictReader((OLD/'BOM.csv').open(encoding='utf-8-sig')))
 for r in rows:
  if r['Ref']=='P01-P08':r.update(Ref='P01-P07',Quantity='6',Item='Printed parts 01 03 04 05 06 07')
  if r['Ref']=='CH1':r['Specification']='Measured PCB 28.1 x17.5; USB 8.85 x3.1; overhang1.25; PCB thickness provisional1.0'
  if r['Ref']=='MCU1':r['Specification']='Original 21 x17.8 PCB; USB 8.97 x3.17; overhang1.75; no pin headers'
  if r['Ref']=='S2':r['Location']='Raised integrated MODE nest; use original actuator directly'
  if r['Ref']=='S1':r['Specification']='Measured body10.6 x6 x5.05; flange19.73; terminals2.6; actuator2.95 square x5 high; travel2.85'
 with (DEST/'BOM.csv').open('w',newline='',encoding='utf-8') as f:
  w=csv.DictWriter(f,fieldnames=rows[0].keys());w.writeheader();w.writerows(rows)
 oldguide=(OLD/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8')
 retained=oldguide[oldguide.index('## Nova Plus 24'):oldguide.index('## Routing and physical assembly')]
 guide='''# ON AIR v2.3 — measured-fit build

Replace **05 rear housing, 06 retaining yoke and 07 reset button** together. Omit the old printed part 08. There are six printed assembly parts plus one laser-cut acrylic panel. The front optical bezel, graphic, retainer and all laser files remain compatible with v2.2. See REVISION-NOTES.md for measurements and allowances.

## Fit checks and print setup

Start with the eSUN PLA+ fit-check project. It carries the filament profile from the user's successful inspection-off print and contains only the four changed mount sections, full yoke and rounded reset button. First-layer inspection is disabled; keep bed leveling enabled and observe the first two layers yourself. Open as a complete project and retain embedded settings. No print has been started by the assistant.

Use the supplied orientation at 100% scale. The housing prints on its flat back; the yoke prints on its broad front rails; the reset button stands on its exterior face so its guide section is formed in XY. Remove its brim and any flange support before testing. The rear housing and XIAO sample permit local supports beneath the guide projection; remove those supports without altering the guide bore. Structural profiles use a 0.4 mm nozzle, 0.20 mm layers and four walls. The reset button uses 0.10 mm layers. The graphic retains its 0.10 mm layers and black-to-white change after 1.6 mm. AMS and manual-swap projects are labeled separately; only the manual graphic plate has an intentional filament-change pause.

Other material projects are supplied for PLA and PETG. Select the actual spool and validate the same coupons in the intended material. A generic PLA profile is not a certified profile for every PLA+ formulation. Do not scale the assembly to solve a single tight hole.

Before fitting the XIAO, assemble the button and yoke to the housing and check the stem slides freely without rocking excessively. Its keyed section is 2.8 mm across flats in a 3.2 mm guide, with 4.8 mm bearing length. After fitting the XIAO, verify no preload, reliable release, single presses and double presses. Nominal inward motion is 0.45 mm including 0.15 mm free play; test the real switch before powering.

Fit the charger and POWER switch without forcing the printed cheeks apart. The charger PCB thickness remains an assumption at 1 mm; measure that if the keeper height does not match. Verify both USB plugs fully engage while the boards remain stationary. The measured socket envelopes do not establish the dimensions of every possible cable overmold.

## Fasteners and optical joints

Retain four M3x25 socket-head closure screws, two M3x6 button-head optical screws, two M3x8 button-head yoke screws, and eight ordinary 5.5 mm-AF x2.4 mm M3 nuts. The rear nut traps remain 6 mm across flats and 3 mm high; closure bores are 3.6 mm and front head recesses 6.8 mm. Hardware remains recessed. Seat the seam by hand before tightening; do not use screws to pull a trapped wire or misaligned board into position.

'''+retained+'''
## Revised routing and assembly

The circuit above is unchanged. The routes and cut lengths in this release reflect the raised switch bodies and reinforced XIAO frame. Route coordinates are front-view X/Y with positive depth measured rearward. The marked corridors reserve room for insulated wires and bends; endpoints are dressing locations, not asserted pin numbers. Verify actual pin functions with continuity and labels.

1. Print and cool the fit plate. Clean brim and strings. Test the charger, XIAO/reset, DPDT and SPDT sections with the complete yoke. Check both detents on each switch, full cable seating, and twenty reset presses with reliable return.
2. Identify and label switch contacts. Solder and insulate the switch, board and LED harness with the battery disconnected. The DPDT needs no printed slider; preserve room around its actual actuator.
3. Prepare the acrylic and registered optical stack using the unchanged laser instructions. Fit LED wires into their side exits, and secure the optical retainer with the two M3x6 screws.
4. Side-load the rear and yoke nuts. Place the insulated battery in its cradle and retain it with a loose nonconductive strap. Secure the capacitor and insulated junctions on the right landing.
5. Insert the charger from the open front. Insert the XIAO with its board 8 mm below the final position, then slide it up 8 mm into the port; the yoke provides its removable lower stop. Keep XIAO solder joints inside the two access windows, clear of the crossbar and diagonal braces. Place the new reset button into its front-open guide after the XIAO; the internal flange remains inside the housing.
6. Insert both switches from the open front. The SPDT flange enters its internal rebate and its lever passes through the top slot. The DPDT actuator passes through the smaller top opening; use a fingernail to change MODE. Dress the soldered leads toward the interior before lowering the yoke.
7. Follow the updated wire corridors and leave service slack. Keep the reset guide, PCB support faces, port roofs and nut pockets clear. Use the same internal pigtails, 330-ohm resistor and 680-uF capacitor already selected; no additional electronic parts are introduced by this revision.
8. Install the complete revised yoke with two M3x8 screws. The yoke restrains both boards and both switches and completes the reset guide. Use measured thin nonconductive shims only where needed; never load an IC, USB shell, exposed solder joint or battery pouch as a clamp surface.
9. Repeat the button, switch and USB tests. With POWER off and MODE at PROGRAM, connect the internal pigtail and close the case by hand. Install the four front M3x25 screws gently into the captive rear nuts.
10. Complete the retained electrical and thermal commissioning checks before applying removable wall strips. Firmware support for the external four-pixel chain remains a separate operational requirement; this mechanical revision does not flash firmware.

## Validation limits

The accompanying record covers nominal solid intersections, insertion paths, control travel, wire clearance volumes, watertight STL exports and slicing. It cannot establish the actual dimensional error of the next printed part, switch actuation force, unidentified PCB thickness, solder shape or a particular USB cable's overmold. These require the new fit samples. The successful prior print established that bypassing inspection allowed that job to run; the printer-side inspection fault itself was not repaired.
'''
 (DEST/'BUILD-AND-ASSEMBLY.md').write_text(guide,encoding='utf-8')
 shutil.copy2(OLD/'COMMISSIONING.csv',DEST/'COMMISSIONING.csv')
 with (DEST/'wire-cut-list.csv').open('w',newline='',encoding='utf-8') as f:
  w=csv.writer(f);w.writerow(['Route','CAD path length mm','Starting wire length mm','Note'])
  for r in wires['items']:
   if 'route_length_mm' in r:w.writerow([r['name'],r['route_length_mm'],math.ceil((r['route_length_mm']+35)/5)*5,'Per conductor; trim only after dry routing; allow pigtail and solder length'])
 (DEST/'START-HERE.md').write_text('''# ON AIR v2.3

Start with **bambu-studio/on-air-v23-X1C-eSUN-PLA-plus-fit-checks.3mf**. This is the measured-fit revision based on the physical v2.2 test. Replace parts 05, 06 and 07 together; omit printed part 08. Read REVISION-NOTES.md, then BUILD-AND-ASSEMBLY.md.

The laser artwork and front optical parts remain unchanged. First-layer inspection is disabled in the new Bambu projects. Retain embedded project settings, keep bed leveling enabled, and watch the first two layers manually.

Full-material projects and the separate STLs are provided after the fit check. The CAD archive remains editable in Fusion. Actual physical acceptance of these revised fits is still pending your next print.
''',encoding='utf-8')
 (DEST/'VALIDATION.md').write_text(f'''# v2.3 validation

- {len(native['motion_checks'])} sampled assembly/control paths passed.
- No native solid interferences or unhealthy timeline features.
- {len(wires['items'])} wire and solder-space checks passed.
- {len(meshes)} exported meshes are watertight, single connected solids and oriented on the bed.
- {len(slices)} Bambu projects sliced and their embedded meshes matched the STLs.
- The eSUN PLA+ fit project also opened and sliced in the Bambu GUI; its saved copy retained the intended meshes, material settings and inspection-off setting.
- All first-layer scan commands are absent from the new sliced projects.
- Laser file hashes match v2.2 byte for byte.

Physical fits remain subject to the measured-part coupon tests. No printer, laser or firmware operation was started.
''',encoding='utf-8')
 manifest={str(p.relative_to(DEST)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in DEST.rglob('*') if p.is_file() and p.name!='manifest.json'}
 (DEST/'manifest.json').write_text(json.dumps(manifest,indent=2))
 with zipfile.ZipFile(DEST.with_suffix('.zip'),'w',zipfile.ZIP_DEFLATED) as z:
  for p in DEST.rglob('*'):
   if p.is_file():z.write(p,str(Path(DEST.name)/p.relative_to(DEST)))
 print(DEST)

if __name__=='__main__':main()
