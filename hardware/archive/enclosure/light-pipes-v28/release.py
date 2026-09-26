from pathlib import Path
import shutil,json,hashlib,zipfile
BASE=Path(__file__).resolve().parents[1];SRC=BASE/'output/v28-light-pipes';DST=BASE/'output/on-air-v28-light-pipes'
assert json.loads((SRC/'native-validation.json').read_text())['passed']
assert json.loads((SRC/'harness-validation.json').read_text())['passed']
assert json.loads((SRC/'slicing-validation.json').read_text())['passed']
DST.mkdir(exist_ok=True)
for folder in ['stl','views']:
 shutil.copytree(SRC/folder,DST/folder,dirs_exist_ok=True)
for folder in ['cad','bambu-studio','validation']:(DST/folder).mkdir(exist_ok=True)
for name in ['little-on-air-v28-light-pipes.f3d','little-on-air-v28-light-pipes.step']:shutil.copy2(SRC/name,DST/'cad'/name)
shutil.copy2(SRC/'bambu-studio/sliced/on-air-v28-clear-PETG-light-pipes.3mf',DST/'bambu-studio/on-air-v28-clear-PETG-light-pipes.3mf')
for name in ['native-validation.json','harness-validation.json','mesh-validation.json','slicing-validation.json','plate-manifest.json']:shutil.copy2(SRC/name,DST/'validation'/name)
shutil.copy2(SRC/'bambu-studio/sliced/result.json',DST/'validation/slicer-result.json')
shutil.copy2(Path(__file__).with_name('README.md'),DST/'README.md')
(DST/'BOM.csv').write_text('Part,Quantity,Material,Notes\n08 front RGB guide,1,Clear PETG,Choose 2.95 or 3.05 or 3.15 mm fit\n09 charger guide,2,Clear PETG,Choose fit independently for each hole\nOptional collar retention,As needed,Removable adhesive,Only if friction fit permits axial movement; keep clear of optics and electronics\n')
manifest={str(p.relative_to(DST)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(DST.rglob('*')) if p.is_file() and p.name!='SHA256.json'}
(DST/'SHA256.json').write_text(json.dumps(manifest,indent=2))
with zipfile.ZipFile(DST.with_suffix('.zip'),'w',zipfile.ZIP_DEFLATED) as z:
 for p in sorted(DST.rglob('*')):
  if p.is_file():z.write(p,str(p.relative_to(DST)).replace('\\','/'))
with zipfile.ZipFile(DST.with_suffix('.zip')) as z:
 assert z.testzip() is None
 assert all(hashlib.sha256(z.read(n)).hexdigest()==v for n,v in manifest.items())
print(json.dumps({'folder':str(DST),'zip':str(DST.with_suffix('.zip')),'files':len(manifest)+1},indent=2))
