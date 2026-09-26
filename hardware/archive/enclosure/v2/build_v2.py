"""Native Fusion v2. Coordinates are front-view XY, depth = -Z, mm."""
import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
import json, math, re

HERE=Path(__file__).resolve().parent
BASE=HERE.parent
OUT=BASE/'output'/'v2'
spec=importlib.util.spec_from_file_location('loa_v1_helpers',str(BASE/'build_enclosure.py'))
b=importlib.util.module_from_spec(spec);spec.loader.exec_module(b)
b.OUT=OUT
OP=F.FeatureOperations
FAST=[(6,6),(114,6),(6,54),(96,54)]
P={
 'case_w':(120,'Front width'),'case_h':(60,'Front height'),'case_d':(34,'Rear wiring margin included'),
 'wall':(2.4,'Structural shell wall'),'front_lip':(1.6,'Front optical lip'),
 'front_depth':(9.5,'Main front/rear seam'),'acrylic_t':(3.175,'Nominal Amazon 1/8 inch; measure actual sheet'),
 'panel_w':(104,'Shared optical outline'),'panel_h':(38,'Shared optical outline'),
 'air_gap':(0.5,'Rear engraving to white letter tips'),'backing_base':(1.6,'Black printed base'),
 'letter_relief':(0.4,'White letters above black base'),'tray_t':(1.6,'Optical retainer thickness'),
 'fit':(.25,'Nominal mating clearance per side'),'m3_hole':(3.4,'M3 clearance'),
 'nut_af':(5.8,'Ordinary M3 nut trap'),'head_d':(6.4,'M3 socket-head counterbore'),'head_depth':(3.2,'Front bearing plane'),
 'led_w':(8,'Separated LED module'),'led_h':(8,'Separated LED module'),'led_t':(2,'LED module thickness'),
 'led_optical_offset':(1,'Unmeasured emitter center from module front'),'text_h':(18,'Reference text height'),
 'switch_w':(8.6,'DPDT case'),'switch_h':(3.1,'DPDT case depth'),'switch_t':(2.7,'DPDT case front-to-actuator axis'),
 'switch_throw':(2.58,'Confirmed: 4 mm opening minus 1.42 mm actuator width'),
 'actuator_w':(1.42,'Confirmed actuator width'),'actuator_d':(1.42,'Confirmed actuator thickness'),
 'actuator_h':(1.83,'Updated reported actuator height'),
 'reset_y':(54.7,'Provisional XIAO reset center'),'reset_depth':(14.55,'Provisional XIAO reset center'),
 'reset_tip_x':(113.7,'Contact tip; 0.2 mm free play to reference button'),'reset_stroke':(.5,'0.2 free play + 0.3 actuation allowance'),
}

def dims():
 a=b.param('front_lip'); ar=a+b.param('acrylic_t'); bf=ar+b.param('air_gap')+b.param('letter_relief'); br=bf+b.param('backing_base')
 return a,ar,bf,br,br+.2,br+.2+b.param('tray_t')

def finish(stage):
 b.root().isOriginFolderLightBulbOn=False
 for occ in b.root().occurrences:
  for sk in occ.component.sketches:sk.isVisible=False
  occ.component.isConstructionFolderLightBulbOn=False
  occ.component.isOriginFolderLightBulbOn=False
 OUT.mkdir(parents=True,exist_ok=True)
 (OUT/'progress.json').write_text(json.dumps({'stage':stage,'components':b.root().occurrences.count,'timeline':b.design().timeline.count}))
 print(json.dumps({'stage':stage,'components':b.root().occurrences.count}))

def plane_sketch(c,name,axis,value):
 base={'x':c.yZConstructionPlane,'y':c.xZConstructionPlane,'z':c.xYConstructionPlane}[axis]
 normal=base.geometry.normal.asArray()[{'x':0,'y':1,'z':2}[axis]]
 if abs(value)<1e-8: pl=base
 else:
  inp=c.constructionPlanes.createInput();inp.setByOffset(base,b.vi(value/normal));pl=c.constructionPlanes.add(inp);pl.isLightBulbOn=False
 return c.sketches.add(pl),normal

def profile3(c,name,axis,value,points):
 sk,n=plane_sketch(c,name,axis,value);sk.name=name
 local=[sk.modelToSketchSpace(b.p(*v)) for v in points]
 for i,v in enumerate(local):sk.sketchCurves.sketchLines.addByTwoPoints(v,local[(i+1)%len(local)])
 return sk,n

