"""Keep the proven front; open two rearward LED lead exits in the yoke.

Candidate only until routing, interface, mesh and slicing audits pass.
"""
import adsk.core as C,adsk.fusion as F,adsk,importlib.util,json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v216'
s=importlib.util.spec_from_file_location('helpers216',BASE/'build_enclosure.py');b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
def fingerprint(q):
 return [q.volume,q.area,q.faces.count,q.edges.count,q.boundingBox.minPoint.asArray(),q.boundingBox.maxPoint.asArray()]
def contact_gusset(c):
 sk=b.sketch(c,'Self supporting charger contact gusset',17.9,'x')
 pts=[sk.modelToSketchSpace(b.p(*p)) for p in [(17.9,54.65,-11.4),(17.9,53.7,-12.35),(17.9,54.65,-12.35)]]
 for i,p in enumerate(pts):sk.sketchCurves.sketchLines.addByTwoPoints(p,pts[(i+1)%3])
 b.extrude(c,sk,2.4,'45 degree support under relocated charger contact')
def run(_context:str):
 app=C.Application.get();doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE.parents[1]/'release/little-on-air-enclosure-v2.15/cad/little-on-air-v215.f3d')))
 doc.name='Little ON AIR v2.16 - rearward LED lead access'
 d=b.design();c=b.comp('06 Electronics retaining yoke');rear=b.comp('05 Rear electronics housing');tm=F.TemporaryBRepManager.get();old=tm.copy(c.bRepBodies.item(0));oldrear=tm.copy(rear.bRepBodies.item(0))
 before={o.component.name:[fingerprint(q) for q in o.component.bRepBodies] for o in b.root().occurrences if o.component.name not in (c.name,rear.name)}
 # A 1.45 mm edge relief leaves the charger rail 3.0 mm wide. It never
 # reaches the PCB-contact pads, which start behind depth 12.35 mm.
 b.box(c,'Widen charger rail inward before wire relief',25.5,44,9.65,2.0,11.25,2.75)
 b.union(c,'Join wider charger load path')
 b.cutbox(c,'Open rearward left LED lead exit',29.5,48.0,9.64,3.5,7.25,2.77)
 b.cutbox(c,'Relocate upper charger contact clear of wire sweep',27.3,53.45,12.4,2.5,3.1,2.85)
 b.box(c,'Broad upper charger contact below USB end',17.9,53.7,12.35,2.4,3,2.8)
 contact_gusset(c)
 # Preserve a full-width POWER side arm by moving its outer section into
 # the unused space beside it before opening the inner wire path.
 b.box(c,'POWER and MODE shared broad load path',51.7,36,9.65,4.9,21.3,2.75)
 b.box(c,'Widen opposite MODE rail beside wire groove',66.7,48,9.65,1.4,7.25,2.75)
 b.box(c,'Thicker POWER top return beside LED leads',46.8,55.25,9.65,6.3,2.05,4.15)
 b.union(c,'Join robust replacement load path')
 b.cutbox(c,'Open rearward right LED lead exit',46.8,48.0,9.64,4.9,7.25,2.77)
 b.cutbox(c,'Open rear wire groove across reinforced MODE rails',51.65,49.0,11.6,16.5,6.2,.81)
 for x,w in ((30.55,2.6),(46.85,5.35)):b.cutbox(rear,'Open shallow wire relief outside POWER body seat',x,50.85,13.79,w,4.4,1.31)
 b.cutbox(rear,'Open wire clearance ahead of MODE terminal guard',53.2,53.6,13.69,13.6,1.69,.46)
 b.paint(c);assert c.bRepBodies.count==1
 def boolean(a,z,op):
  q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),op);return q
 new=c.bRepBodies.item(0);added=boolean(new,old,F.BooleanTypes.DifferenceBooleanType);removed=boolean(old,new,F.BooleanTypes.DifferenceBooleanType)
 unchanged=[]
 for o in b.root().occurrences:
  if o.component.name in (c.name,rear.name):continue
  assert [fingerprint(q) for q in o.component.bRepBodies]==before[o.component.name],o.component.name
  unchanged.append(o.component.name)
 def box(lo,hi):
  return tm.createBox(C.OrientedBoundingBox3D.create(b.p(*[(lo[i]+hi[i])/2 for i in range(3)]),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*( (hi[i]-lo[i])/10 for i in range(3))))
 # Entire contact and guide layer, both screw seats, and all XIAO/MODE
 # geometry must remain exactly unchanged.
 guards=[('Left screw seat',(30.7,33.7,-20),(39.3,42.3,-9.4)),('Right screw seat',(68.7,33.7,-20),(77.3,42.3,-9.4)),('XIAO complete',(82,33,-25),(120,65,0)),('MODE contact pads',(55.4,55.8,-25),(64.6,60,-12.42)),('Charger lower contact pads',(12,33,-18),(30,37,-12.42)),('Charger left upper contact',(12,53.4,-18),(15,57,-12.42)),('POWER left contact',(36.5,53.9,-14),(39.1,56.6,-12.42)),('POWER right contact',(42.9,53.9,-14),(45.5,56.6,-12.42))]
 checks=[]
 for name,lo,hi in guards:
  guard=box(lo,hi);change=sum(boolean(q,guard,F.BooleanTypes.IntersectionBooleanType).volume*1000 for q in (added,removed))
  checks.append({'name':name,'changed_mm3':change,'passed':change<1e-5})
 health=[]
 for i in range(d.timeline.count):
  e=d.timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:health.append({'name':e.name,'message':e.errorOrWarningMessage})
 rearremoved=boolean(oldrear,rear.bRepBodies.item(0),F.BooleanTypes.DifferenceBooleanType);rearadded=boolean(rear.bRepBodies.item(0),oldrear,F.BooleanTypes.DifferenceBooleanType)
 for name,lo,hi in [('POWER body supports',(35.3,48,-22),(46.7,60,-9.4)),('POWER mounting flange',(30,57.5,-22),(52,60,-9.4)),('MODE body seat',(55.25,55.29,-24),(64.75,61,-9.4)),('Charger complete',(9,26,-24),(30.3,61,-9.4))]:
  guard=box(lo,hi);volume=boolean(rearremoved,guard,F.BooleanTypes.IntersectionBooleanType).volume*1000
  checks.append({'name':name,'changed_mm3':volume,'passed':volume<1e-5})
 report={'passed':all(x['passed'] for x in checks) and not health and rearadded.volume<1e-9,'changed_components':[c.name,rear.name],'unchanged_components':unchanged,'interface_checks':checks,'feature_health':health,'added_yoke_mm3':added.volume*1000,'removed_yoke_mm3':removed.volume*1000,'removed_rear_mm3':rearremoved.volume*1000,'added_rear_mm3':rearadded.volume*1000,'minimum_relieved_charger_rail_width_mm':4.0,'reinforced_MODE_rail_width_mm':4.9,'wire_groove_floor_mm':1.95,'retainer_original_thickness_mm':2.75,'upper_right_charger_contact_change':'Relocated from outer corner to the bare PCB front below the USB end: X17.9..20.3,Y53.7..56.7. Unchanged 2.4 x3 mm contact area, 2.8 mm height and 0.15 mm PCB face clearance.'}
 (OUT/'native-build.json').write_text(json.dumps(report,indent=2));assert report['passed'],report
 (OUT/'meshes-assembly-coordinates').mkdir(exist_ok=True)
 opt=d.exportManager.createSTLExportOptions(c,str(OUT/'meshes-assembly-coordinates/06-electronics-retaining-yoke.stl'));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 opt=d.exportManager.createSTLExportOptions(rear,str(OUT/'meshes-assembly-coordinates/05-rear-electronics-housing.stl'));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'candidate.f3d')))
 print(json.dumps(report,indent=2))
