"""Small physical interface samples in a separate Fusion document."""
import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
import math
import json

def run(_context: str):
    app=C.Application.get(); main=app.activeDocument
    spec=importlib.util.spec_from_file_location("loa_builder",str(Path(__file__).with_name("build_enclosure.py")))
    b=importlib.util.module_from_spec(spec); spec.loader.exec_module(b)
    app.documents.add(C.DocumentTypes.FusionDesignDocumentType)
    app.activeDocument.name="Little On Air - fit coupons"
    d=F.Design.cast(app.activeProduct); d.designType=F.DesignTypes.ParametricDesignType
    d.unitsManager.distanceDisplayUnits=F.DistanceUnits.MillimeterDistanceUnits
    for name,(value,comment) in b.PARAMS.items(): d.userParameters.add(name,b.vi(value),"mm",comment)
    c=b.component("90 M3 head and nut fit sample","Fit sample only; a 25 mm screw will protrude through this shorter coupon")
    b.box(c,"Fastener test block",0,0,0,20,16,10)
    b.cutcyl(c,"M3 clearance",7,8,0,"m3_hole",10)
    b.cutcyl(c,"M3 head recess",7,8,0,"head_d","head_depth")
    sk=b.sketch(c,"Nut sample hex",6.6); r=b.param("nut_af")/math.sqrt(3)
    b.polygon(sk,[(7+r*math.cos(i*math.pi/3),8+r*math.sin(i*math.pi/3)) for i in range(6)])
    b.extrude(c,sk,-2.6,"Nut pocket",F.FeatureOperations.CutFeatureOperation)
    b.cutbox(c,"Side nut loading slot",7,5.1,6.6,13,5.8,2.6)
    b.paint(c)
    c=b.component("91 LED and acrylic fit sample","Insert measured acrylic from the open end; check emitting centre against edge")
    b.box(c,"Optical test block",26,0,0,24,22,7)
    b.cutbox(c,"Acrylic slip slot",28,-0.1,1.6,20,12.3,3.425)
    b.cutbox(c,"LED open rear pocket",33.8,12.2,2.1875,8.4,8.4,5.0)
    b.cutbox(c,"Optical entry aperture",33.8,11.9,1.6,8.4,0.4,3.425)
    b.paint(c)
    c=b.component("92 Reset guide fit sample","Test the actual printed reset stem in this 4.3 mm bore")
    b.box(c,"Plunger guide block",55,0,0,16,16,2.4)
    b.cutcyl(c,"Stem guide clearance",63,8,0,4.3,2.4)
    b.paint(c)
    ex=d.exportManager; out=b.OUT; (out/"meshes-assembly-coordinates").mkdir(parents=True,exist_ok=True)
    for occ in d.rootComponent.occurrences:
        slug=occ.component.name.lower().replace(" ","-")
        opt=ex.createSTLExportOptions(occ.component,str(out/"meshes-assembly-coordinates"/(slug+".stl")))
        opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh; opt.unitType=F.DistanceUnits.MillimeterDistanceUnits
        if not ex.execute(opt): raise RuntimeError("Coupon STL failed")
    if not ex.execute(ex.createFusionArchiveExportOptions(str(out/"fit-coupons.f3d"))): raise RuntimeError("Coupon archive failed")
    main.activate()
    print(json.dumps({"fit_samples":3,"main_design_restored":True}))
