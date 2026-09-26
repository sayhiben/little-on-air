"""Native Fusion revision from physical v2.2 fit feedback. All coordinates mm, depth=-Z."""
import adsk.core as C
import adsk.fusion as F
import importlib.util, json, math
from pathlib import Path
HERE=Path(__file__).resolve().parent
OUT=HERE.parent/'output/v23'

def run(_context:str):
 app=C.Application.get();imp=app.importManager
 doc=imp.importToNewDocument(imp.createFusionArchiveImportOptions(str(HERE.parent/'output/on-air-v22-fabrication/cad/little-on-air-v22.f3d')))
 doc.name='Little On Air - Enclosure v2.3 - measured fits'
 s=importlib.util.spec_from_file_location('v23build',str(HERE/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 d=b.design();root=b.root();tm=F.TemporaryBRepManager.get()
 root.attributes.add('LittleOnAirV23','Revision','2.3 measured charger and SPDT; direct DPDT; guided reset; reinforced XIAO')
 for o in list(root.occurrences):
  if o.component.name.startswith(('06 ','07 ','08 ','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Harness')):o.deleteMe()
 rear=b.comp('05 Rear electronics housing')
 # Retain the battery, mounting hardware, wiring anchors and all untouched geometry.
 regions=[(10.3,29.8,32.3,60.1),(33,49.4,49,60.1),(53.3,47.5,66.7,60.1),(108.3,33,120.1,60.1)]
 for x,y,xx,yy in regions:b.cutbox(rear,'v23 replace measured mount region',x,y,9.45,xx-x,yy-y,22.16)
 # Restore just the original rounded shell skin where the replaced mounts had notches.
 shell=b.component('REF temporary unpierced shell')
 b.rbox(shell,'Rounded shell restoration',0,0,9.5,120,60,24.5,3)
 b.cutbox(shell,'Hollow restoration',2.4,2.4,9.48,115.2,55.2,22.12)
 for x,y,xx,yy in regions:
  box=tm.createBox(C.OrientedBoundingBox3D.create(b.p((x+xx)/2,(y+yy)/2,-20.55),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),(xx-x)/10,(yy-y)/10,22.3/10))
  body=tm.copy(shell.bRepBodies.item(0));assert tm.booleanOperation(body,box,F.BooleanTypes.IntersectionBooleanType)
  f=rear.features.baseFeatures.add();f.name='v23 original curved shell skin';f.startEdit();rear.bRepBodies.add(body,f);f.finishEdit()
 next(o for o in root.occurrences if o.component==shell).deleteMe()
 b.union(rear)
 # Charger: PCB x12.25..29.75, y30.3..58.4; USB face y59.7.
 for x in (10.35,30.05):b.box(rear,'Charger 0.30 mm lateral-clearance fence',x,30.05,22,1.6,26.3,9.7)
 b.box(rear,'Charger lower stop',11.9,28.5,22,18.2,1.55,9.7)
 for x in (12.25,28.55):
  for y in (32,54):b.box(rear,'Charger supported PCB edge',x,y,24.2,1.2,2,7.5)
 for x in (12.25,28.55):b.box(rear,'Charger upper stop',x,58.65,23.2,1.2,.8,8.5)
 # Larger POWER switch: 10.6 long x 6 deep x 5.05 tall, flange face at y58.4.
 b.box(rear,'SPDT rear seat with 0.05 mm allowance',35.5,53.15,26.05,11,5.45,5.65)
 for x in (33.9,46.5):b.box(rear,'SPDT 0.20 mm side clearance',x,52.9,19.8,1.6,4.75,11.9)
 for x in (35.5,45.4):b.box(rear,'SPDT lower body stop clear of center terminals',x,51.8,20,1.1,1.35,11.7)
 # Tiny MODE switch moves up to expose its own fingernail actuator by 0.58 mm.
 b.box(rear,'DPDT raised rear seat',55.5,55.85,23.15,9,3.15,8.55)
 for x in (53.9,64.5):b.box(rear,'DPDT body locating cheek',x,55.6,19.8,1.6,3.4,11.9)
 for x in (55.5,63.4):b.box(rear,'DPDT terminal-side stop',x,54.5,20,1.1,1.35,11.7)
 # XIAO +0.6 toward the right shell, +1.3 toward top; braced solder-access frame.
 b.box(rear,'XIAO continuous 2.5 mm support frame',108.9,35,11.65,2.5,23,20.05)
 for y,h in ((38.2,6.6),(47.3,7.9)):b.cutbox(rear,'XIAO solder window with continuous upper and lower rails',108.85,y,15.7,2.6,h,11.5)
 for y in (39,50):m.xz(rear,'XIAO 45 degree spine buttress',y,[(106.5,31.7),(108.95,31.7),(108.95,26.0)],2)
 b.box(rear,'XIAO rear outer cheek',112.8,36.55,27.7,2,21.45,4)
 b.box(rear,'XIAO rear depth stop',111.4,36.55,29.5,3.4,21.45,2.2)
 b.box(rear,'XIAO lower axial stop',111.35,35,11.65,1.5,1.55,20.05)
 b.box(rear,'XIAO upper axial stop',111.35,58,11.65,1.5,.65,20.05)
 # Lower half of reset guide: 5.05 mm bearing, keyed rounded-square stem.
 b.box(rear,'Reset deep lower guide',114.95,53.55,14.7,5.05,4.85,2.7)
 m.xz(rear,'Reset guide underside 45 degree buttress',53.55,[(114.95,17.4),(117.7,17.4),(117.7,20.15)],4.85)
 b.union(rear)
 # Straight insertion openings, subsequently closed by the yoke.
 b.cutbox(rear,'Charger PCB front-loading rebate',11.95,57.35,9.45,18.1,1.3,15)
 b.cutbox(rear,'Charger close USB opening',16.7,57.35,9.45,9.6,2.8,14.05)
 # SPDT flange receives a wide internal rebate, with a small exterior lever slot.
 b.cutbox(rear,'SPDT measured flange front-loading rebate',30.935,57.65,9.45,20.13,.95,16.8)
 b.cutbox(rear,'SPDT close travel slot',37.9,58.35,9.45,6.2,1.8,15.225)
 b.cutbox(rear,'DPDT body front-loading rebate',55.5,57.4,9.45,9,1.6,13.9)
 b.cutbox(rear,'DPDT fingernail travel slot',57.75,58.7,9.45,4.5,1.5,13.05)
 b.cutbox(rear,'DPDT exterior nail relief',57,59.5,19.8,6,.6,3.5)
 b.cutbox(rear,'XIAO PCB front-loading rebate',111.35,57.35,9.45,1.5,.65,20.1)
 b.cutbox(rear,'XIAO close USB slot',112.3,57.35,9.45,3.9,2.8,17.6)
 # Reset is loaded from the front into a U-shaped guide, then capped by the yoke.
 b.cutbox(rear,'Reset front-loading guide channel',114.9,54.4,9.45,5.2,3.2,5.25)
 # Yoke rebuilt without the old loose slider, thin legs or loose reset guide roof.
 yoke=b.component('06 Electronics retaining yoke','Front face down; broad roots; caps close insertion slots; same M3x8 screws')
 b.box(yoke,'Common yoke rail',11.1,36,9.4,101.2,3,2)
 for x in (35,103):b.box(yoke,'Yoke screw pad',x-4.2,33.8,9.4,8.4,8.4,2)
 for x in (11.1,27.8):b.box(yoke,'Charger broad keeper rail',x,31.5,9.4,3.5,25.9,2)
 for x in (12.25,28.55):
  for y in (32,54):b.box(yoke,'Charger keeper foot with 0.20 mm allowance',x,y,11.4,1.2,2,11.6)
 b.box(yoke,'Charger cap broad root',11.1,55.2,9.4,20.2,2.2,2)
 b.box(yoke,'Charger close USB roof',16.95,57.4,9.65,9.1,2.35,9.65)
 for x in (37.4,43.6):b.box(yoke,'SPDT broad keeper arm',x,37.5,9.4,2.4,20.15,2)
 for x in (37.4,44.6):b.box(yoke,'SPDT retaining pad 0.20 mm clearance',x,54,11.4,1.2,2.5,8.4)
 b.box(yoke,'SPDT roof broad root',37.4,53,9.4,8.4,4.7,2)
 b.box(yoke,'SPDT close lever roof',38.15,58.4,12.8,5.7,1.35,8.625)
 b.box(yoke,'SPDT roof joining web',37.4,53,11.3,8.4,5.55,3.5)
 # Preserve clearance to the original front bezel locating tongue.
 m.yz(yoke,'SPDT roof tongue clearance ramp',37.2,[(53.95,0),(60.1,0),(60.1,12.75),(57.3,12.75),(53.95,9.4)],8.8,True)
 for x in (53.5,63.1):b.box(yoke,'DPDT direct-actuator keeper arm',x,37,9.4,3.4,20.4,2)
 for x in (55.9,63.1):b.box(yoke,'DPDT retaining pad',x,56.2,11.4,1,2.1,8.4)
 b.box(yoke,'DPDT roof root',55.5,55.2,9.4,9,2.2,2)
 b.box(yoke,'DPDT direct-actuator roof',58,57.4,9.65,4,2.35,10.95)
 b.box(yoke,'XIAO broad keeper rail',108.5,38,9.4,3.8,19.4,2)
 for y in (40,50):
  b.box(yoke,'XIAO outer restraint root',111.8,y,9.4,3,2.4,2)
  b.box(yoke,'XIAO outer front restraint',112.8,y,11.35,2,2.4,2.5)
 b.box(yoke,'XIAO USB cap root',108.5,55.2,9.4,7.45,2.2,2)
 b.box(yoke,'XIAO close USB roof',112.55,57.4,9.65,3.4,2.35,7.8)
 b.box(yoke,'Reset broad cap root',112.8,53.55,9.65,6.95,4.85,2)
 b.box(yoke,'Reset deep upper guide',114.95,53.55,11.6,4.8,4.85,2.8)
 b.box(yoke,'Reset travel stop root',113.5,52.9,11.4,1.1,1.8,2.2)
 b.box(yoke,'Reset positive 0.45 mm inward stop',113.4,53.65,13.5,.55,1,3.1)
 b.union(yoke)
 for x in (35,103):b.cutcyl(yoke,'Yoke M3 clearance',x,38,9.38,3.6,2.04)
 b.cutcyl(yoke,'Upper optical screw driver access',60,54,9.38,6.4,2.04)
 # A chamfered-square section guides without twisting; rounded external cap.
 cy,cd=56,14.55
 def octagon(half,bevel):
  return [(cy-half,cd-half+bevel),(cy-half+bevel,cd-half),(cy+half-bevel,cd-half),(cy+half,cd-half+bevel),(cy+half,cd+half-bevel),(cy+half-bevel,cd+half),(cy-half+bevel,cd+half),(cy-half,cd+half-bevel)]
 for c in (rear,yoke):m.yz(c,'Reset keyed 3.2 mm guide - 0.20 mm each side',114.9,octagon(1.6,.55),5.2,True)
 # Trim cap zones clear of actual component bodies, independent of port silhouette.
 for c in (rear,yoke):
  b.cutbox(c,'DPDT body 0.20 mm running space',55.5,55.85,19.8,9,3.15,3.35)
  b.cutbox(c,'SPDT body 0.20 mm running space',35.5,53.15,19.8,11,5.45,6.25)
 # New captive reset button with internal flange and rounded finger surface.
 reset=b.component('07 Guided rounded reset button','Keyed stem; 5.05 mm guide; 0.45 mm inward travel; flat flange side down')
 m.yz(reset,'Reset keyed stem',114.75,octagon(1.4,.55),5.75)
 m.yz(reset,'Reset captive flange',114.4,[(53.9,12.45),(58.1,12.45),(58.1,16.65),(53.9,16.65)],.45)
 m.yz(reset,'Reset contact pad',114.25,[(55.4,13.95),(56.6,13.95),(56.6,15.15),(55.4,15.15)],.2)
 sk,_=m.plane_sketch(reset,'Round button face','x',120.35)
 center=sk.modelToSketchSpace(b.p(120.35,56,-14.55));sk.sketchCurves.sketchCircles.addByCenterRadius(center,.17)
 b.extrude(reset,sk,.35,'Rounded exterior button')
 b.union(reset)
 # Measured and explicit provisional component envelopes.
 c=b.component('REF Charger','Measured 28.1 x17.5; USB overhang 1.3; PCB thickness and USB section provisional')
 b.box(c,'Charger PCB',12.25,30.3,23.2,17.5,28.1,1)
 b.box(c,'Charger USB envelope',17,53.3,19.6,9,6.4,3.6)
 b.box(c,'Charger IC envelope',18,34.3,20.9,7,11,2.3);b.paint(c,'PCB green',(24,100,63))
 c=b.component('REF XIAO','Shifted 0.6 mm right and 1.3 mm top; supported solder-access frame')
 b.box(c,'XIAO PCB',111.6,36.8,11.55,1,21,17.8)
 b.box(c,'XIAO USB envelope',112.6,53.3,17.75,3.3,6.4,9)
 b.box(c,'XIAO component envelope',112.6,42.8,16,3,9,9)
 b.box(c,'XIAO reset target',112.6,55,13.65,1.5,2,1.8);b.paint(c,'PCB green',(24,100,63))
 c=b.component('REF DPDT','Original switch, moved 6.55 mm to expose actuator; no printed slider')
 b.box(c,'DPDT body',55.7,56.05,20,8.6,2.7,3.1)
 for x in (57,60,63):
  for dep in (20.4,22.2):b.box(c,'DPDT terminal',x-.2,53.05,dep,.4,3,.35)
 b.paint(c,'Connector steel',(155,165,175))
 c=b.component('REF DPDT moving actuator','1.42 square x1.83 high; 4 mm total slot, 2.58 mm travel')
 b.box(c,'DPDT fingernail actuator',59.29,58.75,20.84,1.42,1.83,1.42);b.paint(c,'Control PETG',(80,80,80))
 c=b.component('REF SPDT power switch','Measured body 10.6 x6 x5.05; flange 19.73; terminals 2.6')
 b.box(c,'SPDT main body',35.7,53.35,20,10.6,5.05,6)
 b.box(c,'SPDT flange',31.135,57.9,20,19.73,.5,6)
 for x in (37.5,41,44.5):b.box(c,'SPDT terminal',x-.6,50.75,22.7,1.2,2.6,.6)
 b.union(c);b.paint(c,'Connector steel',(155,165,175))
 c=b.component('REF SPDT moving lever','Measured 2.95 square, 5 high; 5.8 slot gives 2.85 mm travel')
 b.box(c,'SPDT lever',39.525,58.4,21.525,2.95,5,2.95);b.paint(c,'Control PETG',(80,80,80))
 params={'charger_pcb_width':17.5,'charger_pcb_length':28.1,'charger_usb_overhang':1.3,'charger_fit_per_side':.3,'spdt_body_length':10.6,'spdt_body_depth':6,'spdt_body_height':5.05,'spdt_flange_length':19.73,'spdt_knob_envelope':2.95,'spdt_travel':2.85,'spdt_fit_clearance':.2,'reset_guide_length':5.05,'reset_guide_per_side':.2,'reset_y':56,'reset_tip_x':114.25,'reset_stroke':.45,'xiao_shift_side':.6,'xiao_shift_top':1.3,'dpdt_actuator_exposed':.58}
 for name,val in params.items():
  p=d.userParameters.itemByName(name)
  if p:p.expression=str(val)+' mm'
  else:d.userParameters.add(name,b.vi(val),'mm','v2.3 measured fit revision; see change record')
 for c in (rear,yoke):b.union(c);b.paint(c)
 b.paint(reset,'Control PETG',(105,110,117))
 m.finish('v2.3 measured fits built')
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'measured-fit-initial.f3d')))
 print(json.dumps({'document':doc.name,'body_counts':{o.component.name:o.component.bRepBodies.count for o in root.occurrences}}))
