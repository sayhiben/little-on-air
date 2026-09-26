"""Second physical-fit revision; XY front view, positive depth rearward, mm."""
import adsk.core as C
import adsk.fusion as F
import importlib.util,math,json
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('mechanical24',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');tm=F.TemporaryBRepManager.get();root=b.root()
 # Preserve tested charger and POWER seats. Replace only DPDT and XIAO regions.
 regions=[(52.4,52,67.6,60.1),(107.45,33,120.1,60.1)]
 for x,y,xx,yy in regions:b.cutbox(rear,'Replace failed fit region',x,y,9.45,xx-x,yy-y,22.25)
 shell=b.component('REF temporary shell');b.rbox(shell,'Original rounded wall',0,0,9.5,120,60,24.5,3);b.cutbox(shell,'Original inside wall',2.4,2.4,9.45,115.2,55.2,22.25)
 for x,y,xx,yy in regions:
  box=tm.createBox(C.OrientedBoundingBox3D.create(b.p((x+xx)/2,(y+yy)/2,-20.6),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),(xx-x)/10,(yy-y)/10,22.2/10))
  body=tm.copy(shell.bRepBodies.item(0));assert tm.booleanOperation(body,box,F.BooleanTypes.IntersectionBooleanType)
  f=rear.features.baseFeatures.add();f.name='Continuous restored rounded corner';f.startEdit();rear.bRepBodies.add(body,f);f.finishEdit()
 next(o for o in root.occurrences if o.component==shell).deleteMe();b.union(rear)
 # DPDT: 9.1 X, 3.36 Y, 3.72 depth. Surface y58.85, actuator exposure 0.72.
 b.box(rear,'DPDT enlarged rear seat',55.1,55.14,24.02,9.8,3.96,7.68)
 for x in (52.6,64.9):b.box(rear,'DPDT 2.5 mm cheeks',x,54.9,19.7,2.5,3.95,12)
 # Lower stops touch the body sides only; six projecting terminals remain open.
 for x in (55.1,63.5):b.box(rear,'DPDT lower stops',x,53.65,20.8,1.4,1.49,10.9)
 b.union(rear)
 b.cutbox(rear,'DPDT front insertion rebate',55.1,57.35,9.45,9.8,1.8,14.57)
 b.cutbox(rear,'DPDT direct actuator opening',57.7,58.8,9.45,4.6,1.4,13.51)
 b.cutbox(rear,'DPDT fingernail relief',56.9,59.45,20.5,6.2,.7,2.72)
 # More clearance to the guide: XIAO 0.8 mm inboard from the second fit plate.
 xiao=b.comp('REF XIAO');move=C.Matrix3D.create();move.translation=C.Vector3D.create(-.08,0,0)
 inp=xiao.features.moveFeatures.createInput2(b.oc(list(xiao.bRepBodies)));inp.defineAsFreeMove(move);xiao.features.moveFeatures.add(inp)
 b.box(rear,'XIAO continuous inner frame',108.1,35,11.65,2.4,23,20.05)
 b.union(rear)
 for y,w in ((38.2,6.6),(47.3,7.9)):
  pts=[(y,27.2),(y+w,27.2),(y+w,16.5+w/2),(y+w/2,16.5),(y,16.5+w/2)]
  m.yz(rear,'XIAO self-supporting solder-access arch',108.05,pts,2.5,True)
 for y in (39,50):m.xz(rear,'XIAO frame buttress',y,[(105.7,31.7),(108.15,31.7),(108.15,26)],2.4)
 b.box(rear,'XIAO outer rear restraint',112.0,36.55,27.7,4.1,21.45,4)
 b.box(rear,'XIAO rear depth stop',110.5,36.55,29.6,5.6,21.45,2.1)
 b.box(rear,'XIAO fixed lower stop for straight insertion',110.5,34.3,11.65,1.5,2.25,20.05)
 b.box(rear,'XIAO upper axial stop',110.5,58,11.65,1.5,.7,20.05)
 # The complete button bearing is within this thick wall, outside the USB envelope.
 b.box(rear,'Continuous 4 mm corner and button wall',116,34.5,9.5,1.8,23.1,22.2)
 b.union(rear)
 b.cutbox(rear,'XIAO PCB top entry',110.5,57.35,9.45,1.55,.65,20.15)
 b.cutbox(rear,'XIAO measured top USB opening',111.5,57.35,9.45,3.77,2.8,17.57)
 # Conservatively clear connector tabs/solder inside the shell, without enlarging its outer port.
 b.cutbox(rear,'XIAO USB interior assembly envelope',111.55,52.65,16.85,3.95,4.7,10.6)
 def octa(half,bevel,cy=56,cd=14.55):
  return [(cy-half,cd-half+bevel),(cy-half+bevel,cd-half),(cy+half-bevel,cd-half),(cy+half,cd-half+bevel),(cy+half,cd+half-bevel),(cy+half-bevel,cd+half),(cy-half+bevel,cd+half),(cy-half,cd+half-bevel)]
 m.yz(rear,'Closed keyed reset bearing in strong corner',115.95,octa(1.6,.55),4.2,True)
 # Widen only the outside of the already successful POWER cheeks.
 for x in (33.0,48.1):b.box(rear,'POWER cheek outside reinforcement',x,52.9,19.8,.9,4.45,11.9)
 b.union(rear)
 # Three 8 x 2.4 mm diagonal capsule vents per side, below the electronics corner.
 for x in (-.1,117.45):
  for cy in (15,23,31):
   u=(math.sqrt(.5),math.sqrt(.5));v=(-u[1],u[0]);pts=[]
   for sign,angles in [(1,range(-90,91,12)),(-1,range(90,271,12))]:
    for angle in angles:
     a=math.radians(angle);pts.append((cy+sign*2.8*u[0]+1.2*(math.cos(a)*u[0]+math.sin(a)*v[0]),21+sign*2.8*u[1]+1.2*(math.cos(a)*u[1]+math.sin(a)*v[1])))
   m.yz(rear,'Angled pill vent 8 x 2.4',x,pts,2.65,True)
 # Rebuild the yoke with broad rails, thicker roots and larger keeper posts.
 yoke=b.component('06 Electronics retaining yoke','3 mm main frame; broad posts; removable roofs; same M3x8 screws')
 b.box(yoke,'Stiff common rail',11.1,35,9.4,99.4,4.4,3)
 for x in (35,103):b.box(yoke,'3 mm screw pads',x-4.2,33.8,9.4,8.4,8.4,3)
 for x in (10.95,27.25):b.box(yoke,'Wide charger frame',x,30.5,9.4,4.0,26.9,3)
 for x in (12.25,27.35):
  for y in (32,53.5):
   b.box(yoke,'Charger 2.4 by 3 keeper',x,y,12.35,2.4,3,10.65)
   m.xz(yoke,'Charger keeper flared root',y,[(x-.6,12.35),(x+3,12.35),(x+2.4,14.75),(x,14.75)],3)
 b.box(yoke,'Charger roof full crossbar',10.95,54.7,9.4,20.3,2.7,3)
 b.box(yoke,'Preserved charger close USB roof',16.95,57.4,9.65,9.1,2.35,10.15)
 for x in (37,43.4):b.box(yoke,'POWER broad retaining arm',x,37.5,9.4,3.2,20.1,3)
 for x in (37.4,43.4):b.box(yoke,'POWER robust keeper post',x,54,12.35,2.4,2.5,7.45)
 b.box(yoke,'POWER roof root',37,52.7,9.4,9.6,5,3)
 b.box(yoke,'Preserved POWER lever roof',38.15,58.4,12.8,5.7,1.35,8.425)
 b.box(yoke,'POWER roof connecting web',37.4,53,11.3,8.4,5.55,3.5)
 b.union(yoke);m.yz(yoke,'POWER front locating tongue clearance',36.9,[(53.95,0),(60.1,0),(60.1,12.75),(57.3,12.75),(53.95,9.4)],9.9,True)
 for x in (53,63.9):b.box(yoke,'DPDT broad retaining arm',x,37,9.4,3.5,20.4,3)
 for x in (55.45,62.15):b.box(yoke,'DPDT robust keeper',x,55.7,12.35,2.4,2.8,7.35)
 b.box(yoke,'DPDT roof crossbar',53,54.7,9.4,14.4,2.7,3)
 b.box(yoke,'DPDT close actuator roof',57.95,57.4,9.65,4.1,2.35,10.81)
 b.box(yoke,'XIAO stiff side rail',107.5,38,9.4,3,19.4,3)
 for y in (40,49):
  b.box(yoke,'XIAO broad front retaining tab',109.8,y,9.4,4.5,3.2,1.9)
  b.box(yoke,'XIAO stout outer restraint',112,y,11.25,2.3,3.2,2.5)
 b.box(yoke,'XIAO USB cap crossbar',107.5,55.2,9.4,7.65,2.2,2.65)
 b.box(yoke,'XIAO measured USB roof',111.75,57.4,9.65,3.27,2.35,7.8)
 b.box(yoke,'Reset inward stop crossbar',109.8,51.7,9.4,5.7,2.6,2.65)
 b.box(yoke,'Reset positive stop with broad root',113.6,51.7,11.3,1.35,2.55,5.2)
 b.union(yoke)
 b.cutbox(yoke,'XIAO PCB clearance through cap root',110.5,55.15,11.3,1.55,2.85,18.3)
 b.cutbox(yoke,'XIAO USB interior assembly envelope',111.55,52.65,16.85,3.95,4.7,10.6)
 # Body spaces remain free; keeper tips terminate 0.30 mm in front of DPDT body.
 b.cutbox(yoke,'DPDT measured body clearance',55.1,55.14,19.7,9.8,4.01,4.32)
 b.cutbox(yoke,'POWER preserved body clearance',35.5,53.15,19.8,11,5.45,6.25)
 for x in (35,103):b.cutcyl(yoke,'M3 yoke clearance',x,38,9.38,3.6,3.04)
 b.cutcyl(yoke,'Optical screw driver clearance',60,54,9.38,6.4,3.04)
 # Insert this captive button from inside before the XIAO. Its rounded tip fits through the guide.
 reset=b.component('07 Guided rounded reset button','Insert from inside before XIAO; flange captive in wall; 0.45 mm travel')
 m.yz(reset,'Keyed stem',115.9,octa(1.4,.55),4.55)
 m.yz(reset,'Strong internal captive flange',115.4,[(53.9,12.45),(58.1,12.45),(58.1,16.65),(53.9,16.65)],.6)
 m.yz(reset,'Reset contact neck',113.45,[(55.4,13.95),(56.6,13.95),(56.6,15.15),(55.4,15.15)],2.05)
 sk,_=m.plane_sketch(reset,'Rounded finger end','x',120.3);sk.sketchCurves.sketchCircles.addByCenterRadius(sk.modelToSketchSpace(b.p(120.3,56,-14.55)),.14);b.extrude(reset,sk,.15,'Rounded finger face')
 b.union(reset)
 c=b.component('REF DPDT','Measured 9.1 x3.72 x3.36 mm; six edge legs project 3.25 mm')
 b.box(c,'Measured DPDT body',55.45,55.49,20,9.1,3.36,3.72)
 for x in (56.15,60,63.85):
  for dep in (20.0,23.37):b.box(c,'DPDT terminal envelope',x-.25,52.24,dep,.5,3.25,.35)
 b.paint(c,'Connector steel',(155,165,175))
 c=b.component('REF DPDT moving actuator','1.5 square x1.87 high; 3.9 total slot gives 2.4 mm travel')
 b.box(c,'Direct MODE actuator',59.25,58.85,21.11,1.5,1.87,1.5);b.paint(c,'Control PETG',(80,80,80))
 params={'switch_w':9.1,'switch_h':3.72,'switch_t':3.36,'switch_throw':2.4,'actuator_w':1.5,'actuator_d':1.5,'actuator_h':1.87,'dpdt_actuator_exposed':.72,'dpdt_fit_per_side':.35,'reset_tip_x':113.45,'reset_guide_length':4,'reset_stroke':.45,'xiao_shift_side':-.2,'yoke_main_thickness':3,'side_vent_length':8,'side_vent_width':2.4}
 for name,val in params.items():
  p=b.design().userParameters.itemByName(name)
  if p:p.expression=str(val)+' mm'
  else:b.design().userParameters.add(name,b.vi(val),'mm','v2.4 second physical-fit revision')
 for c in (rear,yoke):b.union(c);b.paint(c)
 b.paint(reset,'Control PETG',(105,110,117));m.finish('v2.4 robust frame, clear USB, measured DPDT, side vents')
 assert b.design().exportManager.execute(b.design().exportManager.createFusionArchiveExportOptions(str(m.OUT/'revision-built.f3d')))
 print(json.dumps({'parts':{o.component.name:o.component.bRepBodies.count for o in root.occurrences}}))
