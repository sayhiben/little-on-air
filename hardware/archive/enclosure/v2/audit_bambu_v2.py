from pathlib import Path
import importlib.util,json,zipfile,re,collections
import numpy as np
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output'/'v2';BAMBU=OUT/'bambu-studio'
s=importlib.util.spec_from_file_location('old_audit',str(BASE/'audit_print_projects.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
def audit_project(path,expected):
 meshes,config,settings=a.project_meshes(path);assert len(meshes)==expected
 assert settings['wall_loops']=='4' and settings['layer_height']=='0.2' and settings['enable_support']=='0'
 assert settings['printer_settings_id']=='Bambu Lab X1 Carbon 0.4 nozzle' and settings['filament_type']==['PETG','PETG']
 result=[];seen=[]
 for index,plate in enumerate(config.findall('plate')):
  origin=np.array([(index%2)*307.2,-(index//2)*307.2,0]);bounds=[]
  for inst in plate.findall('model_instance'):
   oid=next(m.get('value') for m in inst.findall('metadata') if m.get('key')=='object_id');seen.append(oid);obj=meshes[oid]
   part=int(obj['name'][:2]);source=OUT/('fit-samples' if part>=90 else 'stl')/obj['name'];raw=a.stl(source);tri=obj['triangles']
   delta=tri.reshape(-1,3).min(axis=0)-raw.reshape(-1,3).min(axis=0)
   assert a.canonical(tri-delta)==a.canonical(raw),obj['name']
   lo=(tri-origin).reshape(-1,3).min(axis=0);hi=(tri-origin).reshape(-1,3).max(axis=0)
   assert abs(lo[2])<.00005 and lo[0]>6 and lo[1]>6 and hi[0]<250 and hi[1]<250
   b=(lo[:2]-3.5,hi[:2]+3.5)
   assert all(np.maximum(b[0]-old[1],old[0]-b[1]).max()>0 for old in bounds),obj['name'];bounds.append(b)
   result.append({'name':obj['name'],'plate':index+1,'mesh_matches_STL':True,'min_z':float(lo[2]),'bounds_mm':np.round(hi-lo,5).tolist()})
  if index==2:
   tower=(np.array([18,181]),np.array([58,221]));assert all(np.maximum(tower[0]-b[1],b[0]-tower[1]).max()>0 for b in bounds)
 assert len(set(seen))==expected
 return result
def code_check(path,manual=False):
 code=path.read_text().splitlines();height=0;tool=0;role='';layers=collections.defaultdict(set);pauses=[]
 for i,line in enumerate(code):
  if line.startswith('; Z_HEIGHT:'):height=float(line.split(':')[1])
  if re.fullmatch(r'T[01]',line.strip()):tool=int(line.strip()[1:])
  if line.strip()=='M400 U1':pauses.append({'height':height,'line':i+1})
  if line.startswith('; FEATURE:'):role=line.split(':',1)[1].strip()
  if height and line.startswith(('G1 ','G2 ','G3 ')) and re.search(r' E(?:[0-9]|\.[0-9])',line) and re.search(r' [XY][-0-9.]',line) and role in ['Inner wall','Outer wall','Top surface','Bottom surface','Internal solid infill','Gap infill']:
   layers[height].add(tool)
 expected=[round(.2+i*.1,3) for i in range(24)]
 assert sorted(layers)==expected,sorted(layers)
 if manual:assert len(pauses)==1 and abs(pauses[0]['height']-1.7)<.0001
 else:assert all(tools=={0 if z<=1.60001 else 1} for z,tools in layers.items()),layers
 return {'layers':len(layers),'last_layer_mm':max(layers),'black_base_mm':1.6,'first_white_layer_mm':1.7,'pause':pauses if manual else None,'tool_per_layer':{z:sorted(t) for z,t in layers.items()}}
def main():
 report={}
 for variant in ['AMS','manual-swap','fit-checks']:
  base=f'on-air-v2-X1C-PETG-{variant}.3mf';sliced=BAMBU/('sliced-'+variant)
  objects=audit_project(BAMBU/base,10 if variant=='fit-checks' else 7)
  result=json.loads((sliced/'result.json').read_text());assert result['return_code']==0
  for plate in result['sliced_plates']:assert not plate['warning_message'],plate['warning_message']
  result2=audit_project(sliced/base,10 if variant=='fit-checks' else 7)
  report[variant]={'objects':objects,'sliced_export_meshes_match':True,'slicer':result,'color_change':None if variant=='fit-checks' else code_check(sliced/'plate_3.gcode',variant=='manual-swap')}
 (BAMBU/'verified-projects.json').write_text(json.dumps(report,indent=2));print(json.dumps({v:{'parts':len(r['objects']),'sliced_plates':len(r['slicer']['sliced_plates']),'color':r['color_change']} for v,r in report.items()},indent=2))
if __name__=='__main__':main()
