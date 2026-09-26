import importlib.util,json
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('charger23',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 additions=[]
 for name,start,thick in [('05 Rear electronics housing',24.2,7.5),('06 Electronics retaining yoke',11.4,11.6)]:
  c=b.comp(name)
  for x in (12.25,27.75):
   for y in (32,54):
    b.box(c,'Charger robust 2 mm support',x,y,start,2,2,thick)
    additions.append({'name':name,'lo':[x,y,start],'hi':[x+2,y+2,start+thick]})
  b.union(c);b.paint(c)
 for name in ('reset_tip_x','reset_stroke'):
  b.design().userParameters.itemByName(name).comment='v2.3: 0.15 mm nominal free play plus 0.30 mm actuation; 0.45 mm inward stop'
 for p in b.design().userParameters:
  if p.name.startswith('spdt_'):p.comment='User measured switch; v2.3 uses 0.20 mm lateral and longitudinal running clearance'
 (m.OUT/'charger-added-volumes.json').write_text(json.dumps(additions,indent=2))
 m.finish('Charger supports retain 2 mm sections')
