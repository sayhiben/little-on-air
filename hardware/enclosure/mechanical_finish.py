"""Final manufacturing corrections identified by the complete assembly check."""
import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
import json

def run(_context: str):
    spec=importlib.util.spec_from_file_location("loa_builder",str(Path(__file__).with_name("build_enclosure.py")))
    b=importlib.util.module_from_spec(spec); spec.loader.exec_module(b)
    shell=b.comp("01 Body and front frame"); tray=b.comp("04 Optical and electronics tray")
    for feature in reversed(list(shell.features.extrudeFeatures)):
        if feature.name.startswith("Full tray latch engagement"): feature.deleteMe()
    for x in (12.0,27.75): b.box(tray,"Connected charger stop foot",x,55.6,b.depths()[4],3.5,3.05,1.2)
    b.union(tray,"Continuous carrier including charger stops")
    y=b.param("reset_y"); dd=b.param("reset_depth")
    def circle_extrude(name,x,length,diam,operation):
        sk=b.sketch(shell,name+" profile",x,"x")
        center=sk.modelToSketchSpace(b.p(x,y,-dd))
        sk.sketchCurves.sketchCircles.addByCenterRadius(center,diam/20)
        b.extrude(shell,sk,length,name,operation)
    circle_extrude("Internal reset guide collar",116.95,0.75,7,F.FeatureOperations.NewBodyFeatureOperation)
    b.union(shell)
    circle_extrude("Reset flange running clearance",116.05,0.9,6.1,F.FeatureOperations.CutFeatureOperation)
    circle_extrude("Extended reset stem guide",116.95,4.0,4.3,F.FeatureOperations.CutFeatureOperation)
    b.cutbox(shell,"XIAO component corner clearance",115.4,50.3,9.1,0.25,0.9,6.4)
    b.paint(shell); b.paint(tray)
    b.finish("mechanical-finish")
    print(json.dumps({"tray_solid_count":tray.bRepBodies.count,"guide_inner_stop_x":116.95}))
