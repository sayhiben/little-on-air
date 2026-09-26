import importlib.util,json
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('clear26',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(rear,'Charger PCB front loading channel through top wall',11.95,57.35,9.48,18.1,1.3,14.97)
 b.cutbox(yoke,'Preserve full boss seat under new retaining backbone',98.8,33.8,11.4,8.4,8.4,1.05)
 b.cutcyl(yoke,'Right yoke full depth screw clearance',103,38,9.63,3.6,5)
 for x,y in m.FAST:b.cyl(rear,'Fill unused deep screw well',x,y,14.2,3.62,15)
 b.union(rear)
 m.finish('Final insertion channels and common-screw seats')
 report=json.loads((m.OUT/'hardware-layout.json').read_text())
 for r in report:
  if r['type']=='Closure screw':r['bearing_depth']=5.6;r['shaft_depth']=[5.6,13.6]
 (m.OUT/'hardware-layout.json').write_text(json.dumps(report,indent=2))
