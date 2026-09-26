import adsk.core as C
import adsk.fusion as F
import adsk
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output'/'v2'/'views'
def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);root=d.rootComponent;vp=app.activeViewport;occ=list(root.occurrences);OUT.mkdir(exist_ok=True)
 def camera(eye,target,up=(0,1,0)):
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=C.Point3D.create(*[v/10 for v in eye]);cam.target=C.Point3D.create(*[v/10 for v in target]);cam.upVector=C.Vector3D.create(*up);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam;vp.refresh()
 def save(name):
  adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(OUT/name),1800,1200)
 def visible(prefixes=None):
  for o in occ:
   o.isLightBulbOn=(not o.component.name.startswith(('81','82'))) if prefixes is None else any(o.component.name.startswith(p) for p in prefixes)
   o.component.opacity=.24 if o.component.name.startswith('02') else 1.0
 d.activateRootComponent();vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle
 visible();camera((160,125,170),(60,30,-15));save('assembled.png')
 camera((60,30,220),(60,30,-15));save('front.png')
 visible(['05','REF Battery','REF Charger','REF XIAO','REF DPDT','07','08']);camera((60,30,200),(60,30,-22));save('rear-housing-layout.png')
 visible(['05','06','REF Battery','REF Charger','REF XIAO','REF DPDT','07','08']);camera((155,125,155),(60,30,-22));save('retained-electronics.png')
 visible(['05']);camera((145,130,150),(60,30,-24));save('integrated-rear-housing.png')
 visible(['01','REF Four LEDs']);camera((140,115,-180),(60,30,-5));save('bezel-led-seats.png')
 visible(['03']);camera((60,30,200),(60,30,-6));save('registered-graphic.png')
 visible(['01','02','03','04','05','06','07','08'])
 saved=[(o,o.transform2) for o in occ];snap=None
 try:
  dz={'01':0,'02':-18,'03':-32,'04':-46,'06':-65,'05':-85,'07':-85,'08':-85}
  for o in occ:
   if o.component.name[:2] in dz:
    m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,dz[o.component.name[:2]]/10);o.transform2=m
  if d.snapshots.hasPendingSnapshot:snap=d.snapshots.add()
  camera((240,180,160),(60,30,-60));save('exploded.png')
 finally:
  if snap:snap.deleteMe()
  for o,m in saved:o.transform2=m
  visible();camera((160,125,170),(60,30,-15))
 print(str(OUT))
