"""Complement the top/right and bottom/right views with the left side."""
import adsk.core as C
import adsk.fusion as F
import adsk
from pathlib import Path
def run(_context:str):
 app=C.Application.get();assert app.activeDocument.name=='Little ON AIR v2.12 - complete perimeter cleanup'
 d=F.Design.cast(app.activeProduct);occ=list(d.rootComponent.occurrences);vp=app.activeViewport
 for o in occ:o.isLightBulbOn=o.component.name.startswith(('01','05','06'))
 cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=C.Point3D.create(-7.5,18,4.5);cam.target=C.Point3D.create(6,4.5,-.9);cam.upVector=C.Vector3D.create(0,0,1);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
 vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents()
 assert vp.saveAsImageFile(str(Path(__file__).resolve().parents[1]/'output/v212/views/clean-top-left-seam.png'),1600,1000)
 for o in occ:o.isLightBulbOn=not o.component.name.startswith(('81','82'))
 print('Left/top perimeter preview exported.')
