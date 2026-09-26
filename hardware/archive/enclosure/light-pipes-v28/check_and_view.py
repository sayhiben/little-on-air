import adsk.core as C
import adsk.fusion as F
import adsk,importlib.util,json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v28-light-pipes'
def run(_context:str):
 # Reuse all 45 established wire/bay reservations against only the new solids.
 src=(BASE/'v28/validate_harness.py').read_text()
 src=src.replace("if not o.component.name.startswith(('81','82','REF Harness'))", "if o.component.name.startswith(('08','09','10'))")
 ns={'__file__':str(BASE/'v28/validate_harness.py')};exec(compile(src,'pipe_harness_validation','exec'),ns);ns['OUT']=OUT;ns['run'](_context)
 report=json.loads((OUT/'harness-validation.json').read_text());assert report['passed']
 s=importlib.util.spec_from_file_location('b',str(BASE/'build_enclosure.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
 app=C.Application.get();d=b.design();occ=list(b.root().occurrences);vp=app.activeViewport
 for o in occ:
  c=o.component
  if c.name.startswith(('08','09','10')):b.paint(c,'Light pipe blue',(86,184,219))
 views=OUT/'views';views.mkdir(exist_ok=True)
 def view(name,prefix,eye,target):
  for o in occ:o.isLightBulbOn=o.component.name.startswith(prefix)
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(*target);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(views/name),1400,1000)
 view('front-guide-and-USB-clearance.png',('08','REF XIAO'),(128,76,28),(99,47,-12))
 view('separate-charger-guides.png',('09','10','REF Charger'),(-5,65,-50),(20,44,-18))
 view('front-guide-shape.png',('08',),(126,78,28),(104,55,-9))
 for o in occ:o.isLightBulbOn=not o.component.name.startswith(('81','82'))
 cam=vp.camera;cam.isFitView=True;vp.camera=cam
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v28-light-pipes.f3d')))
 print('All wire reservations clear; three native inspection views saved.')
