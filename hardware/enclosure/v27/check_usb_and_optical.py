import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get();out=Path(__file__).resolve().parents[1]/'output/v27'
 g={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences};results=[]
 def collide(body,fixed):
  bad=[]
  for n,z in fixed:
   t=tm.copy(body);assert tm.booleanOperation(t,tm.copy(z),F.BooleanTypes.IntersectionBooleanType)
   if t.volume*1000>.001:bad.append({'part':n,'volume_mm3':t.volume*1000})
  return bad
 fixed=[(n,z) for n,bs in g.items() if n.startswith(('05','06')) for z in bs]
 for q in [z for z in g['REF M3 screws'] if z.name.startswith('Optical screw')]:
  bad=[]
  for i in range(81):
   t=tm.copy(q);m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,i*.025);tm.transform(t,m);bad+=collide(t,fixed)
  results.append({'name':q.name+' front assembly path','samples':81,'passed':not bad,'failures':bad[:10]})
 for n in ('REF Charger','REF XIAO'):
  q=next(z for z in g[n] if 'USB' in z.name);bb=q.boundingBox
  lo=[v*10-.15 for v in bb.minPoint.asArray()];hi=[v*10+.15 for v in bb.maxPoint.asArray()]
  p=C.Point3D.create(*[(lo[i]+hi[i])/20 for i in range(3)])
  box=tm.createBox(C.OrientedBoundingBox3D.create(p,C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
  bad=collide(box,fixed+[(n,z) for n,bs in g.items() if n.startswith(('01','07')) for z in bs])
  results.append({'name':n+' socket plus0.15mm all around','passed':not bad,'failures':bad})
 # The reset target itself must depress; the other board geometry stays fixed.
 body=g['07 Front guided reset button'][0];bad=[]
 for i in range(25):
  t=tm.copy(body);m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,-i*.0025);tm.transform(t,m)
  bad+=collide(t,[(q.name,q) for q in g['REF XIAO'] if 'reset target' not in q.name])
 results.append({'name':'Reset stroke avoids PCB USB and LED','samples':25,'passed':not bad,'failures':bad[:10]})
 r={'passed':all(x['passed'] for x in results),'items':results};(out/'usb-and-optical-validation.json').write_text(json.dumps(r,indent=2));print(json.dumps(r,indent=2))
