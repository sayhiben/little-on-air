from pathlib import Path
import json,shutil,csv,hashlib,zipfile
H=Path(__file__).resolve().parent;BASE=H.parent;O=BASE/'output/v27';PREV=BASE/'output/on-air-v26-fabrication';DEST=BASE/'output/on-air-v27-fabrication'
def cp(a,b):b.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(a,b)
def main():
 checks=['native-validation.json','harness-validation.json','wire-packing-validation.json','nut-access-validation.json','usb-and-optical-validation.json','archive-roundtrip-validation.json']
 for name in checks:assert json.loads((O/name).read_text())['passed'],name
 meshes=json.loads((O/'mesh-validation.json').read_text());assert len(meshes)==18 and all(r['watertight'] and r['connected_solids']==1 and r['min_z']==0 for r in meshes)
 sliced=json.loads((O/'bambu-studio/all-projects-validation.json').read_text());assert len(sliced)==9
 DEST.mkdir(parents=True,exist_ok=True)
 for folder in ('stl','fit-samples','optional-laminate'):
  for p in (O/folder).glob('*.stl'):cp(p,DEST/folder/p.name)
 for p in (PREV/'laser').iterdir():
  if p.is_file():cp(p,DEST/'laser'/p.name)
 for p in (O/'bambu-studio').glob('on-air-v27-X1C-*.3mf'):
  ready=O/'bambu-studio'/('sliced-'+p.stem)/p.name;assert ready.is_file();cp(ready,DEST/'bambu-studio'/p.name)
 for name in ('little-on-air-v27.f3d','little-on-air-v27-assembly.step','v27-production-fit-sections.f3d'):cp(O/name,DEST/'cad'/name)
 for name in checks+['mesh-validation.json']:cp(O/name,DEST/'validation'/name)
 cp(O/'bambu-studio/all-projects-validation.json',DEST/'validation/all-projects-validation.json')
 for p in (O/'views').glob('*.png'):cp(p,DEST/'views'/p.name)
 for name in ('routing-map.svg','routing-coordinates.json','harness-length-guide.csv','hardware-layout.json'):cp(O/name,DEST/name)
 cp(H/'REVISION-NOTES.md',DEST/'REVISION-NOTES.md')
 old=(PREV/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8')
 laser=old[old.index('## Nova Plus 24'):old.index('## Selected electrical circuit')]
 electrical=old[old.index('## Selected electrical circuit'):old.index('## Revised routing and assembly')]
 (DEST/'BUILD-AND-ASSEMBLY.md').write_text((H/'ASSEMBLY-REVISION.md').read_text()+'\n\n'+laser+'\n'+electrical,encoding='utf-8')
 with (PREV/'BOM.csv').open(newline='',encoding='utf-8-sig') as f:rows=list(csv.DictReader(f))
 for r in rows:
  if r['Ref']=='MCU1':r['Location']='Flat, components face front; open pad rows; front-frame reset and RGB hole'
  if r['Ref']=='CH1':r['Location']='Flat, components face back; both rear LED holes retained'
  if r['Ref']=='C1':r['Location']='On its side in right lower bay; across VBAT_SW and protected ground'
  if r['Ref']=='R1':r['Specification']='330 ohm; insulated body <=12 long x3.2 diameter';r['Location']='Behind LED1 in reserved inline assembly bay'
  if r['Ref']=='J1':r['Location']='Left lower service bay'
  if r['Ref']=='W1':r['Location']='Dressed LED bundles and individual leads; routing length guide'
  if r['Ref']=='W2':r['Location']='Paired power fanout and signal leads; OD <=0.8 for pairs'
  if r['Ref']=='T1':r['Quantity']='1';r['Location']='Battery through two integral lugs';r['Specification']='2.5 wide nonconductive strap; leave loose around pouch'
 with (DEST/'BOM.csv').open('w',newline='',encoding='utf-8') as f:w=csv.DictWriter(f,fieldnames=rows[0].keys());w.writeheader();w.writerows(rows)
 if (PREV/'COMMISSIONING.csv').exists():cp(PREV/'COMMISSIONING.csv',DEST/'COMMISSIONING.csv')
 fit=next(r for r in sliced if r['project']=='on-air-v27-X1C-eSUN-PLA-plus-fit-checks.3mf')
 (DEST/'START-HERE.md').write_text('''# ON AIR v2.7 — slim parallel-PCB case

Open **bambu-studio/on-air-v27-X1C-eSUN-PLA-plus-fit-checks.3mf** as a complete project. Print the four-part fit plate before the full body. Generic PLA and PETG fit projects are supplied too.

Opened and sliced successfully in Bambu Studio: estimated **2 h 8 min / 34.25 g** for the eSUN PLA+ fit plate, including preparation. No print was sent.

Body: **120 × 60 × 24 mm**, down from 34 mm. Including the front reset button: **26.5 mm maximum depth**. Both USB ports remain on top. Both PCBs are parallel to the display; XIAO faces forward and charger faces backward.

Replace production parts **01, 05, 06 and 07 together**. Keep acrylic, graphic backing03 and optical retainer04. All eight screws remain M3×8 button heads with ordinary M3 nuts. The upper-right case screw moves to the corner.

- `REVISION-NOTES.md`: changed interfaces and nominal fits.
- `BUILD-AND-ASSEMBLY.md`: print, assembly, routing, retained electrical procedure and laser instructions.
- `BOM.csv`: retained circuit and materials; no additional electronics.
- `routing-map.svg` and `routing-coordinates.json`: placement and wire corridors.
- `stl/`: oriented production meshes, millimetres, 100% scale.
- `fit-samples/`: actual clipped production geometry.
- `bambu-studio/`: sliced X1C projects for eSUN PLA+, generic PLA and PETG; AMS and manual-color-swap variants.
- `laser/02-acrylic-REAR-engrave-and-cut.svg`: unchanged 104 × 38 acrylic master, already mirrored for rear engraving.
- `cad/`: native Fusion assembly, STEP assembly and native fit sections.
- `validation/`: exact geometry and slicing check records.

First-layer inspection is disabled, retaining the successful workaround; bed leveling remains enabled. Only the button uses automatic support. No print or laser job has been sent.

The fit print remains the check for real tolerances and solder shape. Charger PCB thickness remains a 1.0 mm assumption; measure acrylic thickness and laser kerf on the actual stock.
''',encoding='utf-8')
 n=json.loads((O/'native-validation.json').read_text());h=json.loads((O/'harness-validation.json').read_text());w=json.loads((O/'wire-packing-validation.json').read_text())
 (DEST/'VALIDATION.md').write_text(f'''# v2.7 validation

- Native Fusion: no feature errors or measured-envelope overlaps. {len(n['motion_checks'])} fresh assembly/control motion checks passed, plus sight-line, pad-exit and pre-soldered insertion probes.
- USB checks include a 0.15 mm enlarged socket envelope and reset motion against the PCB/USB/LED. Optical screw heads clear the keeper during closure.
- All eight nut loading paths and common M3×8 stacks checked. Nut engagement is the full 2.4 mm thickness; all screw tips remain inside blind clearances.
- {len(h['items'])} native wire-route, auxiliary-bay and individual LED-exit reservations pass against the assembly, including actual hardware. Revised routes replace earlier path results against unchanged solids.
- {w['pairs_checked']} route pairs checked for simultaneous wire packing. Contacts are allowed only in the documented terminal/junction bays, where leads are spread during assembly.
- {len(meshes)} STL meshes are watertight, each one connected solid with positive bed contact and Z=0 in its print orientation.
- Nine Bambu projects sliced with no warnings; saved meshes match the corresponding STLs. First-layer inspection is absent, bed leveling remains, normal heater shutdown is present. Only manual graphic plates contain a deliberate filament-change pause.
- The packaged four-part eSUN PLA+ fit project also opened and sliced in the Bambu Studio GUI, showing 2 h 8 min and 34.25 g, with no warnings. No print was sent.
- Saved Fusion archive re-imports with matching body volumes and no static overlaps. Laser SVGs exactly match the previous validated optical files.

These are geometric, envelope and slicer checks. They do not certify physical printer tolerances, switch actuation force, cable overmould fit, optical output, radio range, charge-current suitability or thermal behavior. Use the physical fit plate and retained commissioning procedure. No hardware operation has been started.
''',encoding='utf-8')
 manifest={str(p.relative_to(DEST)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(DEST.rglob('*')) if p.is_file() and p.name!='SHA256.json'}
 (DEST/'SHA256.json').write_text(json.dumps(manifest,indent=2))
 target=DEST.with_suffix('.zip')
 with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
  for p in DEST.rglob('*'):
   if p.is_file():z.write(p,DEST.name+'/'+p.relative_to(DEST).as_posix())
 for name,digest in manifest.items():assert hashlib.sha256((DEST/name).read_bytes()).hexdigest()==digest
 with zipfile.ZipFile(target) as z:
  assert z.testzip() is None
  for name,digest in manifest.items():assert hashlib.sha256(z.read(DEST.name+'/'+name)).hexdigest()==digest
 print(json.dumps({'folder':str(DEST),'zip':str(target),'files':len(manifest)+1,'stls':len(meshes),'bambu_projects':len(sliced),'zip_bytes':target.stat().st_size},indent=2))
if __name__=='__main__':main()