def prism(c,name,axis,value,points,length,cut=False):
 sk,n=profile3(c,name,axis,value,points)
 return b.extrude(c,sk,length/n,name,OP.CutFeatureOperation if cut else OP.NewBodyFeatureOperation)

def xz(c,name,y,points,length,cut=False):
 return prism(c,name,'y',y,[(x,y,-d) for x,d in points],length,cut)

def yz(c,name,x,points,length,cut=False):
 return prism(c,name,'x',x,[(x,y,-d) for y,d in points],length,cut)

def hexcut(c,name,x,y,d,t,af=5.8):
 sk=b.sketch(c,name,d);r=af/math.sqrt(3)
 b.polygon(sk,[(x+r*math.cos(i*math.pi/3),y+r*math.sin(i*math.pi/3)) for i in range(6)])
 return b.extrude(c,sk,-t,name,OP.CutFeatureOperation)

def nutboss(c,name,x,y,front,back,nutfront,boreend,side=1):
 b.box(c,name,x-4.2,y-4.2,front,8.4,8.4,back-front)
 b.union(c)
 hexcut(c,name+' hex pocket',x,y,nutfront,2.6)
 b.cutbox(c,name+' side nut entry',x if side>0 else x-4.5,y-2.9,nutfront,4.5,5.8,2.6)
 b.cutcyl(c,name+' blind bore',x,y,front-.02,3.4,boreend-front+.02)

def setup():
 app=C.Application.get();doc=app.documents.add(C.DocumentTypes.FusionDesignDocumentType);doc.name='Little On Air - Enclosure v2'
 d=F.Design.cast(app.activeProduct);d.designType=F.DesignTypes.ParametricDesignType;d.unitsManager.distanceDisplayUnits=F.DistanceUnits.MillimeterDistanceUnits
 for name,(value,note) in P.items():d.userParameters.add(name,b.vi(value),'mm',note)
 d.rootComponent.attributes.add('LittleOnAirV2','Revision','2.0 - integrated rear housing')
 finish('setup')

def front():
 a,ar,bf,br,rf,rb=dims()
 c=b.component('01 Front optical bezel','Front face down; removable optics; shared left/bottom datums')
 b.rbox(c,'Front bezel envelope',0,0,0,120,60,9.5,3)
 b.cutbox(c,'Rear open cavity',2.4,2.4,a,115.2,55.2,8.0)
 b.cutbox(c,'Visible optical window',10,13,-.02,100,34,a+.04)
 for x,y in FAST:
  b.box(c,'Front compression seat',x-4.2,y-4.2,1.5,8.4,8.4,8.0)
 b.union(c)
 for x,y in FAST:
  b.cutcyl(c,'M3 through clearance',x,y,-.02,3.4,9.6)
  b.cutcyl(c,'Recessed socket head',x,y,-.02,6.4,3.22)
 for x in (40,80):
  lead=a+b.param('acrylic_t')/2-b.param('led_optical_offset')
  for y in (6.8,53.2):
   b.box(c,'LED floor',x-4.3,y-4.4,1.5,8.6,8.8,lead-1.5)
   for xx in (x-5.5,x+4.25):b.box(c,'LED lateral guide',xx,y-4.4,1.5,1.25,8.8,3.0)
 # No projecting shelves above the acrylic: straight rear insertion stays open.
 for y in (20,35):b.box(c,'Shared left datum',6.5,y,1.5,1.5,6,br-1.5)
 for x in (22,94):b.box(c,'Shared lower datum',x,9.5,1.5,6,1.5,br-1.5)
 for y in (20,35):b.box(c,'Right compliant pad wall',112.5,y,1.5,1.6,6,br-1.5)
 for x in (22,94):b.box(c,'Upper compliant pad wall',x,49.5,1.5,6,1.6,br-1.5)
 # Front/back alignment tabs, away from controls and optical insertion.
 for x in (2.3,116.15):b.box(c,'Side tongue root',x,17,9.1,1.55,9,.4)
 for x in (2.65,116.15):b.box(c,'Side locating tongue',x,17,9.3,1.2,9,1.7)
 b.box(c,'Upper tongue root',36,56.15,9.1,10,1.55,.4)
 b.box(c,'Upper locating tongue',36,56.15,9.3,10,1.2,1.7)
 b.union(c)
 for x,y in ((60,6),(60,54)):
  b.box(c,'Optical clamp boss',x-4.2,y-4.2,1.5,8.4,8.4,rf-1.5)
 b.union(c)
 for x,y in ((60,6),(60,54)):
  hexcut(c,'Optical M3 nut trap',x,y,3.2,2.6)
  b.cutbox(c,'Optical nut side entry',60,y-2.9,3.2,4.5,5.8,2.6)
  b.cutcyl(c,'Optical blind screw bore',x,y,2.6,3.4,rf-2.6+.02)
 # Keep LED light entry and sideways solder-wire routing clear.
 for x in (40,80):
  for y in (10.75,48.8):b.cutbox(c,'Acrylic edge admission',x-5.6,y,1.6,11.2,.45,3.7)
 b.paint(c);finish('front')

