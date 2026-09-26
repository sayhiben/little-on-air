from pathlib import Path
import json,re,zipfile,importlib.util,collections,math
import numpy as np
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v28-light-pipes';P=OUT/'bambu-studio'
s=importlib.util.spec_from_file_location('mesh_audit',str(BASE/'audit_print_projects.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
reports=[]
for path in [P/'on-air-v28-clear-PETG-light-pipes.3mf',P/'sliced/on-air-v28-clear-PETG-light-pipes.3mf']:
 meshes,config,cfg=a.project_meshes(path);assert len(meshes)==9
 assert cfg['filament_colour']==['#D8EDF0'] and cfg['wall_loops']=='1' and cfg['enable_support']=='0'
 assert cfg['scan_first_layer']=='0' and cfg['sparse_infill_density']=='100%' and cfg['infill_direction']=='0'
 assert cfg['filament_self_index']==['1'] and cfg['filament_extruder_variant']==['Direct Drive Standard']
 for obj in meshes.values():
  raw=a.stl(OUT/'stl'/obj['name']);tri=obj['triangles'];delta=tri.reshape(-1,3).min(axis=0)-raw.reshape(-1,3).min(axis=0)
  assert tri.shape==raw.shape and np.allclose(tri-delta,raw,atol=.00001,rtol=0),obj['name']
  lo=tri.reshape(-1,3).min(axis=0);hi=tri.reshape(-1,3).max(axis=0)
  assert abs(lo[2])<.00005 and lo[0]>6 and lo[1]>6 and hi[0]<250 and hi[1]<250
 reports.append({'project':path.name,'stage':path.parent.name,'objects':9,'mesh_match':True})
code=(P/'sliced/plate_1.gcode').read_text().splitlines();role='';z=0;x=y=0;segments=[];byrole=collections.defaultdict(lambda:collections.Counter());bylayer=collections.defaultdict(lambda:collections.Counter())
for line in code:
 if line.startswith('; FEATURE:'):role=line.split(':',1)[1].strip()
 if line.startswith('; Z_HEIGHT:'):z=float(line.split(':')[1])
 bare=line.split(';')[0].strip()
 if bare.startswith(('G0 ','G1 ','G2 ','G3 ')):
  v={k:float(q) for k,q in re.findall(r'([XYEF])([-0-9.]+)',bare)};nx=v.get('X',x);ny=v.get('Y',y);dx=nx-x;dy=ny-y;dist=math.hypot(dx,dy)
  if bare.startswith('G1 ') and v.get('E',0)>0 and z>0 and dist>1 and role in ('Sparse infill','Internal solid infill','Bottom surface','Top surface'):
   aligned=abs(dy)<.02;byrole[role]['aligned' if aligned else 'other']+=1;bylayer[z]['aligned' if aligned else 'other']+=1
   segments.append((z,role,x,y,nx,ny,aligned))
  x,y=nx,ny
active=[l.split(';')[0].strip() for l in code]
assert not any(re.match(r'M97[67](?:\s|$)',l) for l in active)
assert not any(re.match(r'(?:M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',l) for l in active)
assert 'M104 S0' in active and 'M140 S0' in active and any(l.startswith('G29 A ') for l in active)
r={'projects':reports,'long_fill_runs_by_role':dict(byrole),'long_fill_runs_by_layer':dict(bylayer),'aligned_axis':'bed X, the long axis of every guide','threshold':'Extruding straight infill runs longer than 1 mm; short connections and perimeter turns excluded.','first_layer_inspection_disabled':True,'no_pauses':True,'bed_leveling_present':True,'shutdown_present':True}
r['off_axis_segments']=[s for s in segments if not s[-1]]
r['passed']=len(segments)>200 and sum(s['other'] for s in byrole.values())==0
(OUT/'slicing-validation.json').write_text(json.dumps(r,indent=2));print(json.dumps(r,indent=2));assert r['passed']
