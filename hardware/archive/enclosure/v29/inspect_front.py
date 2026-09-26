import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct)
 c=next(o.component for o in d.rootComponent.occurrences if o.component.name=='01 Front optical bezel')
 rows=[]
 for f in c.bRepBodies.item(0).faces:
  bb=f.boundingBox
  if abs(bb.minPoint.z)<1e-7 and abs(bb.maxPoint.z)<1e-7:
   loops=[]
   for loop in f.loops:
    edges=[]
    for e in loop.edges:
     b=e.boundingBox;edges.append({'length':e.length*10,'type':e.geometry.objectType,'min':[v*10 for v in b.minPoint.asArray()],'max':[v*10 for v in b.maxPoint.asArray()]})
    loops.append({'outer':loop.isOuter,'edges':edges})
   rows.append({'area':f.area*100,'loops':loops})
 print(json.dumps(rows,indent=2))
