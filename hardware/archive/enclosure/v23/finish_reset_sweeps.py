import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('reset23',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(yoke,'Open reset flange pocket completely to rear for assembly',113.95,53.65,12.2,1,4.7,20)
 sk,_=m.plane_sketch(rear,'Reset exterior cap travel recess','x',119.75)
 center=sk.modelToSketchSpace(b.p(119.75,56,-14.55));sk.sketchCurves.sketchCircles.addByCenterRadius(center,.19)
 b.extrude(rear,sk,.4,'Reset rounded cap counterbore',F.FeatureOperations.CutFeatureOperation)
 b.design().userParameters.itemByName('reset_guide_length').expression='4.8 mm'
 for c in (rear,yoke):b.paint(c)
 m.finish('Reset flange assembly slot and cap full-stroke recess')
