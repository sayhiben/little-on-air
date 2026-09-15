"""Explicit first-prototype corrections from native interference inspection."""
import importlib.util
from pathlib import Path
import adsk.core as C
import adsk.fusion as F
import json

def run(_context: str):
    spec=importlib.util.spec_from_file_location("loa_builder",str(Path(__file__).with_name("build_enclosure.py")))
    b=importlib.util.module_from_spec(spec); spec.loader.exec_module(b)
    moved=[]
    shell=b.comp("01 Body and front frame"); rear=b.comp("10 Wall back plate")
    for c,prefixes in ((shell,("Corner compression post","M3 through post","Recessed M3 head","Rear boss clearance")),
                       (rear,("Captive nut compression boss","M3 hex trap","Nut loading slot","Blind screw tip clearance"))):
        for sk in c.sketches:
            if not sk.name.startswith(prefixes): continue
            curves=list(sk.sketchCurves)
            points=[pt.geometry for pt in sk.sketchPoints if not pt.isReference and (abs(pt.geometry.x)>1e-6 or abs(pt.geometry.y)>1e-6)]
            if not points: continue
            xs=[q.x*10 for q in points]; ys=[q.y*10 for q in points]
            if min(xs)<105 or min(ys)<45: continue
            for curve in curves:
                if curve.isFixed: curve.isFixed=False
            for point in sk.sketchPoints:
                if point.isFixed and not point.isReference and (abs(point.geometry.x)>1e-6 or abs(point.geometry.y)>1e-6): point.isFixed=False
            transform=C.Matrix3D.create(); transform.translation=C.Vector3D.create(-1.8,0,0)
            if not sk.move(b.oc(curves),transform): raise RuntimeError("Could not move upper-right fastener: "+sk.name)
            moved.append(c.name+" / "+sk.name)
    for x,y in ((6,6),(114,6),(6,54),(96,54)):
        b.cutbox(shell,"Nut boss final rear clearance",x-4.45,y-4.45,23.6,8.9,8.9,4.2)
    for yy,hh in ((10.75,0.5),(48.75,0.5)):
        b.cutbox(shell,"LED rail acrylic edge clearance",34.5,yy,1.6,51,hh,3.65)
    # Three spring latches leave the XIAO front edge and fork unobstructed.
    tray=b.comp("04 Optical and electronics tray")
    b.cutbox(tray,"XIAO front edge clearance",111.85,31.05,7.9,3.85,11.45,2.0)
    b.cutbox(shell,"Remove unused upper-right latch shelf",112.8,37.8,9,4.8,5.4,1.8)
    for x in (10.85,29.5): b.cutbox(tray,"Charger keeper arm seat",x,30,14.2,2.55,24.25,2.1)
    b.cutbox(tray,"Charger keeper crossbar seat",10.85,29.8,14.2,21.2,1.6,1.4)
    for dd in (10.0,25.3): b.cutbox(tray,"XIAO peg axial-stop clearance",109.6,33.4,dd,3.3,1.6,1.6)
    b.cutbox(tray,"Switch keeper bridge seat",54.0,50.6,20.95,12,5.5,1.3)
    b.cutbox(tray,"USB upper stop corner clearance",112.45,56.7,24.35,0.5,0.75,0.25)
    for body in list(tray.bRepBodies):
        if body.volume<1e-8: tray.features.removeFeatures.add(body)
    plunger=b.comp("07 Captive reset plunger")
    flange=next(s for s in plunger.sketches if s.name=="Internal captive flange profile")
    flange.sketchCurves.sketchCircles.item(0).radius=0.28
    d=b.design(); d.activateRootComponent()
    for occ in b.root().occurrences:
        occ.component.opacity=1.0
        for body in occ.component.bRepBodies: body.opacity=1.0
    b.app().activeViewport.visualStyle=C.VisualStyles.ShadedVisualStyle
    b.finish("fit-corrections")
    print(json.dumps({"moved_fastener_sketches":moved,"tray_latches":3},indent=2))
