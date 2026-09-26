import adsk.core as C
import adsk.fusion as F
import importlib.util,math,json
from pathlib import Path

def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('m25',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 # Close the blocked side mouth, then turn the hex pocket and entry toward -Y.
 b.box(rear,'Upper left nut pocket restoration',1.8,49.8,24.55,8.7,8.4,3.1);b.union(rear)
 sk=b.sketch(rear,'Upper left rotated M3 nut pocket',24.6);r=6/math.sqrt(3)
 b.polygon(sk,[(6+r*math.cos(math.pi/2+i*math.pi/3),54+r*math.sin(math.pi/2+i*math.pi/3)) for i in range(6)])
 b.extrude(rear,sk,-3,'Rotated hex nut seat',F.FeatureOperations.CutFeatureOperation)
 b.cutbox(rear,'Upper left nut loads from open interior',3,49.5,24.6,6,4.5,3)
 b.cutcyl(rear,'Retained upper left M3 screw bore',6,54,9.48,3.6,19.72)
 nuts=b.comp('REF M3 nuts');nut=next(bb for bb in nuts.bRepBodies if bb.name=='M3 nut (2)')
 mat=C.Matrix3D.create();mat.setToRotation(math.pi/2,C.Vector3D.create(0,0,1),b.p(6,54,0))
 inp=nuts.features.moveFeatures.createInput2(b.oc([nut]));inp.defineAsFreeMove(mat);nuts.features.moveFeatures.add(inp)
 # Both PCB faces need room at the plated OUT terminals near the bottom corners.
 for x in (12.2,27.3):
  b.cutbox(yoke,'Remove lower charger feet from through-hole pads',x-.65,31.8,12.4,3.8,3.3,10.7)
 for x in (12.2,27.7):b.cutbox(rear,'Clear rear side of charger OUT pads',x,31.8,24.15,2.15,2.3,7.55)
 for x in (12.25,27.35):
  b.box(yoke,'Charger lower keeper centered 5 mm above board end',x,34.3,12.35,2.4,2,10.65)
  m.xz(yoke,'Charger lower keeper broad root',34.3,[(x-.6,12.35),(x+3,12.35),(x+2.4,14.75),(x,14.75)],2)
 for x in (12.25,27.75):b.box(rear,'Charger lower rear support at clear PCB area',x,34.3,24.2,2,2,7.5)
 b.union(rear);b.union(yoke)
 # Central shelf between the two terminal rows avoids relying on gaps between pins.
 for x in (57,61):b.cutbox(rear,'Remove DPDT feet beneath terminal columns',x,53.65,20.8,2,1.49,10.9)
 b.box(rear,'DPDT central saddle between terminal rows',54.9,53.65,21.1,10.2,1.49,1.5);b.union(rear)
 c=b.component('REF DPDT','9.1 x3.72 x3.36; 0.7 mm terminals, 1.85 mm clear gaps, symmetric rows')
 b.box(c,'Measured DPDT body',55.45,55.49,20,9.1,3.36,3.72)
 for x in (57.1,59.65,62.2):
  for dep in (20,23.02):b.box(c,'Measured 0.7 mm terminal',x,52.24,dep,.7,3.25,.7)
 c=b.component('REF DPDT moving actuator','1.5 square x1.87; full travel 2.4 mm')
 b.box(c,'Direct MODE actuator',59.25,58.85,21.11,1.5,1.87,1.5)
 # Keep the inside locating-tongue clearance but close the unnecessary outer gap.
 b.box(yoke,'POWER continuous square exterior roof',38.15,58.65,9.65,5.7,1.1,11.575)
 b.box(yoke,'POWER roof square inner backbone',38.15,57.65,11.3,5.7,1,8.5);b.union(yoke)
 # Measured XIAO PCB and centered USB. The earlier measured 8.97 width is retained.
 # 17.8 - 8.97 gives 4.415 mm each side, conservatively covering the reported ~4.5.
 c=b.component('REF XIAO','Measured 17.8 x21 x1.2; USB centered across width, 1.75 overhang')
 b.box(c,'XIAO PCB',110.8,36.8,11.55,1.2,21,17.8)
 b.box(c,'XIAO component envelope',112,42.8,16,3,9,9)
 b.box(c,'Measured centered USB-C socket',112,53.15,15.965,3.17,6.4,8.97)
 # Clear the 1.2 mm PCB at the rear cheek and removable front tabs.
 b.cutbox(rear,'XIAO measured PCB thickness running allowance',110.5,36.55,11.3,1.75,21.55,18.3)
 b.cutbox(yoke,'XIAO measured PCB thickness running allowance',110.5,36.55,11.3,1.75,21.55,18.3)
 # Restore rear edge of old socket opening; new front roof is trimmed to centered port.
 b.box(rear,'Fill old low USB edge',111.5,57.35,25.235,3.77,2.65,1.785);b.union(rear)
 b.cutbox(rear,'Centered measured USB exterior opening',111.7,57.35,9.45,3.77,2.8,15.785)
 b.cutbox(yoke,'Centered measured USB roof clearance',111.7,57.35,15.665,3.77,2.8,9.57)
 for c in (rear,yoke):b.cutbox(c,'Centered USB internal tab and solder allowance',111.75,52.85,15.665,3.72,4.5,9.57)
 # Outer wall remains beyond x116, keeping the bearing clear of the socket shell.
 for c in (rear,yoke):b.union(c);b.paint(c)
 for name,val in {'xiao_pcb_thickness':1.2,'xiao_usb_edge_margin':4.415,'xiao_usb_front_depth':15.965,'dpdt_terminal_width':.7,'dpdt_terminal_clear_gap':1.85,'charger_lower_support_from_end':5}.items():
  p=b.design().userParameters.itemByName(name)
  if p:p.expression=str(val)+' mm'
  else:b.design().userParameters.add(name,b.vi(val),'mm','v2.5 measured physical fit')
 m.finish('v2.5 nuts, measured USB, solder clearance and terminal-free DPDT saddle')
 assert b.design().exportManager.execute(b.design().exportManager.createFusionArchiveExportOptions(str(m.OUT/'hardware-revised.f3d')))
