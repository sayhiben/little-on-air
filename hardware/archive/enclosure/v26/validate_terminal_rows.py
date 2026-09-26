"""Reserve uninterrupted keepouts along both DPDT terminal rows."""
import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output/v26'
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get();items=[]
 for dep in (19.9,22.92):
  lo=(56.9,52.04,dep);hi=(63.1,55.49,dep+1.1)
  body=tm.createBox(C.OrientedBoundingBox3D.create(C.Point3D.create((lo[0]+hi[0])/20,(lo[1]+hi[1])/20,-(lo[2]+hi[2])/20),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),.62,.345,.11))
  collisions=[]
  for o in d.rootComponent.occurrences:
   if not o.component.name.startswith(('05','06')):continue
   t=tm.copy(body);assert tm.booleanOperation(t,tm.copy(o.component.bRepBodies.item(0)),F.BooleanTypes.IntersectionBooleanType)
   if t.volume*1000>.001:collisions.append({'part':o.component.name,'overlap_mm3':t.volume*1000})
  items.append({'min_mm':lo,'max_mm':hi,'collisions':collisions,'passed':not collisions})
 report={'passed':all(i['passed'] for i in items),'items':items,'note':'Entire terminal rows reserved, not just the measured pin positions; 0.2 mm allowance around bare 0.7 mm legs.'}
 (OUT/'terminal-row-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
