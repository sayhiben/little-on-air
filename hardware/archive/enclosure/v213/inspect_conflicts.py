import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get();cs={o.component.name:o.component for o in d.rootComponent.occurrences};a=cs['11 Rear light guide keeper'].bRepBodies.item(0)
 result=[]
 for name in ('REF Charger','05 Rear electronics housing'):
  for b in cs[name].bRepBodies:
   q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(b),F.BooleanTypes.IntersectionBooleanType)
   if q.volume*1000>.001:
    result.append({'component':name,'body':b.name,'volume_mm3':q.volume*1000,'lumps':[{'min':[v*10 for v in l.boundingBox.minPoint.asArray()],'max':[v*10 for v in l.boundingBox.maxPoint.asArray()]} for l in q.lumps]})
 print(json.dumps(result,indent=2))
