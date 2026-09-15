"""Temporary native solids check wire envelopes against all manufactured parts.
Reference bays intentionally contain their future component; routes may meet at
terminals. Report these separately from true manufacturing interference.
"""
import adsk.core as C
import adsk.fusion as F
import math,json,importlib.util
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v25'
def run(_context:str):
 s=importlib.util.spec_from_file_location('harness',str(HERE/'harness.py'));h=importlib.util.module_from_spec(s);s.loader.exec_module(h)
 app=C.Application.get();d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get();root=d.rootComponent
 obstacles=[(o.component.name,bb) for o in root.occurrences if not o.component.name.startswith(('81','82','REF Harness')) for bb in o.component.bRepBodies]
 def p(v):return C.Point3D.create(v[0]/10,v[1]/10,-v[2]/10)
 def unit(v):
  l=math.sqrt(sum(x*x for x in v));return [x/l for x in v]
 def rounded(points,r=3):
  result=[points[0]]
  for i,q in enumerate(points[1:-1],1):
   u=unit([points[i-1][a]-q[a] for a in range(3)]);v=unit([points[i+1][a]-q[a] for a in range(3)])
   dot=sum(a*b for a,b in zip(u,v));angle=math.acos(max(-1,min(1,dot)));dist=r/math.tan(angle/2)
   dist=min(dist,math.dist(q,points[i-1])*.45,math.dist(q,points[i+1])*.45)
   a=[q[j]+u[j]*dist for j in range(3)];z=[q[j]+v[j]*dist for j in range(3)]
   # Quadratic corner lies inside the swept corridor. End slopes are tangent.
   result.append(a)
   for k in range(1,13):
    t=k/12;result.append([(1-t)**2*a[j]+2*(1-t)*t*q[j]+t*t*z[j] for j in range(3)])
  result.append(points[-1]);return result
 def pieces(points,radius):
  result=[]
  for a,b in zip(points,points[1:]):
   if math.dist(a,b)>1e-6:result.append(tm.createCylinderOrCone(p(a),radius/10,p(b),radius/10))
  for q in points[1:-1]:result.append(tm.createSphere(p(q),radius/10))
  return result
 def bbox(lo,hi):
  return tm.createBox(C.OrientedBoundingBox3D.create(p([(lo[i]+hi[i])/2 for i in range(3)]),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),(hi[0]-lo[0])/10,(hi[1]-lo[1])/10,(hi[2]-lo[2])/10))
 def overlap(a,b):
  aa=a.boundingBox;bb=b.boundingBox
  return all(min(x,y)-max(u,v)>1e-7 for x,y,u,v in zip(aa.maxPoint.asArray(),bb.maxPoint.asArray(),aa.minPoint.asArray(),bb.minPoint.asArray()))
 if globals().get('OBSTACLE_BOXES'):
  obstacles=[('Added charger support '+str(i),bbox(a['lo'],a['hi'])) for i,a in enumerate(OBSTACLE_BOXES)]
 items=[]
 for name,r,path in h.ROUTES:
  pts=rounded(path);items.append((name,pieces(pts,r),{'radius_mm':r,'route_length_mm':round(sum(math.dist(a,b) for a,b in zip(pts,pts[1:])),2),'path':path}))
 for name,lo,hi in h.BAYS:items.append((name,[bbox(lo,hi)],{'min_mm':lo,'max_mm':hi}))
 # Model all seven used three-wire LED pigtails, including their side exits.
 for x,y,side in [(40,6.8,1),(40,6.8,-1),(80,6.8,1),(80,6.8,-1),(80,53.2,1),(80,53.2,-1),(40,53.2,-1)]:
  for lane in (-1,0,1):
   path=[(x+side*4.01,y+lane,3.3),(x+side*7.5,y+lane,3.3),(x+side*7.5,y+lane,6.5)]
   items.append((f'LED exit {x} {y} {side} lane{lane}',pieces(rounded(path,2.5),.55),{'wire_OD_max_mm':.9}))
 report={'document':app.activeDocument.name,'units':'mm','items':[],'note':'Wire envelopes are clearance reservations, not a circuit simulation. Component and solder pad shapes remain measured-fit items.'}
 temp=[]
 for name,bs,meta in items:
  if globals().get('FILTER_NAMES') and not any(name.startswith(x) for x in FILTER_NAMES):continue
  failures={};bounds=[]
  for body in bs:
   for on,ob in obstacles:
    if 'min_mm' in meta and name.startswith('Capacitor') and on.startswith('REF Capacitor'):continue
    if name.startswith('Charger OUT ') and on=='REF Charger':continue # Deliberately spans the plated PCB holes and both solder faces.
    if not overlap(body,ob):continue
    z=tm.copy(body)
    if not tm.booleanOperation(z,tm.copy(ob),F.BooleanTypes.IntersectionBooleanType):raise RuntimeError('Boolean failed')
    vol=z.volume*1000
    if vol>.001:
     failures[on]=round(failures.get(on,0)+vol,4)
     bb=z.boundingBox;bounds.append({'obstacle':on,'min':[round(v*10,4) for v in bb.minPoint.asArray()],'max':[round(v*10,4) for v in bb.maxPoint.asArray()]})
  report['items'].append({'name':name,**meta,'collision_bounds':bounds,'collisions':failures,'passed':not failures})
  # Store one unioned body per route for a readable native inspection.
  if False: # Display unions are omitted; all individual volumes above are still tested.
   try:
    solid=tm.copy(bs[0])
    for other in bs[1:]:
     if not tm.booleanOperation(solid,tm.copy(other),F.BooleanTypes.UnionBooleanType):raise RuntimeError('Display union failed')
    temp.append((name,solid))
   except RuntimeError:
    # Display union tolerances must not interrupt the individual collision checks.
    # Retain all tested primitives if ASM cannot join nearly coincident sweeps.
    report['items'][-1]['display_geometry']='individual tested primitives'
    temp.extend((name+' segment '+str(k),body) for k,body in enumerate(bs))
 report['passed']=all(x['passed'] for x in report['items']);(OUT/globals().get('RESULT_NAME','harness-validation.json')).write_text(json.dumps(report,indent=2))
 if False: # Keep the production CAD free of optional display solids.
  # Revalidation must not delete a historical occurrence in a live production
  # timeline. The displayed routes were created from this same v2.5 harness.
  # All fresh checks above use independent temporary bodies from ROUTES/BAYS.
  existing=[o for o in root.occurrences if o.component.name.startswith('REF Harness')]
  if not existing:
   o=root.occurrences.addNewComponent(C.Matrix3D.create());c=o.component;c.name='REF Harness envelopes and auxiliary bays';f=c.features.baseFeatures.add();f.startEdit()
   for name,body in temp:c.bRepBodies.add(body,f).name=name
   f.finishEdit();c.opacity=.4;o.isLightBulbOn=False
 print(json.dumps({'passed':report['passed'],'failed':[i for i in report['items'] if not i['passed']]},indent=2))
