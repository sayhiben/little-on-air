import adsk.core as C
import adsk.fusion as F
import adsk,importlib.util,json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v213'
def module(name,path):
 s=importlib.util.spec_from_file_location(name,str(path));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def run(_context:str):
 assert json.loads((OUT/'native-validation.json').read_text())['passed']
 app=C.Application.get();b=module('export_helpers',BASE/'build_enclosure.py');d=b.design()
 h=module('new_full_harness',BASE/'v28/validate_harness.py');h.OUT=OUT;h.run(_context)
 assert json.loads((OUT/'harness-validation.json').read_text())['passed']
 pa=module('rim_audit',BASE/'v212/perimeter_audit.py');pr=pa.audit(b.comp('01 Front optical bezel').bRepBodies.item(0));assert pr['passed'];(OUT/'perimeter-validation.json').write_text(json.dumps(pr,indent=2))
 views=OUT/'views';views.mkdir(exist_ok=True);occ=list(b.root().occurrences);vp=app.activeViewport
 for o in occ:
  if o.component.name.startswith(('08','09','10')):b.paint(o.component,'Light pipe blue',(86,184,219))
 # Temporary section bodies show the actual trapping faces at useful scale.
 # They are deleted before exporting the production assembly.
 tm=F.TemporaryBRepManager.get();sections=[]
 def section(name,source,lo,hi,color):
  c=b.component(name);sections.append(next(o for o in b.root().occurrences if o.component==c))
  q=tm.copy(b.comp(source).bRepBodies.item(0));mid=[(lo[i]+hi[i])/2 for i in range(3)]
  tool=tm.createBox(C.OrientedBoundingBox3D.create(b.p(mid[0],mid[1],-mid[2]),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
  assert tm.booleanOperation(q,tool,F.BooleanTypes.IntersectionBooleanType)
  f=c.features.baseFeatures.add();f.startEdit();c.bRepBodies.add(q,f);f.finishEdit();b.paint(c,name,color)
 section('VIEW Front bearing section','01 Front optical bezel',[99.5,51,0],[103.605,59,10],(80,85,90))
 section('VIEW Yoke stop section','06 Electronics retaining yoke',[99.5,51,9],[103.605,59,19],(210,140,65))
 occ=list(b.root().occurrences)
 def view(name,prefix,eye,target):
  for o in occ:o.isLightBulbOn=o.component.name.startswith(prefix)
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(*target);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(views/name),1600,1100)
 view('front-captive-guide.png',('08','VIEW Front','VIEW Yoke'),(130,65,10),(103,55,-9))
 view('rear-guide-keeper.png',('09','10','11','REF Guide'),(-15,60,10),(12,46,-20))
 view('front-guide-shape.png',('08',),(125,73,15),(104,55,-8))
 view('rear-housing-with-retention.png',('05','09','10','11','REF Guide'),(-40,100,90),(60,30,-18))
 view('complete-assembly.png',('01','02','03','04','05','06','07','08','09','10','11','REF M3','REF Guide'),(150,100,175),(60,30,-12))
 for o in sections:assert o.deleteMe()
 occ=list(b.root().occurrences)
 for o in occ:
  o.isLightBulbOn=not o.component.name.startswith(('81','82'))
  for sk in o.component.sketches:sk.isVisible=False
  o.component.isConstructionFolderLightBulbOn=False
 dst=OUT/'meshes-assembly-coordinates';dst.mkdir(exist_ok=True)
 parts={'01 Front optical bezel':'01-front-optical-bezel.stl','05 Rear electronics housing':'05-rear-electronics-housing.stl','08 Front RGB light guide':'08-captive-front-rgb-guide.stl','09 Upper charger light guide':'09-charger-light-guide.stl','11 Rear light guide keeper':'11-rear-light-guide-keeper.stl'}
 for name,file in parts.items():
  c=b.comp(name);assert c.bRepBodies.count==1 and c.bRepBodies.item(0).isSolid
  opt=d.exportManager.createSTLExportOptions(c,str(dst/file));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v213.f3d')))
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v213-assembly.step')))
 print('Full harness and perimeter passed. Five production STLs, complete CAD and inspection views exported.')
