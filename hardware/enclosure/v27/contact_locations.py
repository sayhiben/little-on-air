import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 def get(p):return next(o.component.bRepBodies.item(0) for o in d.rootComponent.occurrences if o.component.name.startswith(p))
 a=tm.copy(get('06'));assert tm.booleanOperation(a,tm.copy(get('05')),F.BooleanTypes.IntersectionBooleanType)
 print(json.dumps([{'area':f.area*100,'bounds':[[round(v*10,4) for v in p.asArray()] for p in (f.boundingBox.minPoint,f.boundingBox.maxPoint)]} for f in a.faces],indent=2))
