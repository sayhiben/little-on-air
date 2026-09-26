from pathlib import Path
import importlib.util,json,zipfile,re,shutil,hashlib
import numpy as np
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v212';DST=BASE/'output/on-air-v212-clean-perimeter-front'
s=importlib.util.spec_from_file_location('audit29',str(BASE/'audit_print_projects.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
reports=[]
for material in ['eSUN-PLA-plus','PETG']:
 name=f'on-air-v212-X1C-{material}-clean-perimeter-front.3mf'
 for path in [OUT/'bambu-studio'/name,OUT/'bambu-studio'/('sliced-'+material)/name]:
  meshes,config,cfg=a.project_meshes(path);assert len(meshes)==1
  assert cfg['wall_loops']=='4' and cfg['layer_height']=='0.2' and cfg['enable_support']=='0' and cfg['scan_first_layer']=='0'
  assert cfg['filament_self_index']==['1'] and cfg['filament_extruder_variant']==['Direct Drive Standard']
  obj=next(iter(meshes.values()));raw=a.stl(OUT/'stl'/obj['name']);tri=obj['triangles'];delta=tri.reshape(-1,3).min(axis=0)-raw.reshape(-1,3).min(axis=0)
  assert tri.shape==raw.shape and np.allclose(tri-delta,raw,atol=.00001,rtol=0)
  lo=tri.reshape(-1,3).min(axis=0);hi=tri.reshape(-1,3).max(axis=0);assert abs(lo[2])<.00005 and lo[0]>9 and lo[1]>9 and hi[0]<247 and hi[1]<247
 code=(OUT/'bambu-studio'/('sliced-'+material)/'plate_1.gcode').read_text().splitlines();active=[l.split(';')[0].strip() for l in code]
 assert not any(re.match(r'M97[67](?:\s|$)',l) for l in active)
 assert not any(re.match(r'(?:M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',l) for l in active)
 assert 'M104 S0' in active and 'M140 S0' in active and any(l.startswith('G29 A ') for l in active)
 result=json.loads((path.parent/'result.json').read_text());assert result['return_code']==0 and all(not p['warning_message'] for p in result['sliced_plates'])
 reports.append({'material':material,'source_and_sliced_mesh_match_STL':True,'first_layer_inspection_disabled':True,'no_pauses':True,'normal_heater_shutdown':True,'bed_leveling':True,'slicer':result})
(OUT/'slicing-validation.json').write_text(json.dumps({'passed':True,'projects':reports},indent=2))
assert json.loads((OUT/'native-validation.json').read_text())['passed']
assert json.loads((OUT/'perimeter-validation.json').read_text())['passed']
assert json.loads((OUT/'seam-wire-clearance.json').read_text())['passed']
assert all(r['watertight'] and r['connected_solids']==1 and r['min_z']==0 for r in json.loads((OUT/'mesh-validation.json').read_text()))
for folder in ['stl','views']:shutil.copytree(OUT/folder,DST/folder,dirs_exist_ok=True)
for folder in ['cad','bambu-studio','validation']:(DST/folder).mkdir(exist_ok=True)
for name in ['little-on-air-v212.f3d','little-on-air-v212-assembly.step']:shutil.copy2(OUT/name,DST/'cad'/name)
for r in reports:
 material=r['material'];name=f'on-air-v212-X1C-{material}-clean-perimeter-front.3mf';shutil.copy2(OUT/'bambu-studio'/('sliced-'+material)/name,DST/'bambu-studio'/name)
for name in ['native-validation.json','mesh-validation.json','slicing-validation.json','seam-wire-clearance.json','perimeter-validation.json']:shutil.copy2(OUT/name,DST/'validation'/name)
shutil.copy2(Path(__file__).with_name('README.md'),DST/'README.md')
manifest={str(p.relative_to(DST)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(DST.rglob('*')) if p.is_file() and p.name!='SHA256.json'}
(DST/'SHA256.json').write_text(json.dumps(manifest,indent=2))
with zipfile.ZipFile(DST.with_suffix('.zip'),'w',zipfile.ZIP_DEFLATED) as z:
 for p in sorted(DST.rglob('*')):
  if p.is_file():z.write(p,str(p.relative_to(DST)).replace('\\','/'))
with zipfile.ZipFile(DST.with_suffix('.zip')) as z:
 assert z.testzip() is None and all(hashlib.sha256(z.read(n)).hexdigest()==h for n,h in manifest.items())
print(json.dumps({'release':str(DST),'files':len(manifest)+1,'materials':[{'name':r['material'],'time_s':r['slicer']['sliced_plates'][0]['total_predication'],'filaments':r['slicer']['sliced_plates'][0]['filaments']} for r in reports]},indent=2))
