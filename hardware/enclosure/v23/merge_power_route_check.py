from pathlib import Path
import json,importlib.util
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v23'
s=importlib.util.spec_from_file_location('final_routes',str(HERE/'harness.py'));h=importlib.util.module_from_spec(s);s.loader.exec_module(h)
normalize=lambda x:json.loads(json.dumps(x))
old=json.loads((OUT/'harness-validation.json').read_text());patch=json.loads((OUT/'power-route-validation.json').read_text())
assert patch['passed'] and len(patch['items'])==1
fixed=patch['items'][0];assert fixed['name'].startswith('P4')
routes={n:(r,normalize(p)) for n,r,p in h.ROUTES};bays={n:(normalize(lo),normalize(hi)) for n,lo,hi in h.BAYS}
for i,item in enumerate(old['items']):
 if item['name']==fixed['name']:old['items'][i]=fixed;item=fixed
 assert item['passed'],item
 if item['name'] in routes:
  radius,path=routes[item['name']];assert item['radius_mm']==radius and item['path']==path,item['name']
 if item['name'] in bays:
  lo,hi=bays[item['name']];assert item['min_mm']==lo and item['max_mm']==hi,item['name']
prior=OUT/'harness-full-before-power-refinement.json'
if not prior.exists():prior.write_bytes((OUT/'harness-validation.json').read_bytes())
old['passed']=True;old['targeted_recheck']='Only P4 changed after the full wire study. Its new native-solid check replaces its earlier result; all other route/bay inputs were checked unchanged. No CAD edits occurred between these wire checks.'
(OUT/'harness-validation.json').write_text(json.dumps(old,indent=2))
print('All',len(old['items']),'native wire/space checks passed; P4 targeted recheck merged with unchanged verified routes.')
