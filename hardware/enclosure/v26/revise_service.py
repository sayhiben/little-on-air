"""Native v2.6 changes. All geometry in mm, front-view XY, depth=-Z."""
import adsk.core as C
import adsk.fusion as F
import importlib.util,math,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
def run(_context:str):
 s=importlib.util.spec_from_file_location('m26',str(HERE/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke');front=b.comp('01 Front optical bezel')
 # One purchased fastener: M3x8 button head, head envelope 5.7 dia x1.65.
 for x,y in m.FAST:
  b.box(rear,'Fill obsolete deep closure nut access',x-4.2,y-4.2,24.55,8.4,8.4,3.1)
 b.union(rear)
 for i,(x,y) in enumerate(m.FAST):
  b.cutcyl(front,'Deeper common M3x8 head bearing',x,y,-.02,6.8,5.22)
  # Pocket starts .5 mm behind the mating face; remaining front roof1.0mm.
  if i==2:
   sk=b.sketch(rear,'Upper-left inward nut hex',10.5);r=6/math.sqrt(3)
   b.polygon(sk,[(x+r*math.cos(math.pi/2+j*math.pi/3),y+r*math.sin(math.pi/2+j*math.pi/3)) for j in range(6)])
   b.extrude(rear,sk,-3,'Common screw nut pocket',F.FeatureOperations.CutFeatureOperation)
   b.cutbox(rear,'Upper-left nut loading from below',x-3,y-4.5,10.5,6,4.5,3)
  else:
   m.hexcut(rear,'Forward closure nut pocket',x,y,10.5,3,6)
   b.cutbox(rear,'Forward closure nut entry',x if x<60 else x-4.5,y-3,10.5,4.5,6,3)
  b.cutcyl(rear,'M3x8 closure bore',x,y,9.48,3.6,4.72)
 for y in (6,54):b.cutcyl(front,'M3x8 optical screw tip relief',60,y,.65,3.6,7.2)
 # DPDT: 9.5 wide pocket (.2/side); .15 total front/rear clearance.
 for x in (54.95,64.75):b.box(rear,'Tighter MODE lateral faces',x,55.14,19.7,.3,3.71,12)
 b.box(rear,'MODE seat moved forward .20',55.25,55.14,23.82,9.5,3.96,7.88)
 for x in (55.45,62.05):b.box(yoke,'MODE keeper closes measured looseness',x,55.85,19.6,2.5,1.9,.35)
 b.union(rear);b.union(yoke)
 for name in ('REF DPDT','REF DPDT moving actuator'):
  c=b.comp(name);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,-.01)
  inp=c.features.moveFeatures.createInput2(b.oc(list(c.bRepBodies)));inp.defineAsFreeMove(mat);c.features.moveFeatures.add(inp)
 # Flip charger around board center, keeping its PCB footprint and thickness.
 ch=b.comp('REF Charger');mat=C.Matrix3D.create();mat.setToRotation(math.pi,C.Vector3D.create(0,1,0),b.p(21,0,-23.7))
 inp=ch.features.moveFeatures.createInput2(b.oc(list(ch.bRepBodies)));inp.defineAsFreeMove(mat);ch.features.moveFeatures.add(inp)
 # Existing PCB corner seats stay at d24.2. Clear all populated-side components.
 b.box(rear,'Restore old charger top opening',16.6,57.35,9.5,9.9,2.65,18.5);b.union(rear)
 b.cutbox(rear,'Flipped charger USB exterior opening',15.775,57.35,9.48,9.45,2.8,18.12)
 b.box(yoke,'Flipped charger flat print-face roof',15.775,57.35,9.65,9.45,2.4,14.25);b.union(yoke)
 for c in (rear,yoke):
  b.cutbox(c,'Flipped charger socket and solder clearance',15.775,52.95,23.9,9.45,7.2,3.7)
  b.cutbox(c,'Flipped charger middle components clearance',16.7,34,24.19,8.6,17.5,4.3)
 # User measured right edge viewed from SMD face -> left in front-view after flip.
 for y in (49.4,44.65):
  b.cutcyl(rear,'Charger rear indicator aperture',14,y,24.5,3.2,9.7)
  b.box(ch,'Measured charger indicator',13.4,y-.8,24.2,1.2,1.6,.8)
 # Remove old continuous XIAO pad-edge obstruction, leaving screw boss intact.
 b.cutbox(rear,'Clear old XIAO long-edge cage',107.2,34.1,9.48,8.8,23.25,22.22)
 b.cutbox(rear,'Clear old inboard upper gusset',105.7,42.3,9.48,1.5,15.05,22.22)
 b.box(rear,'Restore old XIAO top port and stop region',107.2,57.35,9.5,8.8,2.65,22.2);b.union(rear)
 # Board moves2mm inward in X. Center spine leaves both pad rows free.
 b.box(rear,'Broad XIAO back-face spine',106.1,35,16.5,2.4,23.2,15.2)
 for yy in (38.5,49.5):m.xz(rear,'XIAO thick 45-degree spine gusset',yy,[(103.7,31.7),(106.15,29.25),(106.15,31.7)],3)
 for yy in (36.8,56.4):
  b.box(rear,'XIAO end-only outer cheek',110.25,yy,26.7,3.5,1.4,5)
  b.box(rear,'XIAO end-only rear depth stop',108.5,yy,29.6,5.25,1.4,2.1)
 b.union(rear)
 b.cutbox(rear,'XIAO PCB free seated and slide envelope',108.5,28.55,11.3,1.75,29.55,18.3)
 b.cutbox(rear,'Inward XIAO USB opening',109.7,57.35,9.48,3.77,2.8,15.755)
 b.cutbox(rear,'Inward XIAO USB internal clearance',109.75,44.85,9.48,3.72,12.5,15.755)
 # Retainer supports only the short ends. The outer long rail is removed wholesale.
 b.cutbox(yoke,'Open full length of front XIAO pad row',107.2,38.2,9.63,8.8,17.2,22.1)
 b.cutbox(yoke,'Remove old XIAO front keeper locations',108.45,34.05,11.3,5.3,24.25,4.5)
 b.box(yoke,'Wide XIAO lower end crossbar',103,34.1,9.65,7.25,4.1,1.65)
 b.box(yoke,'Wide XIAO upper end crossbar',103.5,55.4,9.65,6.75,2.7,1.65)
 b.box(yoke,'XIAO removable lower axial stop',108.5,34.1,11.3,1.75,2.45,3.1)
 b.box(yoke,'Shifted XIAO USB front roof',109.7,57.35,9.65,3.77,2.4,6.015)
 b.union(yoke)
 for c in (rear,yoke):b.cutbox(c,'Inward USB seated connector tab clearance',109.75,52.85,15.665,3.72,4.5,9.57)
 b.cutbox(yoke,'Shifted XIAO USB top roof bounds',109.7,57.35,15.665,3.77,2.8,9.57)
 # Top PCB axial stop and body face allowance; preserve closed reset bearing.
 b.cutbox(rear,'XIAO PCB upper seated clearance',108.5,57.35,11.3,1.75,.75,18.3)
 b.cutbox(rear,'Preserve extended reset loading access',101.5,53.65,9.45,14.49,4.7,6.3)
 xiao=b.comp('REF XIAO');mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(-.2,0,0)
 inp=xiao.features.moveFeatures.createInput2(b.oc(list(xiao.bRepBodies)));inp.defineAsFreeMove(mat);xiao.features.moveFeatures.add(inp)
 reset=b.comp('07 Guided rounded reset button')
 b.box(reset,'Reset contact extension for inward board',110.7,54.6,13.75,2.1,2.8,1.6);b.union(reset)
 # RGB position derived from Seeed KiCad v1.2: LED2.794fromUSB end,3.175fromfar edge.
 rgb_y=55.006;rgb_d=26.155
 b.box(xiao,'RGB6 status LED manufacturer position',110,rgb_y-.5,rgb_d-.5,.6,1,1)
 # Five-sided sight aperture with45deg printable roof; wall thickness stays unchanged.
 m.yz(rear,'RGB status sight aperture with printable roof',110.65,[(rgb_y-1.7,rgb_d+1.7),(rgb_y+1.7,rgb_d+1.7),(rgb_y+1.7,rgb_d),(rgb_y,rgb_d-1.7),(rgb_y-1.7,rgb_d)],9.55,True)
 # Exact common hardware envelopes; separate bodies avoid own-part thread overlap.
 nuts=b.component('REF M3 nuts','Eight ordinary M3 nuts AF5.5 x2.4; all screws M3x8 button head')
 screws=b.component('REF M3 screws','Eight M3x8 button heads; shaft8, head5.7 dia x1.65')
 entries=[(x,y,10.6,5.2,1,i==2,'Closure screw') for i,(x,y) in enumerate(m.FAST)]
 entries += [(60,y,3.3,9.075,-1,False,'Optical screw') for y in (6,54)]
 entries += [(x,38,13.9,9.65,1,False,'Yoke screw') for x in (35,103)]
 hardware=[]
 for x,y,nd,bearing,sign,rot,label in entries:
  sk=b.sketch(nuts,'M3 nut profile',nd);r=5.5/math.sqrt(3);a=math.pi/2 if rot else 0
  b.polygon(sk,[(x+r*math.cos(a+i*math.pi/3),y+r*math.sin(a+i*math.pi/3)) for i in range(6)])
  b.extrude(nuts,sk,-2.4,'M3 nut')
  b.cutcyl(nuts,'Nut threaded bore envelope',x,y,nd-.01,3,2.42)
  b.cyl(screws,label+' shaft',x,y,bearing if sign==1 else bearing-8,3,8)
  b.cyl(screws,label+' head',x,y,bearing-1.65 if sign==1 else bearing,5.7,1.65)
  hardware.append({'type':label,'xy':[x,y],'bearing_depth':bearing,'nut_depth':[nd,nd+2.4],'shaft_depth':[bearing,bearing+sign*8]})
 for c in (rear,yoke,front,reset):b.union(c);b.paint(c)
 for name,value in {'common_screw_length':8,'closure_head_bearing':5.2,'closure_nut_front':10.5,'xiao_inward_shift':2,'xiao_rgb_y':rgb_y,'xiao_rgb_depth':rgb_d,'dpdt_pocket_width':9.5,'dpdt_retained_gap':.15,'reset_tip_x':110.7}.items():
  p=b.design().userParameters.itemByName(name)
  if p:p.expression=str(value)+' mm'
  else:b.design().userParameters.add(name,b.vi(value),'mm','v2.6 service revision')
 # Empty cuts are harmless but remove them to retain a healthy export timeline.
 bad=[]
 for i in range(b.design().timeline.count):
  e=b.design().timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:bad.append(e)
 for e in bad:
  if 'No target body' in e.errorOrWarningMessage:e.deleteMe()
  else:raise RuntimeError(e.name+': '+e.errorOrWarningMessage)
 (m.OUT/'hardware-layout.json').write_text(json.dumps(hardware,indent=2))
 m.finish('v2.6 common screws, flipped charger, RGB sight and open pad edges')
 assert b.design().exportManager.execute(b.design().exportManager.createFusionArchiveExportOptions(str(m.OUT/'service-revised.f3d')))
