"""Capture native assembled, service and exploded views, restoring assembly positions."""
import adsk.core as C
import adsk.fusion as F
import adsk
from pathlib import Path
import json

OUT=Path(__file__).resolve().parent/"output"/"views"

def run(_context: str):
    app=C.Application.get(); d=F.Design.cast(app.activeProduct); root=d.rootComponent; vp=app.activeViewport
    d.activateRootComponent()
    OUT.mkdir(parents=True,exist_ok=True)
    occurrences=list(root.occurrences)
    def camera(eye,target,up=(0,1,0)):
        cam=vp.camera; cam.cameraType=C.CameraTypes.OrthographicCameraType
        cam.eye=C.Point3D.create(*[v/10 for v in eye]); cam.target=C.Point3D.create(*[v/10 for v in target])
        cam.upVector=C.Vector3D.create(*up); cam.isSmoothTransition=False; cam.isFitView=True; vp.camera=cam
        vp.refresh()
    def save(name):
        adsk.doEvents()
        vp.refresh()
        adsk.doEvents()
        if not vp.saveAsImageFile(str(OUT/name),1800,1200): raise RuntimeError("Could not capture "+name)
    for o in occurrences:
        o.isLightBulbOn=True; o.component.opacity=0.22 if o.component.name.startswith("02") else 1.0
    vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle
    camera((160,125,170),(60,30,-10)); save("assembled.png")
    camera((60,30,200),(60,30,-10)); save("front.png")
    for o in occurrences:
        if o.component.name.startswith("10"): o.isLightBulbOn=False
    camera((170,115,-190),(60,30,-14)); save("rear-service.png")
    for o in occurrences:
        if o.component.name.startswith("01"): o.isLightBulbOn=False
    camera((60,30,-200),(60,30,-14)); save("electronics-layout.png")
    placements={
        "01":(0,0,115),"02":(0,0,65),"03":(0,0,40),"04":(0,0,0),
        "05":(-24,0,-30),"06":(30,0,-30),"07":(40,0,0),"08":(0,25,0),
        "09":(0,25,-30),"10":(0,0,-90),
    }
    for o in occurrences:
        o.isLightBulbOn=not o.component.name.startswith("REF")
        if o.isLightBulbOn:
            dx,dy,dz=placements[o.component.name[:2]]
            # The first component is grounded to the root; leave it at origin.
            dz-=115
            m=C.Matrix3D.create(); m.translation=C.Vector3D.create(dx/10,dy/10,dz/10); o.transform2=m
    exploded_position=d.snapshots.add()
    camera((300,200,145),(64,30,-117)); save("exploded.png")
    exploded_position.deleteMe()
    for o in occurrences:
        o.transform2=C.Matrix3D.create(); o.isLightBulbOn=True
    camera((160,125,170),(60,30,-10))
    print(json.dumps({"views":str(OUT),"assembly_restored":True}))
