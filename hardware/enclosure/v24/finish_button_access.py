import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('access24',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing')
 b.cutbox(rear,'Reset inside loading clearance above USB envelope',108.0,53.65,9.45,7.99,4.7,7.55)
 for x in (55.1,63.5):b.cutbox(rear,'Clear lower stops from edge terminals',x,53.65,20.8,1.4,1.49,10.9)
 for x in (57.0,61.0):b.box(rear,'DPDT lower pads between terminal columns',x,53.65,20.8,2,1.49,10.9)
 b.union(rear)
 yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(yoke,'Remove thin MODE roof tail',57.95,57.4,19.65,4.1,2.35,.85)
 b.box(yoke,'MODE roof continuous backbone',57.95,57.0,12.35,4.1,1.85,7.3)
 b.box(yoke,'POWER roof continuous backbone below flange',38.15,57.4,14.75,5.7,1,4.95)
 b.union(yoke);b.paint(yoke)
 issues=[]
 for i in range(b.design().timeline.count):
  e=b.design().timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:issues.append(e)
 for e in issues:
  assert 'No target body' in e.errorOrWarningMessage,(e.name,e.errorOrWarningMessage)
  e.deleteMe()
 b.paint(rear);m.finish('Straight XIAO insertion and closed-wall button access')
 assert b.design().exportManager.execute(b.design().exportManager.createFusionArchiveExportOptions(str(m.OUT/'revision-refined.f3d')))
