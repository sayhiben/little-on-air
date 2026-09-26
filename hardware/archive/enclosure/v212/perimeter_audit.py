"""Inspect the entire rear mating rim, including all four rounded corners."""
import adsk.core as C
import adsk.fusion as F
import json

def audit(front):
 tm=F.TemporaryBRepManager.get()
 def point(x,y,d):return C.Point3D.create(x/10,y/10,-d/10)
 def box(x,y,w,h,d,t):
  return tm.createBox(C.OrientedBoundingBox3D.create(point(x+w/2,y+h/2,d+t/2),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),w/10,h/10,t/10))
 def boolean(a,b,op):
  q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(b),op);return q
 def rounded(inset,d=8.5,t=1):
  x=y=inset;w=120-2*inset;h=60-2*inset;r=3-inset
  q=box(x+r,y,w-2*r,h,d,t)
  q=boolean(q,box(x,y+r,w,h-2*r,d,t),F.BooleanTypes.UnionBooleanType)
  for xx in (x+r,x+w-r):
   for yy in (y+r,y+h-r):q=boolean(q,tm.createCylinderOrCone(point(xx,yy,d),r/10,point(xx,yy,d+t),r/10),F.BooleanTypes.UnionBooleanType)
  return q
 ring=boolean(rounded(0),rounded(1),F.BooleanTypes.DifferenceBooleanType)
 missing=boolean(ring,front,F.BooleanTypes.DifferenceBooleanType)
 sectors=[('Top straight',3,57,114,3),('Bottom straight',3,0,114,3),('Left straight',0,3,3,54),('Right straight',117,3,3,54),('Top left corner',0,57,3,3),('Top right corner',117,57,3,3),('Bottom left corner',0,0,3,3),('Bottom right corner',117,0,3,3)]
 results=[]
 for name,x,y,w,h in sectors:
  q=boolean(missing,box(x,y,w,h,8.5,1),F.BooleanTypes.IntersectionBooleanType)
  results.append({'region':name,'missing_volume_mm3':q.volume*1000,'passed':q.volume*1000<1e-5})
 faces=[]
 for f in front.faces:
  bb=f.boundingBox
  if abs(bb.maxPoint.z-bb.minPoint.z)<1e-7 and -.95+1e-7<bb.minPoint.z<-.85-1e-7:
   if bb.minPoint.x<.1 or bb.maxPoint.x>11.9 or bb.minPoint.y<.1 or bb.maxPoint.y>5.9:
    faces.append({'min_mm':[v*10 for v in bb.minPoint.asArray()],'max_mm':[v*10 for v in bb.maxPoint.asArray()],'area_mm2':f.area*100})
 return {'passed':all(q['passed'] for q in results),'method':'Exact native Boolean of a continuous 1 mm-wide perimeter ring at depths 8.5 to 9.5 mm, against the actual front. Includes all four straight sides and all four R3 corners. Normal front bevels and internal fitting clearances lie outside this test band.','missing_volume_mm3':missing.volume*1000,'regions':results,'exterior_recess_floor_faces':faces}

def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct)
 c=next(o.component for o in d.rootComponent.occurrences if o.component.name=='01 Front optical bezel')
 print(json.dumps({'document':app.activeDocument.name,**audit(c.bRepBodies.item(0))},indent=2))
