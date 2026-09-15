import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 print(F.ExtrudeFeatures.createInput.__doc__)
 print(F.ExtrudeFeatureInput.setDistanceExtent.__doc__)
 d=F.Design.cast(C.Application.get().activeProduct)
 c=next(o.component for o in d.rootComponent.occurrences if o.component.name=='01 Front optical bezel')
 for f in c.bRepBodies.item(0).faces:
  bb=f.boundingBox
  if abs(bb.minPoint.z+.915)<1e-7 and abs(bb.maxPoint.z+.915)<1e-7 and bb.minPoint.y>5.7:
   print(json.dumps({'area':f.area*100,'normal':f.evaluator.getNormalAtPoint(f.pointOnFace)[1].asArray(),'geometry_normal':f.geometry.normal.asArray()}))
