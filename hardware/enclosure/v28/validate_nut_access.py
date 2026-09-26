"""Check seated nuts, sliding entries and front/rear loading with hardware absent."""
import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output/v28'

def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 comps={o.component.name:o.component for o in d.rootComponent.occurrences}
 nuts=list(comps['REF M3 nuts'].bRepBodies);results=[]
 paths=[('Lower left closure',(8,0),False),('Lower right closure',(-8,0),False),('Upper left closure',(0,-8),False),('Upper right closure',(-8,0),False),('Lower optical',(8,0),True),('Upper optical',(8,0),True),('Left yoke',(8,0),False),('Right yoke',(-8,0),False)]
 for body,(label,(dx,dy),optical) in zip(nuts,paths):
  fixed=comps['01 Front optical bezel' if optical else '05 Rear electronics housing'].bRepBodies.item(0)
  shifts=[('slide',dx*i/32,dy*i/32,0) for i in range(33)]
  shifts += [('load',dx,dy,(-1 if optical else 1)*i*.25) for i in range(129)]
  failures=[];mx=0
  for phase,x,y,z in shifts:
   t=tm.copy(body);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(x/10,y/10,z/10);tm.transform(t,mat)
   assert tm.booleanOperation(t,tm.copy(fixed),F.BooleanTypes.IntersectionBooleanType)
   vol=t.volume*1000;mx=max(mx,vol)
   if vol>.001:failures.append({'phase':phase,'offset_mm':[x,y,z],'overlap_mm3':round(vol,6)})
  bb=body.boundingBox
  results.append({'nut':label,'center_xy_mm':[(bb.minPoint.x+bb.maxPoint.x)*5,(bb.minPoint.y+bb.maxPoint.y)*5],'entry_offset_mm':[dx,dy],'samples':len(shifts),'passed':not failures,'max_overlap_mm3':mx,'failures':failures[:20]})
  (OUT/'nut-access-validation.json').write_text(json.dumps({'passed':all(r['passed'] for r in results),'items':results,'assembly':'Load nuts into empty housing / bare bezel before electronics, wires or optical stack.'},indent=2))
 print(json.dumps(results,indent=2))
