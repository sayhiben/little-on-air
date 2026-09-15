import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output/v26'
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 comps={o.component.name:o.component for o in d.rootComponent.occurrences};button=comps['07 Guided rounded reset button'].bRepBodies.item(0)
 rigid=[bb for bb in comps['REF XIAO'].bRepBodies if 'reset target' not in bb.name.lower()]
 target=next(bb for bb in comps['REF XIAO'].bRepBodies if 'reset target' in bb.name.lower())
 freeplay=(button.boundingBox.minPoint.x-target.boundingBox.maxPoint.x)*10
 projection=button.boundingBox.maxPoint.x*10-120
 assert abs(freeplay-.1)<.0001 and abs(projection-3)<.0001
 failures=[]
 for i in range(17):
  t=tm.copy(button);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(-i*.0025,0,0);tm.transform(t,mat)
  for rb in rigid:
   z=tm.copy(t);assert tm.booleanOperation(z,tm.copy(rb),F.BooleanTypes.IntersectionBooleanType)
   if z.volume*1000>.001:failures.append({'travel_mm':i*.025,'obstacle':rb.name,'volume_mm3':z.volume*1000})
 report={'passed':not failures,'free_play_mm':round(freeplay,5),'projection_at_rest_mm':round(projection,5),'projection_at_stop_mm':round(projection-.4,5),'stop_travel_mm':.4,'nominal_switch_depression_mm':round(.4-freeplay,5),'samples':17,'failures':failures,'note':'The compliant reset target is excluded from rigid interference; 0.3 mm nominal actuation must be confirmed by the physical fit test.'}
 (OUT/'reset-fit-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
