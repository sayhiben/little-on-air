from pathlib import Path
import json,csv,hashlib,shutil,zipfile,math
H=Path(__file__).resolve().parent;B=H.parent;O=B/'output/v26';OLD=B/'output/on-air-v25-fabrication';D=B/'output/on-air-v26-fabrication'
def main():
 n=json.loads((O/'native-validation.json').read_text());assert not n['feature_issues'] and not n['interferences'] and len(n['motion_checks'])==16 and all(c['passed'] for c in n['motion_checks'])
 reports=['harness-validation.json','wire-packing-validation.json','usb-space-validation.json','archive-roundtrip-validation.json','nut-access-validation.json','terminal-row-validation.json','reset-fit-validation.json','service-fit-validation.json','bambu-gui-validation.json','final-screw-wire-validation.json','prewired-insertion-validation.json']
 for f in reports:assert json.loads((O/f).read_text())['passed'],f
 meshes=json.loads((O/'mesh-validation.json').read_text());assert len(meshes)==18 and all(m['watertight'] and m['connected_solids']==1 for m in meshes)
 slices=json.loads((O/'bambu-studio/all-projects-validation.json').read_text());assert len(slices)==9
 for sub in ('stl','fit-samples','optional-laminate'):shutil.copytree(O/sub,D/sub,dirs_exist_ok=True)
 shutil.copytree(OLD/'laser',D/'laser',dirs_exist_ok=True)
 for sub in ('cad','validation','views','bambu-studio'):(D/sub).mkdir(exist_ok=True)
 for f in ('little-on-air-v26.f3d','little-on-air-v26-assembly.step','v26-production-fit-sections.f3d'):shutil.copy2(O/f,D/'cad'/f)
 for p in (O/'views').glob('*.png'):
  if p.name!='native-harness-clearances.png':shutil.copy2(p,D/'views'/p.name)
 for f in reports+['native-validation.json','mesh-validation.json','hardware-layout.json']:shutil.copy2(O/f,D/'validation'/f)
 shutil.copy2(O/'bambu-studio/all-projects-validation.json',D/'validation/bambu-projects.json')
 for r in slices:
  name=r['project'];shutil.copy2(O/'bambu-studio'/('sliced-'+Path(name).stem)/name,D/'bambu-studio'/name)
 for name in ('REVISION-NOTES.md','START-HERE.md','VALIDATION.md'):shutil.copy2(H/name,D/name)
 shutil.copy2(O/'routing-map.svg',D/'routing-map.svg')
 laser={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (D/'laser').iterdir() if p.is_file()}
 assert laser=={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (OLD/'laser').iterdir() if p.is_file()}
 (D/'validation/unchanged-laser.json').write_text(json.dumps(laser,indent=2))
 rows=[r for r in csv.DictReader((OLD/'BOM.csv').open(encoding='utf-8-sig')) if r['Ref'] not in ('H2','H3')]
 for r in rows:
  if r['Ref']=='H1':r.update({'Quantity':'8','Item':'M3 x8 button-head screws','Specification':'Head <=5.7 diameter x1.65 high; 8 mm under-head length; no washers','Location':'4 closure, 2 optical retainer, 2 electronics yoke'})
  if r['Ref']=='CH1':r['Location']='Flipped component face toward back; rear LED holes clear of adhesive strips'
  if r['Ref']=='MCU1':r['Location']='2 mm inboard; open pad-edge channels and underside BAT/GND notch'
  if r['Ref']=='S2':r['Location']='9.5 mm body-width pocket; .15 mm total retained depth clearance'
 with (D/'BOM.csv').open('w',newline='',encoding='utf-8') as f:
  wr=csv.DictWriter(f,fieldnames=rows[0].keys());wr.writeheader();wr.writerows(rows)
 shutil.copy2(OLD/'COMMISSIONING.csv',D/'COMMISSIONING.csv')
 w=json.loads((O/'harness-validation.json').read_text())
 with (D/'wire-cut-list.csv').open('w',newline='',encoding='utf-8') as f:
  wr=csv.writer(f);wr.writerow(['Route','CAD route length mm','Starting wire length mm','Note'])
  for r in w['items']:
   if 'route_length_mm' in r:wr.writerow([r['name'],r['route_length_mm'],math.ceil((r['route_length_mm']+35)/5)*5,'Per conductor; solder XIAO outside case; retain slack for 8 mm slide; trim after dry assembly'])
 old=(OLD/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8');retained=old[old.index('## Nova Plus 24'):old.index('## Revised routing and assembly')]
 guide=(H/'BUILD-MECHANICAL.md').read_text(encoding='utf-8').replace('<!-- RETAINED LASER AND ELECTRICAL GUIDE -->',retained)
 (D/'BUILD-AND-ASSEMBLY.md').write_text(guide,encoding='utf-8')
 manifest={str(p.relative_to(D)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in D.rglob('*') if p.is_file() and p.name!='manifest.json'}
 (D/'manifest.json').write_text(json.dumps(manifest,indent=2))
 with zipfile.ZipFile(D.with_suffix('.zip'),'w',zipfile.ZIP_DEFLATED) as z:
  for p in D.rglob('*'):
   if p.is_file():z.write(p,str(Path(D.name)/p.relative_to(D)))
 print(D)
if __name__=='__main__':main()
