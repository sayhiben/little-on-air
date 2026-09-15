import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output/v28'

def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 g={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences}
 def bounds(q):return [[round(v*10,5) for v in p.asArray()] for p in (q.boundingBox.minPoint,q.boundingBox.maxPoint)]
 report={'document':C.Application.get().activeDocument.name,'bodies':{n:[{'name':q.name,'bounds':bounds(q)} for q in bs] for n,bs in g.items() if n.startswith(('07','REF XIAO','REF Charger'))},'button_planes':[],'stroke':[]}
 button=g['07 Front guided reset button'][0]
 for f in button.faces:
  z=f.boundingBox
  if abs(z.maxPoint.z-z.minPoint.z)<1e-7:report['button_planes'].append({'depth':round(-z.maxPoint.z*10,6),'area_mm2':round(f.area*100,5),'bounds':bounds(f)})
 for i in range(26):
  offset=i*.05;q=tm.copy(button);m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,-offset/10);tm.transform(q,m);hits=[]
  for n,bs in g.items():
   if not n.startswith(('01','05','06','REF XIAO')):continue
   for body in bs:
    t=tm.copy(q);assert tm.booleanOperation(t,tm.copy(body),F.BooleanTypes.IntersectionBooleanType)
    if t.volume*1000>.001:hits.append({'component':n,'body':body.name,'volume_mm3':round(t.volume*1000,6)})
  report['stroke'].append({'travel_mm':round(offset,4),'contacts':hits})
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'previous-interface-inspection.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
