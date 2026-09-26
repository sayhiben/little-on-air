import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path

def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('reset25',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke');xiao=b.comp('REF XIAO')
 b.box(xiao,'Measured reset target 1.8 mm from PCB back',112,55,13.665,.6,2,1.8)
 reset=b.component('07 Guided rounded reset button','Measured 0.10 mm free play; 3 mm exposed end; 0.40 mm inward travel')
 cy,cd=56,14.55
 def octa(half,bevel):
  return [(cy-half,cd-half+bevel),(cy-half+bevel,cd-half),(cy+half-bevel,cd-half),(cy+half,cd-half+bevel),(cy+half,cd+half-bevel),(cy+half-bevel,cd+half),(cy-half+bevel,cd+half),(cy-half,cd+half-bevel)]
 m.yz(reset,'Keyed stem with 3 mm finger projection',115.9,octa(1.4,.55),7.1)
 m.yz(reset,'Asymmetric flange kept clear of USB',115.4,[(53.9,12.45),(58.1,12.45),(58.1,15.5),(53.9,15.5)],.6)
 m.yz(reset,'Wider measured reset contact',112.7,[(54.6,13.75),(57.4,13.75),(57.4,15.35),(54.6,15.35)],2.8)
 sk,_=m.plane_sketch(reset,'Rounded exterior face','x',122.8);sk.sketchCurves.sketchCircles.addByCenterRadius(sk.modelToSketchSpace(b.p(122.8,56,-14.55)),.14);b.extrude(reset,sk,.2,'Rounded finger end')
 b.union(reset)
 # Enlarge loading clearance in X for the longer outside stem, preserving closed wall.
 b.cutbox(rear,'Longer button inside loading path',103.5,53.65,9.45,12.49,4.7,6.3)
 b.box(yoke,'Measured reset 0.40 mm stop face',114.8,52.1,12.05,.2,2.2,3.45);b.union(yoke)
 for name,val in {'reset_tip_x':112.7,'reset_stroke':.4,'reset_free_play':.1,'reset_exterior_projection':3,'reset_target_from_pcb_back':1.8}.items():
  p=b.design().userParameters.itemByName(name)
  if p:p.expression=str(val)+' mm';p.comment='v2.5 measured reset stack and exterior projection'
  else:b.design().userParameters.add(name,b.vi(val),'mm','v2.5 measured reset stack')
 for c in (rear,yoke):b.paint(c)
 b.paint(reset,'Control PETG',(105,110,117));b.paint(xiao,'PCB green',(24,100,63))
 m.finish('v2.5 longer accessible reset with measured contact and narrow USB-side flange')
