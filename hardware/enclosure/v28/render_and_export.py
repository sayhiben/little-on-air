import adsk.core as C
import adsk.fusion as F
import adsk,importlib.util,json,re
from pathlib import Path
HERE=Path(__file__).resolve().parent
def run(_context:str):
 s=importlib.util.spec_from_file_location('slim',str(HERE/'revise_fit.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 app=C.Application.get();d=b.design();out=m.OUT;vp=app.activeViewport;occ=list(b.root().occurrences)
 for o in occ:
  c=o.component
  if c.name.startswith(('REF Charger','REF XIAO')):b.paint(c,'PCB green',(24,100,63))
  elif c.name.startswith('REF'):b.paint(c,'Component grey',(135,145,155))
  elif c.name.startswith('02'):b.paint(c,'Clear acrylic',None);c.opacity=.24
  elif c.name.startswith('07'):b.paint(c,'Button grey',(105,112,121))
  else:b.paint(c)
  if c.name.startswith('03'):
   white=b.appearance('White lettering',(244,245,240))
   for f in c.bRepBodies.item(0).faces:
    if f.boundingBox.maxPoint.z*10> -5.674:f.appearance=white
  o.isLightBulbOn=not c.name.startswith(('81','82'))
  for sk in c.sketches:sk.isVisible=False
  c.isConstructionFolderLightBulbOn=False;c.isOriginFolderLightBulbOn=False
 views=out/'views';views.mkdir(exist_ok=True)
 def view(name,eye,target,prefix=None):
  for o in occ:o.isLightBulbOn=not o.component.name.startswith(('81','82')) if prefix is None else o.component.name.startswith(prefix)
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(*target);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(views/name),1600,1000)
 view('parallel-boards-layout.png',(60,30,200),(60,30,-16),('05','REF Battery','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Capacitor'))
 view('retained-electronics.png',(150,120,170),(60,30,-16),('05','06','REF Battery','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Capacitor'))
 view('slim-assembled.png',(160,110,170),(60,30,-12))
 view('front-reset-and-indicator.png',(60,30,220),(60,30,-12))
 view('side-profile.png',(220,30,-12),(60,30,-12))
 view('slim-assembled.png',(160,110,170),(60,30,-12))
 # Importable independent STEP and native Fusion archive, then STL per part.
 dst=out/'meshes-assembly-coordinates';dst.mkdir(exist_ok=True)
 for o in occ:
  c=o.component
  if c.name.startswith(('REF','02')):continue
  slug=re.sub(r'[^a-z0-9]+','-',c.name.lower()).strip('-')
  opt=d.exportManager.createSTLExportOptions(c,str(dst/(slug+'.stl')));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False
  assert d.exportManager.execute(opt)
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(out/'little-on-air-v28-assembly.step')))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(out/'little-on-air-v28.f3d')))
 print('Native CAD, individual STL meshes and views exported')
