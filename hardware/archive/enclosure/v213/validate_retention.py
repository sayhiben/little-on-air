"""Native static, assembly, retention-stop and access checks."""
import adsk.core as C
import adsk.fusion as F
import json,importlib.util
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v213'

def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get()
 groups={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences}
 fixed_bounds={id(q):q.boundingBox for bs in groups.values() for q in bs}
 def select(prefix):return [(n,q) for n,bs in groups.items() if n.startswith(prefix) for q in bs]
 def overlap(a,z):
  aa=fixed_bounds[id(a)] if id(a) in fixed_bounds else a.boundingBox
  bb=fixed_bounds[id(z)] if id(z) in fixed_bounds else z.boundingBox
  return all(min(x,y)-max(u,v)>1e-7 for x,y,u,v in zip(aa.maxPoint.asArray(),bb.maxPoint.asArray(),aa.minPoint.asArray(),bb.minPoint.asArray()))
 def volume(a,z):
  if not overlap(a,z):return 0
  q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),F.BooleanTypes.IntersectionBooleanType);return q.volume*1000
 def moved(q,off):
  a=tm.copy(q);m=C.Matrix3D.create();m.translation=C.Vector3D.create(*[v/10 for v in off]);assert tm.transform(a,m);return a
 def check(moving,fixed,offsets):
  failures=[]
  for off in offsets:
   for n,a in select(moving):
    q=moved(a,off)
    for zn,z in select(fixed):
     if n==zn:continue
     v=volume(q,z)
     if v>.001:failures.append({'offset_mm':off,'moving':n,'fixed':zn,'mm3':v})
  return failures
 report={'passed':False,'static':[],'motion':[],'retention':[],'access':[],'features':[]}
 selected=[(n,q) for n,bs in groups.items() if not n.startswith(('81','82','REF Harness')) for q in bs]
 for i,(n,q) in enumerate(selected):
  for zn,z in selected[:i]:
   if n==zn or not (n.startswith(('01','05','08','11','REF Guide')) or zn.startswith(('01','05','08','11','REF Guide'))):continue
   v=volume(q,z)
   if v>.001:report['static'].append({'one':n,'two':zn,'mm3':v})
 for i in range(d.timeline.count):
  f=d.timeline.item(i).entity
  if hasattr(f,'healthState') and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:report['features'].append({'name':f.name,'message':f.errorOrWarningMessage})
 def save():
  report['passed']=not report['static'] and not report['features'] and all(x['passed'] for x in report['motion']+report['retention']+report['access'])
  (OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
 save()
 if report['static'] or report['features']:
  print(json.dumps(report,indent=2));return
 def motion(name,moving,fixed,offsets):
  fails=check(moving,fixed,offsets);report['motion'].append({'name':name,'poses':len(offsets),'passed':not fails,'failures':fails[:15]});save()
 allfixed=('05','06','09','10','11','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Battery','REF Capacitor','REF Guide')
 motion('Front closes with captive RGB guide',('01','02','03','04','07','08'),allfixed,[(0,0,i*.25) for i in range(81)])
 motion('Front guide loads from inside frame',('08',),('01',),[(0,0,-i*.25) for i in range(81)])
 motion('Rear guides insert before keeper and charger',('09','10'),('05',),[(0,0,i*.25) for i in range(29)])
 motion('Rear keeper lowers over seated guides',('11',),('05','09','10'),[(0,0,i*.25) for i in range(41)])
 motion('Charger loads after guide keeper',('REF Charger',),('05','09','10','11','REF Guide'),[(0,0,i*.25) for i in range(81)])
 motion('Yoke installs over completed electronics',('06',),('05','09','10','11','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Guide'),[(0,0,i*.25) for i in range(81)])
 # Explicit maximum axial play, then 0.10 mm beyond each stop. Both stops
 # must be case/keeper material, never the LED or board reference.
 for name,prefix,low,high,stops in [('Front',('08',),0,.25,('01','06')),('Upper rear',('09',),-.2,0,('05','11')),('Lower rear',('10',),-.2,0,('05','11'))]:
  free=check(prefix,allfixed+('01',),[(0,0,-(low+(high-low)*i/10)) for i in range(11)])
  blocked=[]
  for delta in (low-.1,high+.1):
   contacts=check(prefix,stops,[(0,0,-delta)]);blocked.append({'depth_offset_mm':delta,'contacts':contacts,'blocked_by_structure':bool(contacts)})
  report['retention'].append({'guide':name,'depth_offset_range_mm':[low,high],'nominal_axial_play_mm':high-low,'free_play_collisions':free,'stop_probes':blocked,'passed':not free and all(q['blocked_by_structure'] for q in blocked)})
  save()
 # Straight hex-key access. The nut lowers into an open bay, slides under
 # the structural roof, then is drawn up against it by the screw.
 p=lambda x,y,dep:C.Point3D.create(x/10,y/10,-dep/10)
 tool=tm.createCylinderOrCone(p(6.5,42.3,0),.15,p(6.5,42.3,14.8),.15)
 obstacles=select(('05','06','09','10','11','REF Charger','REF XIAO'))
 fails=[{'part':n,'mm3':volume(tool,z)} for n,z in obstacles if volume(tool,z)>.001]
 report['access'].append({'name':'Straight driver access before installing front','passed':not fails,'failures':fails})
 nut=next(q for n,q in select(('REF Guide',)) if q.name.startswith('M3 nut envelope'))
 fails=[]
 offsets=[(0,-7.8,step*.25-.5) for step in range(61)]+[(0,-7.8+i*.13,-.5) for i in range(61)]+[(0,0,-.5+i*.05) for i in range(11)]
 for step,off in enumerate(offsets):
  q=moved(nut,off)
  for n,z in select(('05',)):
   v=volume(q,z)
   if v>.001:fails.append({'step':step,'part':n,'mm3':v})
 report['access'].append({'name':'Nut lowers into bay then slides 7.8 mm under roof before keeper','passed':not fails,'failures':fails[:15]})
 nut_stop=sum(volume(moved(nut,(0,0,.1)),z) for n,z in select(('05',)))
 keeper_stop=check(('11',),('05',),[(0,0,-.1)])
 report['access'].append({'name':'M3 clamp reacts through housing nut roof and keeper seat','nut_roof_probe_mm3':nut_stop,'keeper_seat_probe':keeper_stop,'nut_roof_thickness_mm':2,'passed':nut_stop>.001 and bool(keeper_stop)})
 save();print(json.dumps({'passed':report['passed'],'static':report['static'],'failed_motion':[x for x in report['motion'] if not x['passed']],'failed_retention':[x for x in report['retention'] if not x['passed']],'failed_access':[x for x in report['access'] if not x['passed']]},indent=2))
