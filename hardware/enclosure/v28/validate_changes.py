"""Check real stop faces and contact reach, not just nominal input dimensions."""
import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json,math
OUT=Path(__file__).resolve().parents[1]/'output/v28'

def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 g={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences}
 button=g['07 Front guided reset button'][0];rear=g['05 Rear electronics housing'][0];keeper=g['06 Electronics retaining yoke'][0]
 def volume(q,z):
  t=tm.copy(q);assert tm.booleanOperation(t,tm.copy(z),F.BooleanTypes.IntersectionBooleanType);return t.volume*1000
 def moved(q,travel):
  t=tm.copy(q);m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,-travel/10);tm.transform(t,m);return t
 def box(lo,hi):
  return tm.createBox(C.OrientedBoundingBox3D.create(C.Point3D.create(*[(lo[i]+hi[i])/20 for i in range(3)]),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
 collar=[(-f.boundingBox.maxPoint.z*10,f.area*100) for f in button.faces if abs(f.boundingBox.maxPoint.z-f.boundingBox.minPoint.z)<1e-8 and f.area*100>15]
 assert len(collar)==2,collar
 depths=sorted(v[0] for v in collar);assert all(abs(a-z)<1e-5 for a,z in zip(depths,[6,8.85]))
 rigid=[(n,q) for n,bs in g.items() if n.startswith(('01','05','06','REF XIAO')) for q in bs if 'reset target' not in q.name]
 failures=[]
 for i in range(81):
  travel=i*.01;t=moved(button,travel)
  for n,q in rigid:
   v=volume(t,q)
   if v>.001:failures.append({'travel':travel,'component':n,'body':q.name,'volume_mm3':v})
 at_stop=volume(moved(button,.8),keeper);past_stop=volume(moved(button,.825),keeper)
 assert at_stop<.001 and past_stop>.001,(at_stop,past_stop)
 # Test both corner contact patches at the unchanged lower board-edge datum.
 feet=[]
 for x in (12.45,28.0):
  probe=box((x,29.98,-16.1),(x+1.25,30.02,-15.5));v=volume(probe,rear)
  feet.append({'x_mm':x,'area_mm2':1.25*.6,'intersection_mm3':v,'passed':abs(v-.015)<1e-5})
 # Stop must be continuous over all of the 17.5 mm width, not just a center tab.
 probe=box((12.25,29.9,-16.2),(29.75,30.0,-15.1));full=volume(probe,rear)
 target=next(q for q in g['REF XIAO'] if 'reset target' in q.name)
 tip=-button.boundingBox.minPoint.z*10;target_depth=-target.boundingBox.maxPoint.z*10
 r={'passed':not failures and all(x['passed'] for x in feet) and abs(full-1.925)<1e-5,
 'collar_front_depth_mm':depths[0],'collar_back_depth_mm':depths[1],'collar_thickness_mm':depths[1]-depths[0],
 'travel_before_stop_mm':.8,'extra_travel_vs_printed_v27_mm':.2,'tip_at_rest_depth_mm':tip,'tip_at_stop_depth_mm':tip+.8,
 'nominal_reference_rest_gap_mm':target_depth-tip,'nominal_PCB_clearance_at_stop_mm':18.5-tip-.8,
 'external_projection_rest_mm':2.5,'external_projection_at_stop_mm':1.7,'sampled_control_poses':81,'failures':failures,
 'both_charger_corner_contacts':feet,'full_width_stop_probe_mm3':full,'charger_lower_edge_clearance_mm':.3,
 'physical_fit_basis':'User reports the v2.7 collar reaches its stop at or almost at switch contact, without enough travel to click. New collar supplies 0.20 mm additional motion from that empirical position.',
 'limits':'The prior coarse reset target predicts earlier contact than the physical print. Its overlap is not an actual switch-travel or force specification. The PCB/USB/LED and case remain rigid collision obstacles. A physical click and release test is still required; do not force the mechanism against its stop.'}
 (OUT/'changed-interface-validation.json').write_text(json.dumps(r,indent=2));print(json.dumps(r,indent=2));assert r['passed']