def inside(pt,poly):
 x,y=pt;hit=False
 for i,(ax,ay) in enumerate(poly):
  bx,by=poly[(i+1)%len(poly)]
  if (ay>y)!=(by>y) and x<(bx-ax)*(y-ay)/(by-ay)+ax:hit=not hit
 return hit

def optics():
 a,ar,bf,br,rf,rb=dims()
 master=json.loads((BASE/'output'/'laser'/'master-contours.json').read_text());loops=master['loops']
 c=b.component('02 Clear acrylic','Laser only; rear-engrave mirrored shared vector master')
 sk=b.sketch(c,'Keyed acrylic outline',a);b.keyed(sk);b.extrude(c,sk,-b.param('acrylic_t'),'Clear acrylic sheet')
 b.paint(c,'Clear acrylic',None);c.opacity=.24
 # These explicit polylines are also used for the printed letters and SVG.
 sk=b.sketch(c,'Rear engraving master - manufacturing sketch',ar)
 for loop in loops:b.polygon(sk,loop)
 c=b.component('03 Registered graphic backing','1.6 mm black; 0.4 mm white letters; integral hidden spacer pads')
 sk=b.sketch(c,'Keyed graphic outline',bf);b.keyed(sk);b.extrude(c,sk,-1.6,'Black substrate')
 for i,loop in enumerate(loops):
  if sum(inside(loop[0],other) for j,other in enumerate(loops) if j!=i)%2==0:
   sk=b.sketch(c,'Letter outer '+str(i),bf);b.polygon(sk,loop);b.extrude(c,sk,.4,'Raised letter '+str(i))
 b.union(c)
 for i,loop in enumerate(loops):
  if sum(inside(loop[0],other) for j,other in enumerate(loops) if j!=i)%2:
   sk=b.sketch(c,'Letter counter '+str(i),bf-.4);b.polygon(sk,loop);b.extrude(c,sk,-.4,'Letter counter '+str(i),OP.CutFeatureOperation)
 for x in (8.3,110.3):
  for y in (20,35):b.box(c,'Hidden acrylic spacing pad',x,y,ar,1.4,6,bf-ar)
 for y in (11.3,47.3):
  for x in (22,38,78,94):b.box(c,'Hidden acrylic spacing pad',x,y,ar,6,1.4,bf-ar)
 b.union(c);b.paint(c)
 white=b.appearance('White PETG',(244,245,240))
 for face in c.bRepBodies.item(0).faces:
  if face.boundingBox.maxPoint.z*10 > -bf+.001:face.appearance=white
 c=b.component('04 Optical retainer','Flat frame down, LED pads up; no electronics mounts')
 b.box(c,'Perimeter retainer',8,11,rf,104,38,1.6)
 b.cutbox(c,'Open retainer center',11,14,rf-.02,98,32,1.64)
 for y in (3,47):b.box(c,'Optical screw ear',55.8,y,rf,8.4,10,1.6)
 for x in (40,80):
  for y in (5.2,48.8):b.box(c,'LED pad connection',x-1.5,y,rf,3,6.0,1.6)
  for y in (5.2,49.2):b.box(c,'LED hold-down pad',x-1.5,y,4.35,3,5.6,rf-4.35)
 b.union(c)
 for y in (6,54):b.cutcyl(c,'Optical M3 clearance',60,y,rf-.02,3.4,1.64)
 b.paint(c)
 # Optional laminate stack: .5 front spacer + 1.6 laminate + .4 rear shim.
 for number,name,depth,thick in ((81,'Laminate front spacer',ar,.5),(82,'Laminate rear shim',br-.4,.4)):
  c=b.component(f'{number} {name}','Optional 1.6 mm laminate only; omit with printed backing; print 0.1 mm layers')
  sk=b.sketch(c,name,depth);b.keyed(sk);b.extrude(c,sk,-thick,name)
  sk=b.sketch(c,'Inset keyed border opening',depth-.01);b.polygon(sk,[(9.5,12.5),(110.5,12.5),(110.5,47.5),(11.62132,47.5),(9.5,45.37868)])
  b.extrude(c,sk,-(thick+.02),'Hidden keyed border opening',OP.CutFeatureOperation)
  b.paint(c)
  for o in b.root().occurrences:
   if o.component==c:o.isLightBulbOn=False
 finish('optics')

