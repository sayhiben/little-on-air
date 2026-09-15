"""Cosmetic front chamfers on the archived v2.8 assembly, including light pipes."""
import adsk.core as C
import adsk.fusion as F
import adsk,importlib.util,json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v210'
s=importlib.util.spec_from_file_location('bevel_helpers',str(BASE/'build_enclosure.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b)

def run(_context:str):
 OUT.mkdir(parents=True,exist_ok=True);app=C.Application.get()
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE/'output/on-air-v28-light-pipes/cad/little-on-air-v28-light-pipes.f3d')))
 doc.name='Little ON AIR v2.10 - broader beveled front frame'
 d=b.design();c=b.comp('01 Front optical bezel');tm=F.TemporaryBRepManager.get();old=tm.copy(c.bRepBodies.item(0))
 before={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 def front_face():
  return max((f for f in c.bRepBodies.item(0).faces if abs(f.boundingBox.minPoint.z)<1e-7 and abs(f.boundingBox.maxPoint.z)<1e-7),key=lambda f:f.area)
 def edges_for(kind):
  if kind=='outer':return list(next(q for q in front_face().loops if q.isOuter).edges)
  loops=[q for q in front_face().loops if not q.isOuter and len(list(q.edges))==4 and abs(sum(e.length*10 for e in q.edges)-268)<.001]
  assert len(loops)==1;return list(loops[0].edges)
 counts={}
 for kind,amount in [('outer',1.4),('opening',.8)]:
  edges=edges_for(kind);counts[kind]=len(edges)
  d.userParameters.add('front_'+kind+'_bevel',b.vi(amount),'mm','Equal-distance 45 degree cosmetic front chamfer')
  inp=c.features.chamferFeatures.createInput2()
  assert inp.chamferEdgeSets.addEqualDistanceChamferEdgeSet(b.oc(edges),b.vi('front_'+kind+'_bevel'),False)
  feature=c.features.chamferFeatures.add(inp);feature.name=('Outer perimeter 1.4 mm highlight' if kind=='outer' else 'Display opening 0.8 mm highlight')
  assert feature.healthState==F.FeatureHealthStates.HealthyFeatureHealthState,feature.errorOrWarningMessage
 c.description='v2.10: 1.4 mm outer and 0.8 mm aperture front bevels, both 45 degrees. Original v2.8 seats, bores, controls and light guides retained.'
 new=c.bRepBodies.item(0)
 def boolean(a,z,op):
  q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),op);return q
 removed=boolean(old,new,F.BooleanTypes.DifferenceBooleanType)
 added=boolean(new,old,F.BooleanTypes.DifferenceBooleanType)
 assert added.volume*1000<1e-5
 bb=removed.boundingBox;assert bb.minPoint.z>=-.1400001 and abs(bb.maxPoint.z)<1e-7
 def probe(x,y,w,h):return tm.createBox(C.OrientedBoundingBox3D.create(b.p(x+w/2,y+h/2,-.75),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),w/10,h/10,.15))
 regions=[('reset running guide and front stop',89.5,53.5,5,4.8),('RGB aperture and pipe collar seat',101.3,52.5,4.7,5)]
 for x in (6,114):
  for y in (6,54):regions.append((f'closure screw head {x} {y}',x-3.6,y-3.6,7.2,7.2))
 tests=[]
 for name,x,y,w,h in regions:
  q=boolean(removed,probe(x,y,w,h),F.BooleanTypes.IntersectionBooleanType);v=q.volume*1000;tests.append({'region':name,'removed_mm3':v,'passed':v<1e-5})
 assert all(q['passed'] for q in tests)
 after={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 changed=[k for k in before if before[k]!=after[k]];assert changed==['01 Front optical bezel'],changed
 report={'passed':True,'changed_components':changed,'outer_bevel_mm':1.4,'aperture_bevel_mm':.8,'angle_deg':45,'selected_edge_counts':counts,'removed_volume_mm3':removed.volume*1000,'added_volume_mm3':added.volume*1000,'maximum_changed_depth_mm':-bb.minPoint.z*10,'all_geometry_deeper_than_1_4_mm_identical':True,'unchanged_control_and_screw_regions':tests,'acrylic_seat_depth_mm':1.6,'remaining_straight_aperture_wall_mm':.8,'front_bed_contact_area_mm2':front_face().area*100,'all_other_component_volumes_unchanged':True,'validation_basis':'Exact native old/new solid subtraction confines the change to cosmetic front edge material removal. Existing deeper seats and wire paths are identical.'}
 (OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
 b.paint(c);occ=list(b.root().occurrences);vp=app.activeViewport;views=OUT/'views';views.mkdir(exist_ok=True)
 def view(name,prefix,eye,target):
  for o in occ:o.isLightBulbOn=o.component.name.startswith(prefix)
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(*target);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(views/name),1600,1000)
 view('beveled-frame.png',('01',),(150,100,175),(60,30,-5))
 view('beveled-assembly.png',('01','02','03','04','05','06','07','08','09','10','REF M3'),(150,100,175),(60,30,-12))
 view('beveled-front.png',('01','02','03','04','05','06','07','08','09','10','REF M3'),(60,30,200),(60,30,-12))
 view('beveled-assembly.png',('01','02','03','04','05','06','07','08','09','10','REF M3'),(150,100,175),(60,30,-12))
 for o in occ:o.isLightBulbOn=not o.component.name.startswith(('81','82'))
 dst=OUT/'meshes-assembly-coordinates';dst.mkdir(exist_ok=True)
 opt=d.exportManager.createSTLExportOptions(c,str(dst/'01-front-optical-bezel.stl'));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v210-assembly.step')))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v210.f3d')))
 print(json.dumps(report,indent=2))
