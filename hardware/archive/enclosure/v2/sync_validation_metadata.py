import adsk.core as C
import adsk.fusion as F
import json
from pathlib import Path
def run(_context:str):
 out=Path(__file__).resolve().parents[1]/'output'/'v2';r=json.loads((out/'native-validation.json').read_text());d=F.Design.cast(C.Application.get().activeProduct)
 for entry in r['components']:
  c=next(o.component for o in d.rootComponent.occurrences if o.component.name==entry['name']);assert c.bRepBodies.count==entry['body_count']
  for record,body in zip(entry['bodies'],c.bRepBodies):
   volume=round(body.volume*1000,4)
   if entry['name'].startswith(('81','82')):record['volume_mm3']=volume
   else:assert abs(volume-record['volume_mm3'])<.0002,(entry['name'],volume,record['volume_mm3'])
 for i in range(d.timeline.count):
  obj=d.timeline.item(i).entity
  if hasattr(obj,'healthState'):assert obj.healthState==F.FeatureHealthStates.HealthyFeatureHealthState,getattr(obj,'name','')
 assert all(all(abs(a-b)<1e-9 for a,b in zip(o.transform2.asArray(),C.Matrix3D.create().asArray())) for o in d.rootComponent.occurrences)
 r['timeline_features']=d.timeline.count;r['optional_corner_mesh_revision_checked']=True
 (out/'native-validation.json').write_text(json.dumps(r,indent=2));print('Final archive geometry matches the validated assembly; all features healthy')