def rear():
 c=b.component('05 Rear electronics housing','Rear face down; integral nests, ports, controls and blind M3 bosses')
 b.rbox(c,'Rear housing envelope',0,0,9.5,120,60,24.5,3)
 b.cutbox(c,'Front open electronics cavity',2.4,2.4,9.48,115.2,55.2,22.12)
 for x,y in FAST:nutboss(c,'Closure boss',x,y,9.5,31.7,24.8,29.2,1 if x<60 else -1)
 # Battery cradle; no central panel in front of the electronics.
 for x,y,w,h in ((32.4,8.4,57.2,1.6),(32.4,10,1.6,23),(88,10,1.6,17),(34,33,40,1.6)):
  b.box(c,'Battery fence',x,y,27.1,w,h,4.6)
 b.box(c,'Battery bed',34,10,31.3,54,23,.4)
 b.box(c,'Battery fence corner union',32.4,32.9,27.1,1.7,1.7,4.6)
 for x in (28.4,90.0):
  b.box(c,'Raised strap lug',x,18,25.2,4,7,6.5)
 b.union(c)
 for x in (28.4,90.0):
  yz(c,'Strap slot with tent roof',x-.1,[(20,30.4),(23,30.4),(23,28.8),(21.5,27.3),(20,28.8)],4.2,True)
 # Charger, component face forward, board d23.2..24.2.
 for x,y in ((13.1,34),(26.9,34),(13.1,51),(26.9,51)):b.box(c,'Charger PCB seat',x,y,24.2,2,2,7.5)
 for x in (10.65,29.5):b.box(c,'Charger side fence',x,31,22.0,1.85,25,9.7)
 b.box(c,'Charger insertion stop',12.5,30.4,22.0,17,1.35,9.7)
 for x in (12.5,28.5):b.box(c,'Charger extraction stop',x,57.25,22,2,1.0,9.7)
 # XIAO spine and rear edge channel. Board remains front-insertable.
 b.box(c,'XIAO inner spine',108.9,35.2,11.4,1.85,21.6,20.3)
 b.box(c,'XIAO rear outer cheek',112.25,35.2,27.65,1.5,21.6,4.05)
 b.box(c,'XIAO rear depth stop',110.7,35.2,29.6,3.05,21.6,2.1)
 b.box(c,'XIAO lower axial stop',110.75,34.0,11.4,1.5,1.25,20.3)
 b.box(c,'XIAO upper axial stop',110.75,56.75,11.4,1.0,1.15,20.3)
 # DPDT nest: body is x55.7..64.3, y49.5..52.2, d20..23.1.
 b.box(c,'DPDT rear seat',55.45,49.25,23.1,9.1,3.2,8.6)
 for x in (54.2,64.55):b.box(c,'DPDT side cheek',x,48,19.8,1.25,5.2,11.9)
 for x in (54.2,63.9):
  for y in (48,52.45):b.box(c,'DPDT axial stop',x,y,19.8,1.9,.75 if y>50 else 1.25,11.9)
 b.union(c)
 for x,y in ((35,38),(103,38)):nutboss(c,'Yoke mounting boss',x,y,11.4,31.7,13.8,18.2,-1)
 # Rectangular reset guide and a single accessible positive travel stop.
 b.box(c,'Reset guide collar',116.2,51.0,12.5,1.6,6.2,5.3)
 xz(c,'Reset collar underside gusset',51.0,[(116.2,17.8),(117.8,17.8),(117.8,19.4)],6.2)
 b.box(c,'Reset collar lateral buttress',116.19,50.6,15.65,1.61,1.0,1.75)
 xz(c,'Reset collar lateral brace',50.6,[(116.19,17.4),(117.8,17.4),(117.8,21),(116.19,19.39)],1.0)
 # Inward stop is on the removable yoke so the plunger inserts from inside.
 b.union(c)
 # Ports use short chamfered roofs; only the board-free exterior wall is cut.
 xz(c,'Charger USB access',57.4,[(14.8,26.2),(28.2,26.2),(28.2,20.5),(26.2,18.5),(16.8,18.5),(14.8,20.5)],2.8,True)
 xz(c,'XIAO USB access',57.4,[(110.4,28),(117.5,28),(117.5,18.0),(116,16.5),(111.9,16.5),(110.4,18.0)],2.8,True)
 xz(c,'Power grip insertion and travel',57.4,[(55.25,24.1),(64.75,24.1),(64.75,21.1),(62.75,19.1),(57.25,19.1),(55.25,21.1)],2.8,True)
 yz(c,'Reset stem guide',116.1,[(52.55,16.6),(56.85,16.6),(56.85,14.0),(56.55,13.7),(52.85,13.7),(52.55,14.0)],4.1,True)
 b.paint(c);finish('rear')

