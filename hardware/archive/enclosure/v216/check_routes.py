"""Check explicit swept wire paths against every installed native solid."""
import adsk.core as C,adsk.fusion as F,json,math,time
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v216'
def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get()
 obstacles=[]
 for o in d.rootComponent.occurrences:
  if o.component.name.startswith(('81','82','REF Harness')):continue
  for q in o.component.bRepBodies:
   bb=q.boundingBox;obstacles.append((o.component.name,q,bb.minPoint.asArray(),bb.maxPoint.asArray()))
 def p(v):return C.Point3D.create(v[0]/10,v[1]/10,-v[2]/10)
 results=[];routes=json.loads((OUT/'candidate-routes.json').read_text())
 for route in routes:
  points=route['points'];r=route.get('radius',1);pieces=[]
  for a,z in zip(points,points[1:]):
   if math.dist(a,z)>1e-7:pieces.append(tm.createCylinderOrCone(p(a),r/10,p(z),r/10))
  for a in points[1:-1]:pieces.append(tm.createSphere(p(a),r/10))
  hits={};locations={}
  for piece in pieces:
   bb=piece.boundingBox;lo=bb.minPoint.asArray();hi=bb.maxPoint.asArray()
   for name,q,ql,qh in obstacles:
    if not all(min(a,z)-max(c,e)>1e-7 for a,z,c,e in zip(hi,qh,lo,ql)):continue
    v=tm.copy(piece);assert tm.booleanOperation(v,tm.copy(q),F.BooleanTypes.IntersectionBooleanType)
    volume=v.volume*1000
    if volume>.001:
     hits[name]=hits.get(name,0)+volume
     rb=v.boundingBox
     locations.setdefault(name,[]).append({'lo':[round(x*10,3) for x in rb.minPoint.asArray()],'hi':[round(x*10,3) for x in rb.maxPoint.asArray()]})
  results.append({'name':route['name'],'passed':not hits,'collisions_mm3':hits,'locations':locations})
  (OUT/'route-check.json').write_text(json.dumps({'passed':all(q['passed'] for q in results),'completed':len(results),'total':len(routes),'results':results},indent=2))
 print(json.dumps([{k:v for k,v in q.items() if k!='locations'} for q in results],indent=2))
