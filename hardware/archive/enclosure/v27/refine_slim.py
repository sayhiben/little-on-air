import importlib.util,json
from pathlib import Path
import adsk.core as C
import adsk.fusion as F
HERE=Path(__file__).resolve().parent

def run(_context:str):
 s=importlib.util.spec_from_file_location('slim',str(HERE/'build_slim.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke');tm=F.TemporaryBRepManager.get()
 rows=[]
 groups=[(o.component.name,q) for o in b.root().occurrences if not o.component.name.startswith(('81','82')) for q in o.component.bRepBodies]
 for i,(name,a) in enumerate(groups):
  for other,z in groups[:i]:
   if name==other:continue
   t=tm.copy(a);assert tm.booleanOperation(t,tm.copy(z),F.BooleanTypes.IntersectionBooleanType)
   if t.volume*1000>.001:rows.append({'one':name,'two':other,'body':z.name,'volume':t.volume*1000,'bounds':[[v*10 for v in p.asArray()] for p in (t.boundingBox.minPoint,t.boundingBox.maxPoint)]})
 (m.OUT/'first-contact-details.json').write_text(json.dumps(rows,indent=2))
 # Empty cuts from the fresh-shell construction are removed from the timeline.
 for i in range(b.design().timeline.count-1,-1,-1):
  f=b.design().timeline.item(i).entity
  if hasattr(f,'healthState') and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:assert f.deleteMe()
 # PCB edge recesses inside the top wall, open toward the front for drop-in.
 b.cutbox(rear,'Charger upper PCB loading recess',11.95,57.35,9.48,18.1,1.3,7.12)
 b.cutbox(rear,'XIAO upper PCB loading recess',85.75,57.35,9.48,18.3,.70,10.47)
 b.cutbox(yoke,'Charger roof clears PCB underside',11.95,57.3,15.05,18.1,1.35,1.56)
 b.cutbox(yoke,'POWER roof clears body and bracket',35.5,53.15,13.8,11,5.45,6.5)
 b.cutbox(yoke,'MODE roof clears broad body',55.25,55.29,13.95,9.5,3.76,4.1)
 # The reset guide is part of the removable top roof; preserve a closed external
 # wall by extending the roof to the same .25 mm seam as both USB roofs.
 b.cutbox(rear,'Reset guide upper-wall service recess',85.515,57.35,9.48,4.6,2.8,5.57)
 b.box(yoke,'Reset guide exterior roof completion',85.515,57.3,9.65,4.6,2.45,5.35);b.union(yoke)
 b.cutbox(yoke,'Reopen reset keyway',m.RX-1.4,m.RY-1.6,9.63,2.8,3.2,5.40)
 # Broaden the high end pads, keeping the left upper pad away from reset.
 for x in (86.25,101.55):
  for y,h in ((36.8,1.4),(56.65,1.15)):b.cutbox(yoke,'Remove narrow end contact',x-.01,y-.01,12.4,2.02,h+.02,6)
 for x,y,w,h in [(85.9,36.7,2.5,2.0),(101.3,36.7,2.5,2.0),(85.4,55.8,2.4,2.4),(101.3,55.8,2.5,2.4)]:
  b.box(yoke,'Broad XIAO short-end contact',x,y,12.35,w,h,5.9)
 b.union(yoke)
 b.cutcyl(yoke,'Reopen RGB sight through wide upper pad root',100.605,55.006,9.63,3.2,8.9)
 b.paint(rear);b.paint(yoke);m.checkpoint('refined-slim-interfaces')