def yoke():
 c=b.component('06 Electronics retaining yoke','Front face down, contact legs up; use M3x8 button heads')
 b.box(c,'Common yoke rail',11.1,36,9.4,101.2,3.0,2.0)
 for x in (11.1,26.9):b.box(c,'Charger yoke arm',x,34,9.4,4.6,19.0,2)
 for x,y in ((13.1,34),(26.9,34),(13.1,51),(26.9,51)):b.box(c,'Charger keeper foot',x,y,11.4,2,2,11.65)
 for x in (53.5,63.1):b.box(c,'Switch yoke arm',x,37,9.4,3.4,15,2)
 for x in (55.9,63.1):b.box(c,'Switch retaining foot',x,49.7,11.4,1.0,2.3,8.45)
 b.box(c,'XIAO yoke rail',108.5,38,9.4,3.8,12,2)
 b.box(c,'Reset stop arm',108.5,49,9.4,6.9,2.6,2)
 b.box(c,'Reset stop post',113.5,50.6,11.4,1.9,1,6)
 b.box(c,'Reset inward stop',113.5,51.6,15.65,1.2,1.6,1.75)
 yz(c,'Reset stop 45 degree brace',113.5,[(51.6,14.05),(51.6,15.65),(53.2,15.65)],1.2)
 for y in (40,48):
  b.box(c,'XIAO restraint root',111.8,y,9.4,1.95,2,2.0)
  b.box(c,'XIAO front outer restraint',112.25,y,11.3,1.5,2,2.4)
 for x in (35,103):b.box(c,'Yoke screw pad',x-4.2,33.8,9.4,8.4,8.4,2)
 b.union(c)
 for x in (35,103):b.cutcyl(c,'Yoke M3 clearance',x,38,9.38,3.4,2.04)
 b.paint(c);finish('yoke')

def controls():
 c=b.component('07 Captive reset plunger','Flat-sided golf tee; broad flat side down; positive 0.5 mm travel stop')
 b.box(c,'Reset exterior stem',116,52.8,13.95,4.6,3.8,2.4)
 b.box(c,'Reset captive flange',115.2,51.9,13.95,.8,5.0,3.2)
 b.box(c,'Reset contact tip',b.param('reset_tip_x'),53.9,13.95,115.2-b.param('reset_tip_x'),1.6,1.2)
 b.union(c);b.paint(c,'Control PETG',(105,110,117))
 c=b.component('08 Captive DPDT power slider','Socket end down; 45 degree expanding shoulder; grip passes through wall')
 # The actuator cup is narrow enough to clear the fixed end stops at both detents.
 b.box(c,'Actuator cup blank',57.7,52.4,20.05,4.6,1.0,3.3)
 points0=[(57.7,53.4,-20.05),(62.3,53.4,-20.05),(62.3,53.4,-23.35),(57.7,53.4,-23.35)]
 points1=[(54,57.1,-18.5),(66,57.1,-18.5),(66,57.1,-25.5),(54,57.1,-25.5)]
 s0,n=profile3(c,'Slider shoulder lower','y',53.4,points0);s1,n=profile3(c,'Slider shoulder upper','y',57.1,points1)
 inp=c.features.loftFeatures.createInput(OP.NewBodyFeatureOperation);inp.isSolid=True
 inp.loftSections.add(s0.profiles.item(0));inp.loftSections.add(s1.profiles.item(0))
 c.features.loftFeatures.add(inp).name='Self-supporting slider shoulder'
 b.box(c,'Inner captive flange',54,57.05,18.5,12,.35,7)
 b.box(c,'Slider guide neck',57.6,57.3,20.8,4.8,3.5,2.4)
 b.box(c,'Exterior finger grip',57.5,60.0,20.6,5.0,1.4,2.8)
 b.union(c)
 sw=b.param('actuator_w')+.4;sd=b.param('actuator_d')+.4
 # Open toward the front as well as the actuator end: the switch can drop
 # into its rear-cover nest after this slider passes outward through the wall.
 b.cutbox(c,'Front and bottom open actuator fork',60-sw/2,52.3,18.0,sw,b.param('actuator_h')+.3,21.55+sd/2-18.0)
 b.paint(c,'Control PETG',(105,110,117));finish('controls')

