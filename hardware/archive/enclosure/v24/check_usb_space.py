import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output/v24'
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 # Inboard connector keepout includes tabs/solder, beyond the measured metal socket.
 lo=(111.55,52.65,16.85);hi=(115.5,57.35,27.45)
 center=C.Point3D.create((lo[0]+hi[0])/20,(lo[1]+hi[1])/20,-(lo[2]+hi[2])/20)
 source=tm.createBox(C.OrientedBoundingBox3D.create(center,C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
 obstacles=[(o.component.name,b) for o in d.rootComponent.occurrences if o.component.name.startswith(('05','06','07')) for b in o.component.bRepBodies]
 failures=[];checks=0
 poses=[('lowered insertion',-8,step*.25) for step in range(97)]+[('upward slide',-step*.25,0) for step in range(33)]
 for phase,dy,dz in poses:
  shifted=tm.copy(source);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,dy/10,dz/10);tm.transform(shifted,mat)
  for name,body in obstacles:
   if (dy or dz) and name.startswith('06'):continue
   z=tm.copy(shifted);assert tm.booleanOperation(z,tm.copy(body),F.BooleanTypes.IntersectionBooleanType);checks+=1
   if z.volume*1000>.001:failures.append({'phase':phase,'offset_mm':[0,dy,dz],'part':name,'volume_mm3':z.volume*1000})
 report={'passed':not failures,'interior_keepout_min_mm':lo,'interior_keepout_max_mm':hi,'samples':len(poses),'checks':checks,'failures':failures,'note':'This supplements the measured PCB/socket model with extra assembly space for connector tabs and solder. Actual physical test still required.'}
 (OUT/'usb-space-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
