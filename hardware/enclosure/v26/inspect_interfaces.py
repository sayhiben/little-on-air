import adsk.core as C
import adsk.fusion as F
import json
from pathlib import Path
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);cs={o.component.name:o.component for o in d.rootComponent.occurrences};report={}
 for name in ('05 Rear electronics housing','06 Electronics retaining yoke'):
  b=cs[name].bRepBodies.item(0);rows=[]
  for x in (55.6,56.5,57.5,60,62.5,63.5,64.4):
   for y in (55.5,56.5,57.5,58.5):
    depths=[round(i*.05,2) for i in range(190,641) if b.pointContainment(C.Point3D.create(x/10,y/10,-i*.005))==F.PointContainment.PointInsidePointContainment]
    rows.append({'x':x,'y':y,'dmin':min(depths) if depths else None,'dmax':max(depths) if depths else None})
  report[name]=rows
 for o in d.rootComponent.occurrences:o.isLightBulbOn=o.component.name.startswith(('05','06','REF XIAO','REF DPDT','REF Charger','07'))
 C.Application.get().activeViewport.fit()
 (Path(__file__).resolve().parents[1]/'output/v26/interface-study.json').write_text(json.dumps(report,indent=2))
 print(json.dumps(report))