def hardware(c,name,x,y,bearing,length,front_insert=True,button=False):
 hd=1.65 if button else 3.0;diam=5.7 if button else 5.5
 b.cyl(c,name+' head',x,y,bearing-hd if front_insert else bearing,diam,hd)
 b.cyl(c,name+' shaft',x,y,bearing if front_insert else bearing-length,3,length)

def refs():
 a,ar,bf,br,rf,rb=dims()
 c=b.component('REF Battery','52x21x10 pouch; foam and wiring not modeled')
 b.box(c,'Battery pouch',35,11,20.6,52,21,10);b.paint(c,'Battery foil',(160,168,180))
 c=b.component('REF Charger','Provisional bare PCB, USB and component envelopes')
 b.box(c,'Charger PCB',12.75,32,23.2,16.5,25,1)
 b.box(c,'Charger USB envelope',17,53,19.6,9,6.4,3.6)
 b.box(c,'Charger IC envelope',18,36,20.9,7,11,2.3);b.paint(c,'PCB green',(24,100,63))
 c=b.component('REF XIAO','21x17.8 board; reset and populated envelopes remain provisional')
 b.box(c,'XIAO PCB',111,35.5,11.55,1,21,17.8)
 b.box(c,'XIAO USB envelope',112,52,17.75,3.3,6.4,9)
 b.box(c,'XIAO component envelope',112,41.5,16.0,3.0,9,9)
 b.box(c,'XIAO reset target',112,53.7,13.65,1.5,2,1.8);b.paint(c,'PCB green',(24,100,63))
 c=b.component('REF DPDT','Updated actuator dimensions; throw interpreted from slot length')
 b.box(c,'DPDT body',55.7,49.5,20,8.6,2.7,3.1)
 b.box(c,'DPDT actuator',60-b.param('actuator_w')/2,52.2,21.55-b.param('actuator_d')/2,b.param('actuator_w'),b.param('actuator_h'),b.param('actuator_d'))
 for x in (57,60,63):
  for d in (20.4,22.2):b.box(c,'DPDT terminal',x-.2,46.5,d,.4,3,.35)
 b.paint(c,'Connector steel',(155,165,175))
 c=b.component('REF Four LEDs','8x8x2; emitter offset assumed 1 mm')
 for x in (40,80):
  for y in (6.8,53.2):b.box(c,'LED module',x-4,y-4,a+b.param('acrylic_t')/2-1,8,8,2)
 b.paint(c,'LED module',(190,168,62))
 c=b.component('REF M3 screws','4x25 socket head, 2x6 button head, 2x8 button head')
 for x,y in FAST:hardware(c,'Closure screw',x,y,3.2,25)
 for y in (6,54):hardware(c,'Optical screw',60,y,rb,6,False,True)
 for x in (35,103):hardware(c,'Yoke screw',x,38,9.4,8,True,True)
 b.paint(c,'Connector steel',(155,165,175))
 c=b.component('REF M3 nuts','Eight standard 5.5 AF x 2.4 mm nuts')
 for x,y,d in [(x,y,24.9) for x,y in FAST]+[(60,y,3.3) for y in (6,54)]+[(x,38,13.9) for x in (35,103)]:
  sk=b.sketch(c,'Nut hex',d);r=5.5/math.sqrt(3);b.polygon(sk,[(x+r*math.cos(i*math.pi/3),y+r*math.sin(i*math.pi/3)) for i in range(6)])
  feat=b.extrude(c,sk,-2.4,'M3 nut')
  b.cutcyl(c,'Reference thread clearance',x,y,d-.01,3.15,2.42)
 b.paint(c,'Connector steel',(155,165,175))
 finish('references')

def run_stage(stage):
 if stage!='setup' and not b.root().attributes.itemByName('LittleOnAirV2','Revision'):raise RuntimeError('Activate v2 design')
 {'setup':setup,'front':front,'optics':optics,'rear':rear,'yoke':yoke,'controls':controls,'refs':refs}[stage]()

def run(_context:str):run_stage('setup')
