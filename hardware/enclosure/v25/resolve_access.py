import importlib.util
from pathlib import Path
import adsk.fusion as F
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('fix25',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing')
 b.cutbox(rear,'Remove DPDT middle shelf from insertion path',54.9,53.65,21.1,10.2,1.49,1.5)
 for x in (54.9,63.35):b.box(rear,'DPDT end shoulders outside all six terminals',x,53.65,20.8,1.75,1.49,10.9)
 b.union(rear)
 b.cutbox(rear,'Clear PCB thickness through restored USB rear edge',110.5,57.35,11.3,1.75,.75,18.3)
 issues=[]
 for i in range(b.design().timeline.count):
  e=b.design().timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:issues.append(e)
 for e in issues:
  assert 'No target body' in e.errorOrWarningMessage,(e.name,e.errorOrWarningMessage)
  e.deleteMe()
 b.paint(rear);m.finish('DPDT terminal span and measured USB seating cleared')
