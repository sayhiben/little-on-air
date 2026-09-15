from pathlib import Path
import json,csv,hashlib,shutil,zipfile,math
HERE=Path(__file__).resolve().parent;BASE=HERE.parent;OUT=BASE/'output/v25';OLD=BASE/'output/on-air-v24-fabrication';DEST=BASE/'output/on-air-v25-fabrication'
def main():
 n=json.loads((OUT/'native-validation.json').read_text());assert not n['feature_issues'] and not n['interferences'] and len(n['motion_checks'])==16 and all(c['passed'] for c in n['motion_checks'])
 w=json.loads((OUT/'harness-validation.json').read_text());assert w['passed']
 for f in ('wire-packing-validation.json','usb-space-validation.json','archive-roundtrip-validation.json','nut-access-validation.json','terminal-row-validation.json','reset-fit-validation.json'):assert json.loads((OUT/f).read_text())['passed']
 meshes=json.loads((OUT/'mesh-validation.json').read_text());assert len(meshes)==18 and all(m['watertight'] and m['connected_solids']==1 for m in meshes)
 slices=json.loads((OUT/'bambu-studio/all-projects-validation.json').read_text());assert len(slices)==9
 for sub in ('stl','fit-samples','optional-laminate'):shutil.copytree(OUT/sub,DEST/sub,dirs_exist_ok=True)
 shutil.copytree(OLD/'laser',DEST/'laser',dirs_exist_ok=True)
 for sub in ('cad','validation','views','bambu-studio'):(DEST/sub).mkdir(exist_ok=True)
 for f in ('little-on-air-v25.f3d','little-on-air-v25-assembly.step','v25-production-fit-sections.f3d'):shutil.copy2(OUT/f,DEST/'cad'/f)
 for p in (OUT/'views').glob('*.png'):
  if p.name!='native-harness-clearances.png':shutil.copy2(p,DEST/'views'/p.name)
 for f in ('native-validation.json','harness-validation.json','mesh-validation.json','wire-packing-validation.json','usb-space-validation.json','archive-roundtrip-validation.json','final-motion-checks.json','nut-access-validation.json','terminal-row-validation.json','reset-fit-validation.json','print-face-static-validation.json','final-screw-wire-validation.json'):
  shutil.copy2(OUT/f,DEST/'validation'/f)
 if (OUT/'bambu-gui-validation.json').exists():shutil.copy2(OUT/'bambu-gui-validation.json',DEST/'validation/bambu-gui-validation.json')
 shutil.copy2(OUT/'bambu-studio/all-projects-validation.json',DEST/'validation/bambu-projects.json')
 for r in slices:
  name=r['project'];shutil.copy2(OUT/'bambu-studio'/('sliced-'+Path(name).stem)/name,DEST/'bambu-studio'/name)
 shutil.copy2(HERE/'REVISION-NOTES.md',DEST/'REVISION-NOTES.md');shutil.copy2(OUT/'routing-map.svg',DEST/'routing-map.svg')
 laser={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (DEST/'laser').iterdir() if p.is_file()}
 assert laser=={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (OLD/'laser').iterdir() if p.is_file()}
 (DEST/'validation/unchanged-laser.json').write_text(json.dumps(laser,indent=2))
 rows=list(csv.DictReader((OLD/'BOM.csv').open(encoding='utf-8-sig')))
 for r in rows:
  if r['Ref']=='S2':r['Specification']='Body9.1 x3.72 x3.36; six legs0.7 wide x3.25 projection; 1.85 clear gaps; actuator1.5 square x1.87; travel2.4; no flange'
  if r['Ref']=='MCU1':r['Specification']='PCB21 x17.8 x1.2; USB8.97 x3.17 centered across width; overhang1.75; reset1.8 from PCB back; no headers'
  if r['Ref']=='CH1':r['Location']='Fixed charger nest; lower supports centered5mm from bottom; both OUT solder faces clear'
  if r['Ref']=='S1':r['Status']='Owned; successful body fit retained; combined sample99 first'
 with (DEST/'BOM.csv').open('w',newline='',encoding='utf-8') as f:
  writer=csv.DictWriter(f,fieldnames=rows[0].keys());writer.writeheader();writer.writerows(rows)
 shutil.copy2(OLD/'COMMISSIONING.csv',DEST/'COMMISSIONING.csv')
 with (DEST/'wire-cut-list.csv').open('w',newline='',encoding='utf-8') as f:
  writer=csv.writer(f);writer.writerow(['Route','CAD route length mm','Starting wire length mm','Note'])
  for r in w['items']:
   if 'route_length_mm' in r:writer.writerow([r['name'],r['route_length_mm'],math.ceil((r['route_length_mm']+35)/5)*5,'Per conductor; retain service slack for the 8 mm XIAO slide; trim after dry assembly'])
 old=(OLD/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8');retained=old[old.index('## Nova Plus 24'):old.index('## Revised routing and assembly')]
 guide='''# ON AIR v2.5 — third physical-fit build

Replace **05 rear housing, 06 yoke and 07 reset button** together. Print the new combined fit plate first. The front optical bezel, graphic backing, optical retainer, acrylic and original fasteners remain compatible. Read REVISION-NOTES.md for the measured dimensions and revised interfaces.

## Print and fit check

Open `bambu-studio/on-air-v25-X1C-eSUN-PLA-plus-fit-checks.3mf` as a complete project and retain its settings. The plate contains three parts: the continuous upper housing sample 99, the yoke 06 and button 07. Use the existing M3 nuts and two M3x8 yoke screws to test the assembly. The combined sample includes the actual mounting seats and surrounding corner material; individual section STLs remain available for targeted checks.

First-layer inspection remains disabled. Keep bed leveling enabled and watch the first two layers. The material variants include the successful eSUN PLA+ standard-nozzle settings, Generic PLA and PETG; select the actual spool and calibrate its flow. Print at 100% scale with the supplied orientations and a 0.4 mm nozzle.

Structural layers are 0.20 mm, with four walls and five top/bottom layers. The housing and upper fit section print flat back down. The yoke prints broad front rails down. **Automatic support is disabled for the housing, fit housing and yoke.** Their small holes and nut pockets still contain short bridges. Remove strings from the guide and nut pockets without cutting the bearing surfaces. The button uses 0.10 mm layers, an exterior-face-down orientation, a brim and small local supports at its flange; remove those before fitting.

Test the reset button by itself before adding the XIAO. Install the components in the sequence below, then check the real USB plugs, switch detents and twenty reset presses. The charger PCB thickness remains an unmeasured 1 mm assumption. The enlarged XIAO connector envelope includes assembly allowance but cannot establish the shape of every solder joint or cable overmold.

## Fasteners and optical parts

Retain four M3x25 socket-head closure screws, two M3x6 button-head optical screws, two M3x8 button-head yoke screws, and eight ordinary M3 nuts (5.5 mm across flats, 2.4 mm thick). The closure bores remain 3.6 mm; head recesses are 6.8 mm; nut traps are 6.0 mm across flats and 3.0 mm high. The yoke has a common front print face 0.25 mm deeper than v2.4 so its POWER roof starts on the bed. Main rails are 2.75 mm thick and local screw seats 1.75 mm. Underside seats and keeper tips stay fixed; the same M3x8 screws seat 0.25 mm deeper and retain about 0.55 mm blind-bore tip clearance. Hardware remains recessed.

The printed graphic uses black through Z=1.6 mm and white from the layer ending at 1.7 mm. The graphic's layers are 0.10 mm after the 0.20 mm first layer. Select the labeled AMS or manual-swap project. Only the manual graphic plate contains an intentional filament-change pause. Separate STLs do not carry color instructions.

'''+retained+'''
## Revised routing and assembly

1. Load all eight nuts before electronics and optics; turn the upper-left rear nut to match its rotated pocket and slide it upward from the open interior. Fit the reset button first, with the housing open and yoke removed. Hold the rounded outside end about 9 mm inward from its final position, lower the button from the open front into its clearance, then slide it outward through the side-wall guide. Its internal flange stops it falling out.
2. Insert the XIAO from the open front **8 mm below the seated position**, then slide it upward 8 mm into the top USB opening. This lets the USB socket pass the button tip. Keep the reset released and leave wire slack for this movement. The yoke's removable lower stop locks the board afterward.
3. Insert the charger and both switches from the open front. The POWER switch keeps its successful fit. Seat the larger MODE switch in its new body pocket, with the six legs in their clear spaces and the actual actuator through the top opening. No printed MODE slider is used.
4. Dry-install the yoke with its two M3x8 screws. Confirm the board and switch bodies sit squarely, both USB cables fully engage, the MODE and POWER actuators reach both detents, and reset moves and returns without loading the PCB. Do not use screw force to seat an obstructed part.
5. After the fit sample passes, print the production parts. Assemble the unchanged optical stack using the laser instructions above. Route each LED pigtail through its existing side exit and secure the optical retainer with the two M3x6 screws.
6. With the battery disconnected, solder and insulate the selected two-switch circuit. Use the existing inline 330-ohm resistor, 680-uF capacitor and internal pigtails. No new electronic components are introduced. Confirm actual pin functions with labels and continuity; routing coordinates are wire-dressing locations, not pin assignments.
7. Place the battery in its cradle with an insulated base and a loose nonconductive strap. Secure the capacitor and insulated junctions in the existing right-hand space. Follow `routing-map.svg` and the updated cut list. Keep wire clear of the vent openings, button, nut pockets, PCB supports and USB roofs. Route XIAO solder joints through the angled windows, with service slack for the upward slide.
8. Repeat the button-first/XIAO-second assembly and fit the remaining components. Install the yoke and repeat all mechanical tests. Use measured thin nonconductive shims only if needed; do not clamp ICs, exposed solder joints or the battery pouch.
9. With POWER off and MODE at PROGRAM, connect the internal pigtail and close the optical subassembly by hand. Install the four front M3x25 screws gently. Complete the retained electrical and thermal commissioning checks before wall mounting with removable adhesive strips.

## Validation limits

The record checks nominal solids, assembly paths, control motion, reserved wire space, the enlarged XIAO connector envelope, STL integrity and slicer output. It does not prove the next print's fit, removal force, strength, actual solder shape or thermal performance. The user's next combined fit sample is the acceptance test. The laser geometry is unchanged and retains the previous sheet-thickness and kerf calibration requirements. No printing, laser operation or firmware flashing is performed by this release process.
'''
 (DEST/'BUILD-AND-ASSEMBLY.md').write_text(guide,encoding='utf-8')
 (DEST/'START-HERE.md').write_text('''# ON AIR v2.5

Start with **bambu-studio/on-air-v25-X1C-eSUN-PLA-plus-fit-checks.3mf**: one continuous upper housing sample, yoke and reset button. Use the two M3x8 yoke screws and nuts for a representative test.

Read REVISION-NOTES.md and BUILD-AND-ASSEMBLY.md. Install the button first; insert the XIAO 8 mm low and slide it upward before fitting the yoke. Replace production parts 05, 06 and 07 together after this fit test passes.

First-layer inspection remains disabled; bed leveling remains available. The housing and yoke profiles use no automatic support. Only the small button uses support. Keep the supplied orientations and watch the first layers.

The acrylic SVGs and front optical parts remain unchanged. Actual acceptance of the new fits requires the next print.
''',encoding='utf-8')
 (DEST/'VALIDATION.md').write_text(f'''# v2.5 validation

- {len(n['motion_checks'])} sampled assembly and control paths passed.
- No native solid interference or unhealthy timeline features.
- All eight nuts have checked loading and sliding paths.
- Both DPDT terminal rows have uninterrupted clearance around the measured six-leg span.
- {len(w['items'])} wire and solder-space checks passed; all route pairs checked for simultaneous wire packing.
- The enlarged XIAO USB interior envelope clears the seated parts and the specified insertion sequence.
- {len(meshes)} meshes are watertight, single connected solids and placed on the print bed.
- Nine Bambu projects sliced and their meshes match the exported STLs.
- The eSUN PLA+ fit project opened, sliced and saved in the Bambu GUI; the saved copy preserves meshes, material settings and the inspection workaround. Its displayed estimate is recorded in the GUI validation file.
- First-layer inspection commands are absent; bed leveling, expected pauses and heater shutdown checked.
- Laser files match v2.4 byte for byte.

Physical fit and strength remain subject to the next combined fit sample. No physical fabrication was started.
''',encoding='utf-8')
 manifest={str(p.relative_to(DEST)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in DEST.rglob('*') if p.is_file() and p.name!='manifest.json'}
 (DEST/'manifest.json').write_text(json.dumps(manifest,indent=2))
 with zipfile.ZipFile(DEST.with_suffix('.zip'),'w',zipfile.ZIP_DEFLATED) as z:
  for p in DEST.rglob('*'):
   if p.is_file():z.write(p,str(Path(DEST.name)/p.relative_to(DEST)))
 print(DEST)
if __name__=='__main__':main()
