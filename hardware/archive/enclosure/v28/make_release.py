from pathlib import Path
import json,shutil,hashlib,zipfile
H=Path(__file__).resolve().parent;BASE=H.parent;O=BASE/'output/v28';PREV=BASE/'output/on-air-v27-fabrication';DEST=BASE/'output/on-air-v28-fabrication'
def cp(a,b):b.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(a,b)
def main():
 checks=['native-validation.json','harness-validation.json','wire-packing-validation.json','nut-access-validation.json','usb-and-optical-validation.json','archive-roundtrip-validation.json','changed-interface-validation.json']
 for name in checks:assert json.loads((O/name).read_text())['passed'],name
 meshes=json.loads((O/'mesh-validation.json').read_text());assert len(meshes)==18 and all(r['watertight'] and r['connected_solids']==1 and r['min_z']==0 for r in meshes)
 sliced=json.loads((O/'bambu-studio/all-projects-validation.json').read_text());assert len(sliced)==9
 for folder in ('stl','fit-samples','optional-laminate'):
  for p in (O/folder).glob('*.stl'):cp(p,DEST/folder/p.name)
 for p in (PREV/'laser').iterdir():
  if p.is_file():cp(p,DEST/'laser'/p.name)
 for p in (O/'bambu-studio').glob('on-air-v28-X1C-*.3mf'):
  ready=O/'bambu-studio'/('sliced-'+p.stem)/p.name;assert ready.is_file();cp(ready,DEST/'bambu-studio'/p.name)
 for name in ('little-on-air-v28.f3d','little-on-air-v28-assembly.step','v28-production-fit-sections.f3d'):cp(O/name,DEST/'cad'/name)
 for name in checks+['mesh-validation.json','revision-changes.json']:cp(O/name,DEST/'validation'/name)
 cp(O/'bambu-studio/all-projects-validation.json',DEST/'validation/all-projects-validation.json')
 cp(O/'bambu-gui-verification.json',DEST/'validation/bambu-gui-verification.json')
 for p in (O/'views').glob('*.png'):cp(p,DEST/'views'/p.name)
 for name in ('routing-map.svg','routing-coordinates.json','harness-length-guide.csv'):cp(O/name,DEST/name)
 for name in ('hardware-layout.json','BOM.csv','COMMISSIONING.csv'):cp(PREV/name,DEST/name)
 cp(H/'REVISION-NOTES.md',DEST/'REVISION-NOTES.md')
 assembly=(PREV/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8')
 assembly=assembly.replace('# v2.7 — revised mechanical assembly','# v2.8 — revised mechanical assembly')
 assembly=assembly.replace('Print the combined fit plate first.','Print the two-part replacement fit plate first, reusing v2.7 upper front sample 91 and keeper 06.')
 assembly=assembly.replace('It contains front sample 91, rear sample 99, keeper 06 and front reset button 07.','It contains revised rear sample 99 and reset button 07; those are the only new fit parts needed.')
 assembly=assembly.replace('The positive stop permits 0.60 mm travel; adjust only after identifying the actual contact gap.','The revised collar permits 0.80 mm total travel, 0.20 mm more than the previous print. Confirm a light click before the stop and full release. The simplified CAD switch envelope cannot establish the true actuation force or travel; do not force the mechanism.')
 assembly=assembly.replace('After the sample passes, print full parts 01 and 05 and retain the tested 06/07 if their fit is good. The new upper-right screw position requires both new case halves. Existing acrylic, graphic backing and optical retainer remain usable.','After the sample passes, print full rear housing 05 and keep the new tested button 07. Reuse the v2.7 front frame, keeper 06, acrylic, graphic backing and optical retainer. If building from an older revision, use the complete v2.8 case set.')
 assembly=assembly.replace('The two LED centers align with the rear holes.','The two LED centers align with the rear holes. Both solid lower corners must engage the widened 17.5 mm stop; the center indentation need not make contact.')
 (DEST/'BUILD-AND-ASSEMBLY.md').write_text(assembly,encoding='utf-8')
 fit=next(r for r in sliced if r['project']=='on-air-v28-X1C-eSUN-PLA-plus-fit-checks.3mf')
 (DEST/'START-HERE.md').write_text('''# ON AIR v2.8 — two replacement parts

Open **bambu-studio/on-air-v28-X1C-eSUN-PLA-plus-fit-checks.3mf** as a complete project. It contains revised upper rear sample 99 and reset button 07. Reuse your v2.7 upper front sample 91 and keeper 06. Generic PLA and PETG projects are included too.

The packaged eSUN PLA+ fit project was opened and sliced in Bambu Studio: **1 h 22 min / 22.40 g**, including preparation. It is ready in Preview; no print was sent.

The charger stop is now the full 17.5 mm board width. The reset collar is 0.20 mm shorter, adding 0.20 mm of travel without changing the tip's rest position or guide fit.

After testing both charger corner contact and a light reset click with full release, print full **05 rear housing**. Retain the tested new **07 button** and reuse the other v2.7 parts. Full production projects are also supplied for a fresh build.

`REVISION-NOTES.md` explains the changes. `BUILD-AND-ASSEMBLY.md` includes the revised test and retained wiring/laser instructions. `stl/` contains oriented millimetre meshes; `cad/` contains native Fusion and STEP files. `laser/` contains the unchanged acrylic files, including the already mirrored rear-engraving master. `validation/` contains the checks and their limits.

Body: 120 × 60 × 24 mm; 26.5 mm including the unpressed front button. Eight M3×8 button-head screws and ordinary M3 nuts. No electrical or optical changes.

The button uses 0.10 mm layers and automatic support. First-layer inspection remains disabled and bed leveling enabled. No print or laser job has been sent.
''',encoding='utf-8')
 n=json.loads((O/'native-validation.json').read_text());h=json.loads((O/'harness-validation.json').read_text());w=json.loads((O/'wire-packing-validation.json').read_text())
 (DEST/'VALIDATION.md').write_text(f'''# v2.8 validation

- Only production parts 05 and 07 change. The model restores contact patches at both charger bottom corners and a continuous 17.5 mm edge stop.
- Reset collar dimensions measured from the resulting solid: 2.85 mm thick. No keeper contact through 0.80 mm travel; keeper contact confirmed beyond that stop. Resting tip and projection are unchanged. An additional 81-pose control sweep passes against rigid PCB, USB, LED and case envelopes.
- {len(n['motion_checks'])} full native assembly/control checks pass; no feature errors or static overlaps. USB clearance, all eight nut-loading paths, solder exits and prewired board insertion checks pass.
- All {len(h['items'])} wire-route, component-bay and individual LED-exit reservations were rechecked against the final assembly. All {w['pairs_checked']} route-pair packing checks pass.
- All {len(meshes)} STL meshes are watertight, connected solids, oriented with positive bed contact at Z=0.
- Nine Bambu projects slice without warnings. Project meshes match the exported STL meshes. First-layer inspection is disabled; normal bed leveling and heater shutdown remain. Only the full manual-color-swap graphic plate contains a deliberate filament-change pause.
- The packaged eSUN PLA+ fit project also opens and slices successfully in the Bambu Studio GUI: two objects, 1 h 22 min and 22.40 g. No print was sent.
- Native Fusion archive reopens with matching volumes. Laser files are unchanged from v2.7.

The physical print reaches reset contact later than the simplified CAD target predicts. Therefore overlap with that target is not a valid switch depression/force calculation. The new motion limit is 0.20 mm beyond the empirically reported old stop. Nominal clearance from the plunger to the bare PCB at the new stop is only 0.05 mm; this is an envelope check, not a tolerance guarantee. Confirm a light click and release before the stop with the fit parts; do not force a jammed button. Actual charger indentation shape, PCB thickness, solder shape and printer accuracy still require physical fitting.
''',encoding='utf-8')
 # Unchanged meshes must remain geometrically and byte identical to v2.7.
 for p in (DEST/'stl').glob('*.stl'):
  if p.name[:2] not in ('05','07'):assert p.read_bytes()==(PREV/'stl'/p.name).read_bytes(),p.name
 for p in (DEST/'laser').iterdir():assert p.read_bytes()==(PREV/'laser'/p.name).read_bytes()
 manifest={p.relative_to(DEST).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(DEST.rglob('*')) if p.is_file() and p.name!='SHA256.json'}
 (DEST/'SHA256.json').write_text(json.dumps(manifest,indent=2))
 target=DEST.with_suffix('.zip')
 with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
  for p in DEST.rglob('*'):
   if p.is_file():z.write(p,DEST.name+'/'+p.relative_to(DEST).as_posix())
 with zipfile.ZipFile(target) as z:
  assert z.testzip() is None
  for name,digest in manifest.items():assert hashlib.sha256(z.read(DEST.name+'/'+name)).hexdigest()==digest
 print(json.dumps({'folder':str(DEST),'zip':str(target),'files':len(manifest)+1,'stls':len(meshes),'bambu_projects':len(sliced),'zip_bytes':target.stat().st_size},indent=2))
if __name__=='__main__':main()
