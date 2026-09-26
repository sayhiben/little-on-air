from pathlib import Path
import json,re,zipfile,importlib.util,math,collections,shutil,hashlib
import numpy as np
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v213';DST=BASE/'output/on-air-v213-captive-light-guides'
s=importlib.util.spec_from_file_location('project_audit',str(BASE/'audit_print_projects.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
projects=json.loads((OUT/'plate-manifest.json').read_text());reports=[]
for p in projects:
 for path in (OUT/'bambu-studio'/p['name'],OUT/p['sliced']/p['name']):
  meshes,config,cfg=a.project_meshes(path);assert len(meshes)==3
  assert cfg['scan_first_layer']=='0' and cfg['enable_support']==('0' if p['optical'] else '1')
  assert cfg['filament_self_index']==['1'] and cfg['filament_extruder_variant']==['Direct Drive Standard']
  if p['optical']:assert cfg['wall_loops']=='1' and cfg['infill_direction']=='0' and cfg['sparse_infill_density']=='100%' and cfg['layer_height']=='0.1'
  else:assert cfg['wall_loops']=='4' and cfg['layer_height']=='0.2'
  for ob in config.findall('object'):
   md={m.attrib.get('key'):m.attrib.get('value') for m in ob.findall('metadata')}
   assert md['enable_support']==('1' if md['name'].startswith('11-') else '0')
  bounds=[]
  for obj in meshes.values():
   raw=a.stl(OUT/'stl'/obj['name']);tri=obj['triangles'];delta=tri.reshape(-1,3).min(axis=0)-raw.reshape(-1,3).min(axis=0)
   assert tri.shape==raw.shape and np.allclose(tri-delta,raw,atol=.00001,rtol=0),obj['name']
   lo=tri.reshape(-1,3).min(axis=0);hi=tri.reshape(-1,3).max(axis=0);assert abs(lo[2])<.00005 and lo[0]>6 and lo[1]>6 and hi[0]<250 and hi[1]<250
   bounds.append((lo,hi))
  for i,(lo,hi) in enumerate(bounds):
   for lo2,hi2 in bounds[:i]:assert any(max(lo[k]-hi2[k],lo2[k]-hi[k])>(2 if p['optical'] else 6) for k in (0,1))
 code=(OUT/p['sliced']/'plate_1.gcode').read_text().splitlines();active=[l.split(';')[0].strip() for l in code]
 assert not any(re.match(r'M97[67](?:\s|$)',l) for l in active)
 assert not any(re.match(r'(?:M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',l) for l in active)
 assert 'M104 S0' in active and 'M140 S0' in active and any(l.startswith('G29 A ') for l in active)
 report={'name':p['name'],'objects':3,'source_and_sliced_meshes_match_STLs':True,'first_layer_inspection_disabled':True,'no_pauses':True,'bed_leveling_and_heater_shutdown_present':True}
 if not p['optical']:
  role='';x=y=0;support=[]
  for line in code:
   if line.startswith('; FEATURE:'):role=line.split(':',1)[1].strip()
   bare=line.split(';')[0].strip()
   if bare.startswith(('G0 ','G1 ','G2 ','G3 ')):
    v={k:float(q) for k,q in re.findall(r'([XYE])([-0-9.]+)',bare)};nx=v.get('X',x);ny=v.get('Y',y)
    if role.startswith('Support') and v.get('E',0)>0 and math.hypot(nx-x,ny-y)>.02:support.extend([(x,y),(nx,ny)])
    x,y=nx,ny
  assert support and all(193<x<221 and 114<y<142 for x,y in support),'Support must be confined to keeper 11'
  report['support_confined_to_keeper_11']=True;report['support_xy_bounds_mm']=[[min(q[k] for q in support) for k in (0,1)],[max(q[k] for q in support) for k in (0,1)]]
 if p['optical']:
  role='';z=0;x=y=0;counts=collections.Counter();bad=[]
  for line in code:
   if line.startswith('; FEATURE:'):role=line.split(':',1)[1].strip()
   if line.startswith('; Z_HEIGHT:'):z=float(line.split(':')[1])
   bare=line.split(';')[0].strip()
   if bare.startswith(('G0 ','G1 ','G2 ','G3 ')):
    v={k:float(q) for k,q in re.findall(r'([XYEF])([-0-9.]+)',bare)};nx=v.get('X',x);ny=v.get('Y',y);dist=math.hypot(nx-x,ny-y)
    if bare.startswith('G1 ') and v.get('E',0)>0 and z>0 and dist>1 and role in ('Sparse infill','Internal solid infill','Bottom surface','Top surface'):
     counts[role]+=1
     if abs(ny-y)>.02:bad.append({'z':z,'role':role,'from':[x,y],'to':[nx,ny]})
    x,y=nx,ny
  assert sum(counts.values())>100 and not bad
  report.update({'long_straight_fill_runs_parallel_to_guide_axes':dict(counts),'off_axis_fill_runs':bad,'direction_audit_threshold_mm':1})
 result=json.loads((OUT/p['sliced']/'result.json').read_text());assert result['return_code']==0 and all(not q['warning_message'] for q in result['sliced_plates']);report['slicer']=result;reports.append(report)
(OUT/'slicing-validation.json').write_text(json.dumps({'passed':True,'projects':reports},indent=2))
for file in ('native-validation.json','harness-validation.json','perimeter-validation.json','slicing-validation.json'):assert json.loads((OUT/file).read_text())['passed']
assert all(q['watertight'] and q['connected_solids']==1 and q['min_z']==0 for q in json.loads((OUT/'mesh-validation.json').read_text()))
DST.mkdir(exist_ok=True)
for folder in ('stl','views'):shutil.copytree(OUT/folder,DST/folder,dirs_exist_ok=True)
for folder in ('cad','validation','bambu-studio'):(DST/folder).mkdir(exist_ok=True)
for p in projects:shutil.copy2(OUT/p['sliced']/p['name'],DST/'bambu-studio'/p['name'])
for name in ('little-on-air-v213.f3d','little-on-air-v213-assembly.step'):shutil.copy2(OUT/name,DST/'cad'/name)
for name in ('native-validation.json','harness-validation.json','perimeter-validation.json','slicing-validation.json','mesh-validation.json','plate-manifest.json','build-record.json'):shutil.copy2(OUT/name,DST/'validation'/name)
for name in ('README.md','BOM.csv'):shutil.copy2(Path(__file__).with_name(name),DST/name)
manifest={str(p.relative_to(DST)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(DST.rglob('*')) if p.is_file() and p.name!='SHA256.json'}
(DST/'SHA256.json').write_text(json.dumps(manifest,indent=2))
with zipfile.ZipFile(DST.with_suffix('.zip'),'w',zipfile.ZIP_DEFLATED) as z:
 for p in sorted(DST.rglob('*')):
  if p.is_file():z.write(p,str(p.relative_to(DST)).replace('\\','/'))
with zipfile.ZipFile(DST.with_suffix('.zip')) as z:assert z.testzip() is None and all(hashlib.sha256(z.read(n)).hexdigest()==v for n,v in manifest.items())
print(json.dumps({'folder':str(DST),'files':len(manifest)+1,'projects':[{'name':r['name'],'time_s':r['slicer']['sliced_plates'][0]['total_predication'],'filaments':r['slicer']['sliced_plates'][0]['filaments']} for r in reports]},indent=2))
