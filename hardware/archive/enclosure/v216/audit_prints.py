from pathlib import Path
import importlib.util,json,zipfile,re,collections,xml.etree.ElementTree as E
import numpy as np
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v216';OLD=BASE.parents[1]/'release/little-on-air-enclosure-v2.15'
ARCHIVE=BASE.parent/'archive/enclosure'
def load(n,p):
 s=importlib.util.spec_from_file_location(n,p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
a=load('audit216',ARCHIVE/'audit_print_projects.py');c=load('gcode216',ARCHIVE/'v213/audit_complete_project.py')
def md(o):return {m.get('key'):m.get('value') for m in o.findall('metadata') if m.get('key')}
def main():
 report={'passed':True,'changed_parts':['05','06'],'projects':[]}
 for label,count,plates in [('all-plates',10,3),('upgrade-parts',2,1)]:
  path=OUT/f'bambu-studio/{label}/on-air-v216-X1C-{label}.3mf';model,config,cfg=a.project_meshes(path)
  assert len(model)==count and len(config.findall('plate'))==plates
  assert cfg['filament_type']==['PLA','PLA','PETG'] and cfg['filament_colour']==['#161616','#FFFFFF','#D8EDF0'] and cfg['scan_first_layer']=='0'
  settings={o.get('id'):md(o) for o in config.findall('object')};records=[]
  for i,p in enumerate(config.findall('plate')):
   origin=np.array([(i%2)*307.2,-(i//2)*307.2,0]);bounds=[];items=[]
   for instance in p.findall('model_instance'):
    oid=md(instance)['object_id'];obj=model[oid];name=obj['name'];tri=obj['triangles'];source=(OUT if name.startswith(('05','06')) else OLD)/'stl'/name;raw=a.stl(source);match=False
    for k in range(4):
     ang=k*np.pi/2;rot=np.array([[np.cos(ang),-np.sin(ang),0],[np.sin(ang),np.cos(ang),0],[0,0,1]]);rr=raw@rot;delta=tri.reshape(-1,3).min(axis=0)-rr.reshape(-1,3).min(axis=0)
     if tri.shape==raw.shape and np.allclose(tri-delta,rr,atol=.00006,rtol=0):match=True
    assert match,name
    lo=(tri-origin).reshape(-1,3).min(axis=0);hi=(tri-origin).reshape(-1,3).max(axis=0)
    assert abs(lo[2])<.00005 and lo[0]>6 and lo[1]>6 and hi[0]<250 and hi[1]<250
    for l,h in bounds:assert max(np.maximum(lo[:2]-h[:2],l[:2]-hi[:2]))>1.99
    bounds.append((lo,hi));assert settings[oid]['enable_support']==('1' if name.startswith(('07','11')) else '0')
    items.append({'name':name,'bounds':[lo.tolist(),hi.tolist()],'STL_matches':True})
   records.append({'plate':i+1,'items':items})
  result=json.loads((OUT/f'bambu-studio/{label}/result.json').read_text());assert result['return_code']==0
  estimates=[];roof_failures=[]
  for i,q in enumerate(result['sliced_plates'],1):
   assert not q['warning_message'];assert [f['id'] for f in q['filaments']]==({1:[1],2:[1,2],3:[3]}[i])
   lines=(OUT/f'bambu-studio/{label}/plate_{i}.gcode').read_text().splitlines();active=[l.split(';')[0].strip() for l in lines]
   assert not any(re.match(r'(?:M97[67](?:\s|$)|M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',l) for l in active)
   assert 'M104 S0' in active and 'M140 S0' in active and any(l.startswith('G29 A ') for l in active)
   runs=list(c.paths(lines));support=[r for r in runs if r['role'].startswith('Support')]
   allowed=[o['bounds'] for o in records[i-1]['items'] if o['name'].startswith(('07','11'))]
   for r in support:
    for pt in (r['a'],r['b']):assert any(all(lo[k]-6<pt[k]<hi[k]+6 for k in (0,1)) for lo,hi in allowed)
   if label=='upgrade-parts':
    assert not support
    # Correct the X1C's 2 mm extruder Y offset before mapping back to CAD.
    for r in runs:
     if r['role']!='Bridge':continue
     mid=np.mean([r['a'],r['b']],axis=0);mid[1]+=2
     rx,ry=mid[0]-68,mid[1]-75
     in_rear=(30.55<rx<33.15 or 46.85<rx<52.2) and 50.85<ry<55.25 and 8.8<r['z']<10.5
     in_mode=53.2<rx<66.8 and 53.6<ry<55.29 and 9.75<r['z']<10.5
     yx,yy=mid[0]-68.225,205.775-mid[1]
     in_yoke=51.65<yx<68.15 and 49<yy<55.2 and 1.9<r['z']<3.0
     if in_rear or in_mode or in_yoke:roof_failures.append({'mid':mid.tolist(),'z':r['z'],'role':r['role']})
   if label=='all-plates' and i==2:
    assert q['filament_change_times']==1
   if label=='all-plates' and i==3:
    fill=[r for r in runs if r['command']=='G1' and r['dist']>1 and r['role'] in ('Sparse infill','Internal solid infill','Bottom surface','Top surface')]
    assert len(fill)==332 and all(abs(r['a'][1]-r['b'][1])<.02 and r['feed']<=1200.01 for r in fill)
   estimates.append({'plate':i,'seconds':q['total_predication'],'grams':sum(f['total_used_g'] for f in q['filaments']),'filaments':q['filaments'],'warnings':[]})
  assert not roof_failures,roof_failures
  report['projects'].append({'name':label,'objects':count,'plates':records,'slicing':estimates,'no_roofs_across_new_wire_reliefs':True,'inspection_disabled':True,'heater_shutdown':True})
 # Preserve every unchanged component payload, including the user's insert painting.
 with zipfile.ZipFile(OLD/'bambu-studio/on-air-v215-X1C-all-plates.3mf') as old,zipfile.ZipFile(OUT/'bambu-studio/all-plates/on-air-v216-X1C-all-plates.3mf') as new:
  root=E.fromstring(old.read('3D/3dmodel.model'));ns={'c':'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'};prod='{http://schemas.microsoft.com/3dmanufacturing/production/2015/06}path'
  changed={o.find('c:components/c:component',ns).get(prod).lstrip('/') for o in root.findall('c:resources/c:object',ns) if o.get('id') in ('2','14')}
  unchanged=[n for n in old.namelist() if n.startswith('3D/Objects/') and n not in changed];assert all(old.read(n)==new.read(n) for n in unchanged)
  report['unchanged_mesh_and_paint_payloads']=unchanged
 (OUT/'printing-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps({'passed':True,'projects':[{ 'name':p['name'],'seconds':sum(s['seconds'] for s in p['slicing']),'grams':sum(s['grams'] for s in p['slicing'])} for p in report['projects']]}))
if __name__=='__main__':main()
