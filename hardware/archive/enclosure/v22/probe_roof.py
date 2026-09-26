import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);d.computeAll();d.timeline.moveToEnd()
 c=next(o.component for o in d.rootComponent.occurrences if o.component.name.startswith('06'))
 body=c.bRepBodies.item(0);tm=F.TemporaryBRepManager.get();copy=tm.copy(body)
 print('timeline',d.timeline.count,d.timeline.markerPosition)
 print('last features',[(i,d.timeline.item(i).entity.name) for i in range(d.timeline.count-30,d.timeline.count)])
 for x,y,depth in [(40,59,10),(40,59,12),(40,59,13),(40,56.5,10),(40,56.5,12)]:
  p=C.Point3D.create(x/10,y/10,-depth/10);print(x,y,depth,body.pointContainment(p),copy.pointContainment(p))
