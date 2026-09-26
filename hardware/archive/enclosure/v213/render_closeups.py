"""Explicit camera extents for readable, centered retention closeups."""
import adsk.core as C
import adsk.fusion as F
import adsk,importlib.util
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v213/views'
def run(_context:str):
 s=importlib.util.spec_from_file_location('closeup_helpers',str(BASE/'build_enclosure.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
 app=C.Application.get();vp=app.activeViewport;saved=vp.camera;tm=F.TemporaryBRepManager.get();sections=[]
 for name,source,d0,d1,col in [('VIEW Front bearing section','01 Front optical bezel',0,10,(80,85,90)),('VIEW Yoke stop section','06 Electronics retaining yoke',9,19,(210,140,65))]:
  c=b.component(name);sections.append(next(o for o in b.root().occurrences if o.component==c));q=tm.copy(b.comp(source).bRepBodies.item(0))
  tool=tm.createBox(C.OrientedBoundingBox3D.create(b.p((99.5+103.605)/2,55,-(d0+d1)/2),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),.4105,.8,(d1-d0)/10));assert tm.booleanOperation(q,tool,F.BooleanTypes.IntersectionBooleanType)
  f=c.features.baseFeatures.add();f.startEdit();c.bRepBodies.add(q,f);f.finishEdit();b.paint(c,name,col)
 occ=list(b.root().occurrences)
 def view(file,prefix,eye,target,radius):
  for o in occ:o.isLightBulbOn=o.component.name.startswith(prefix)
  adsk.doEvents();vp.refresh();adsk.doEvents()
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(*target);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=False;cam.viewExtents=radius/10;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(OUT/file),1600,1100)
 view('front-captive-guide.png',('08','VIEW'),(140,62,-2),(103.3,55,-8.5),18)
 view('front-guide-shape.png',('08',),(140,62,-2),(103.605,55,-8.4),15)
 view('rear-guide-keeper.png',('09','10','11','REF Guide'),(-15,62,10),(10.2,45.5,-18.7),26)
 for o in sections:assert o.deleteMe()
 for o in b.root().occurrences:o.isLightBulbOn=not o.component.name.startswith(('81','82'))
 vp.camera=saved;vp.refresh()
 print('Centered native front cutaway and rear keeper closeups refreshed.')
