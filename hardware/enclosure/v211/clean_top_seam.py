"""Restore three obsolete top notch floors on the archived v2.10 front."""
import adsk.core as C
import adsk.fusion as F
import adsk, importlib.util, json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v211'
s=importlib.util.spec_from_file_location('seam_helpers',str(BASE/'build_enclosure.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b)

def run(_context:str):
 OUT.mkdir(parents=True,exist_ok=True);app=C.Application.get()
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE/'output/on-air-v210-beveled-front/cad/little-on-air-v210.f3d')))
 doc.name='Little ON AIR v2.11 - clean top seam'
 d=b.design();c=b.comp('01 Front optical bezel');tm=F.TemporaryBRepManager.get();old=tm.copy(c.bRepBodies.item(0))
 before={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 def floors():
  return [f for f in c.bRepBodies.item(0).faces if abs(f.boundingBox.minPoint.z+.915)<1e-7 and abs(f.boundingBox.maxPoint.z+.915)<1e-7 and f.boundingBox.minPoint.y>5.7]
 faces=floors();assert len(faces)==3
 areas=[f.area*100 for f in faces];expected=sum(areas)*.35
 def boolean(a,z,op):
  q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),op);return q
 # Extrude the exact planar floors, including the rounded outer corner. New
 # bodies permit an explicit direction/bounds check before joining the frame.
 for direction in (F.ExtentDirections.NegativeExtentDirection,F.ExtentDirections.PositiveExtentDirection):
  inp=c.features.extrudeFeatures.createInput(b.oc(floors()),F.FeatureOperations.NewBodyFeatureOperation)
  assert inp.setOneSideExtent(F.DistanceExtentDefinition.create(b.vi(.35)),direction)
  feature=c.features.extrudeFeatures.add(inp)
  # Fusion includes the source face's original body in feature.bodies.
  fills=[q for q in feature.bodies if q.boundingBox.maxPoint.z<-.85]
  good=len(fills)==3 and all(abs(q.boundingBox.minPoint.z+.95)<1e-7 and abs(q.boundingBox.maxPoint.z+.915)<1e-7 for q in fills)
  if good:break
  assert feature.deleteMe()
 assert good,'Restoration must extend only from D9.15 to D9.50'
 feature.name='Restore three legacy top seam recesses by 0.35 mm'
 assert abs(sum(q.volume*1000 for q in fills)-expected)<1e-5
 b.union(c,'Join restored top rim');assert c.bRepBodies.count==1 and not floors()
 c.description='v2.11: three obsolete top seam notches closed. v2.10 1.4 mm outer and 0.8 mm aperture bevels retained. Existing controls, optics and mounting geometry preserved.'
 new=c.bRepBodies.item(0);added=boolean(new,old,F.BooleanTypes.DifferenceBooleanType);removed=boolean(old,new,F.BooleanTypes.DifferenceBooleanType)
 assert removed.volume*1000<1e-5 and abs(added.volume*1000-expected)<1e-5
 regions=[{'name':'Charger legacy notch','lo':[14.8,57.6,9.15],'hi':[28.2,60,9.5]}, {'name':'MODE legacy notch','lo':[55.25,57.6,9.15],'hi':[64.75,60,9.5]}, {'name':'Old XIAO legacy notch','lo':[110.4,58.2,9.15],'hi':[117.5,60,9.5]}]
 def box(lo,hi):
  return tm.createBox(C.OrientedBoundingBox3D.create(b.p((lo[0]+hi[0])/2,(lo[1]+hi[1])/2,-(lo[2]+hi[2])/2),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
 outside=tm.copy(added)
 for r in regions:outside=boolean(outside,box(r['lo'],r['hi']),F.BooleanTypes.DifferenceBooleanType)
 assert outside.volume*1000<1e-5
 def overlap(a,z):
  aa=a.boundingBox;zz=z.boundingBox
  return all(min(x,y)-max(u,v)>1e-7 for x,y,u,v in zip(aa.maxPoint.asArray(),zz.maxPoint.asArray(),aa.minPoint.asArray(),zz.minPoint.asArray()))
 def collisions(shape,objects):
  result=[]
  for name,q in objects:
   if not overlap(shape,q):continue
   vol=boolean(shape,q,F.BooleanTypes.IntersectionBooleanType).volume*1000
   if vol>.0001:result.append({'part':name,'volume_mm3':vol})
  return result
 groups={o.component.name:list(o.component.bRepBodies) for o in b.root().occurrences}
 def select(prefixes):return [(n,q) for n,bs in groups.items() if n.startswith(prefixes) for q in bs]
 static=collisions(added,[(n,q) for n,bs in groups.items() if not n.startswith(('01','81','82','REF Harness')) for q in bs]);assert not static,static
 # A full enclosing sweep is conservative and continuous, with no sampling gap.
 fixed=select(('05','06','09','10','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Battery','REF Capacitor'))
 motions=[]
 for r in regions:
  lo=r['lo'].copy();lo[2]-=20
  fail=collisions(box(lo,r['hi']),fixed)
  motions.append({'name':r['name']+' complete front closure','continuous_stroke_mm':20,'method':'Conservative full swept rectangular envelope','failures':fail,'passed':not fail})
 for name,q in select(('02','03','04','07','08')):
  bb=q.boundingBox;lo=[bb.minPoint.x*10,bb.minPoint.y*10,-bb.maxPoint.z*10];hi=[bb.maxPoint.x*10,bb.maxPoint.y*10,-bb.minPoint.z*10+20]
  fail=collisions(box(lo,hi),[('Restored top rim',added)])
  motions.append({'name':name+' rear insertion past restored rim','continuous_stroke_mm':20,'method':'Conservative full swept rectangular envelope','failures':fail,'passed':not fail})
 assert all(x['passed'] for x in motions),motions
 issues=[]
 for i in range(d.timeline.count):
  f=d.timeline.item(i).entity
  if hasattr(f,'healthState') and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:issues.append({'name':f.name,'message':f.errorOrWarningMessage})
 assert not issues,issues
 after={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 changed=[k for k in before if before[k]!=after[k]];assert changed==['01 Front optical bezel'],changed
 keeper_front=min(-q.boundingBox.maxPoint.z*10 for _,q in select(('06',)));assert abs(keeper_front-9.65)<1e-5
 report={'passed':True,'document':doc.name,'changed_components':changed,'filled_notches':regions,'floor_areas_mm2':areas,'added_volume_mm3':added.volume*1000,'removed_volume_mm3':removed.volume*1000,'change_confined_to_notches':True,'remaining_obsolete_top_floor_count':len(floors()),'outer_bevel_mm':1.4,'aperture_bevel_mm':.8,'retainer_front_depth_mm':keeper_front,'normal_seam_clearance_mm':keeper_front-9.5,'static_added_material_collisions':static,'motion_checks':motions,'feature_issues':issues,'all_other_components_unchanged':True,'validation_basis':'Exact old/new native solid subtraction and conservative continuous swept envelopes for the added material. Existing assembly validation remains applicable outside these three regions.'}
 (OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
 s=importlib.util.spec_from_file_location('seam_harness',str(BASE/'v28/validate_harness.py'));h=importlib.util.module_from_spec(s);s.loader.exec_module(h)
 h.OUT=OUT;h.OBSTACLE_BOXES=regions;h.RESULT_NAME='seam-wire-clearance.json';h.run(_context)
 hr=json.loads((OUT/'seam-wire-clearance.json').read_text());assert hr['passed']
 hr['note']='All existing wire routes, component bays and LED pigtail reservations checked against conservative enclosing boxes of the three restored top notches. Unchanged geometry retains the previous full harness validation.'
 (OUT/'seam-wire-clearance.json').write_text(json.dumps(hr,indent=2))
 b.paint(c);occ=list(b.root().occurrences);vp=app.activeViewport;views=OUT/'views';views.mkdir(exist_ok=True)
 def view(name,prefix,eye,target,up=(0,1,0)):
  for o in occ:o.isLightBulbOn=o.component.name.startswith(prefix)
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(*target);cam.upVector=C.Vector3D.create(*up);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(views/name),1600,1000)
 view('clean-frame.png',('01',),(150,100,175),(60,30,-5))
 view('clean-top-seam.png',('01','05','06'),(135,180,45),(60,45,-9),(0,0,1))
 view('clean-assembly.png',('01','02','03','04','05','06','07','08','09','10','REF M3'),(150,100,175),(60,30,-12))
 for o in occ:o.isLightBulbOn=not o.component.name.startswith(('81','82'))
 dst=OUT/'meshes-assembly-coordinates';dst.mkdir(exist_ok=True)
 opt=d.exportManager.createSTLExportOptions(c,str(dst/'01-front-optical-bezel.stl'));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v211-assembly.step')))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v211.f3d')))
 print(json.dumps({'passed':True,'added_mm3':added.volume*1000,'changed':changed,'continuous_motion_checks':len(motions),'wire_items_checked':len(hr['items'])},indent=2))
