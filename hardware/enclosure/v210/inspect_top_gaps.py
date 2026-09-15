"""Read-only inspection of inherited top seam reliefs."""
import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get()
 comps={o.component.name:o.component for o in d.rootComponent.occurrences};front=comps['01 Front optical bezel'].bRepBodies.item(0)
 faces=[]
 for f in front.faces:
  bb=f.boundingBox
  if abs(bb.minPoint.z+.915)<1e-7 and abs(bb.maxPoint.z+.915)<1e-7 and bb.minPoint.y>5.7:
   faces.append({'min_mm':[v*10 for v in bb.minPoint.asArray()],'max_mm':[v*10 for v in bb.maxPoint.asArray()],'area_mm2':f.area*100})
 rows=[]
 for name,x,w in [('Old charger cap',14.8,13.4),('Old programming-slider cap',55.25,9.5),('Old XIAO cap',110.4,7.1)]:
  q=tm.createBox(C.OrientedBoundingBox3D.create(C.Point3D.create((x+w/2)/10,5.87,-.9325),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),w/10,.26,.035))
  collisions=[]
  for n,c in comps.items():
   if n.startswith(('01','81','82')):continue
   for b in c.bRepBodies:
    aa=q.boundingBox;bb=b.boundingBox
    if any(min(getattr(aa.maxPoint,k),getattr(bb.maxPoint,k))<=max(getattr(aa.minPoint,k),getattr(bb.minPoint,k))+1e-8 for k in 'xyz'):continue
    z=tm.copy(q);assert tm.booleanOperation(z,tm.copy(b),F.BooleanTypes.IntersectionBooleanType)
    if z.volume*1000>.0001:collisions.append({'component':n,'body':b.name,'mm3':z.volume*1000})
  rows.append({'name':name,'x_mm':[x,x+w],'recess_depth_mm':.35,'static_fill_collisions':collisions})
 keeper=comps['06 Electronics retaining yoke']
 print(json.dumps({'document':app.activeDocument.name,'notch_floor_faces':faces,'current_retainer_front_depth_mm':min(-b.boundingBox.maxPoint.z*10 for b in keeper.bRepBodies),'checks':rows,'note':'Inspection only; no model change. Filling would need its own assembly-path check before release.'},indent=2))
