"""Fusion v2.7: parallel PCBs, front reset, 24 mm overall depth.

Coordinates are millimetres, front-view XY and depth=-Z. Start from archived
v2.6 optics; rebuild the electronics housing and keeper for the new layout.
"""
import adsk.core as C
import adsk.fusion as F
import importlib.util, math, json
from pathlib import Path
HERE=Path(__file__).resolve().parent
BASE=HERE.parent
OUT=BASE/'output/v27'
s=importlib.util.spec_from_file_location('slim_helpers',str(BASE/'v26/build_v2.py'))
m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
m.OUT=OUT;b.OUT=OUT
FAST=[(6,6),(114,6),(6,54),(114,54)]
YFAST=[(35,38),(73,38)]
RX,RY=89.015,56
# Shift the whole flat-XIAO group 3 mm right to preserve the existing top-right
# pixel's three solder exits. Keep the original measured group coordinates below
# so interface dimensions remain readable against the source layout.
XIAO_SHIFT=3
_shift_names=('xiao','reset','rgb','rounded front finger','broad internal captive flange','remove narrow end contact','wide upper keeper landing')
def shifted(fn):
 def call(c,name,x,*args,**kwargs):
  return fn(c,name,x+(XIAO_SHIFT if any(k in name.lower() for k in _shift_names) else 0),*args,**kwargs)
 return call
# cutbox/cutcyl dispatch to box/cyl in the helper module; wrapping them too would
# apply the same placement offset twice.
for _n in ('box','rbox','cyl'):setattr(b,_n,shifted(getattr(b,_n)))

def copy_component(name,desc,bodies):
 c=b.component(name,desc);f=c.features.baseFeatures.add();f.name='Archived v2.6 optical geometry';f.startEdit()
 for name,body in bodies:c.bRepBodies.add(body,f)
 f.finishEdit()
 for body,(name,_) in zip(c.bRepBodies,bodies):body.name=name
 return c

def checkpoint(name):
 m.finish(name)
 assert b.design().exportManager.execute(b.design().exportManager.createFusionArchiveExportOptions(str(OUT/(name+'.f3d'))))

def setup():
 app=C.Application.get();OUT.mkdir(parents=True,exist_ok=True)
 old=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE/'output/on-air-v26-fabrication/cad/little-on-air-v26.f3d')))
 d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get()
 keep=('01','02','03','04','81','82','REF Four LEDs','REF Charger','REF XIAO','REF DPDT','REF SPDT')
 shapes=[(o.component.name,o.component.description,[(bb.name,tm.copy(bb)) for bb in o.component.bRepBodies]) for o in d.rootComponent.occurrences if o.component.name.startswith(keep)]
 params=[(p.name,p.expression,p.comment) for p in d.userParameters]
 doc=app.documents.add(C.DocumentTypes.FusionDesignDocumentType);doc.name='Little ON AIR - v2.7 parallel PCBs and slim case'
 d=F.Design.cast(app.activeProduct);d.designType=F.DesignTypes.ParametricDesignType;d.unitsManager.distanceDisplayUnits=F.DistanceUnits.MillimeterDistanceUnits
 for name,expr,comment in params:d.userParameters.add(name,C.ValueInput.createByString(expr),'mm',comment)
 for name,desc,bs in shapes:copy_component(name,desc,bs)
 old.close(False);doc.activate()
 def move(c,mat):
  inp=c.features.moveFeatures.createInput2(b.oc(list(c.bRepBodies)));inp.defineAsFreeMove(mat);c.features.moveFeatures.add(inp)
 for o in b.root().occurrences:
  c=o.component
  if c.name.startswith(('REF DPDT','REF SPDT')):
   mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,.6);move(c,mat)
  if c.name=='REF Charger':
   mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,.79);move(c,mat)
  if c.name=='REF XIAO':
   # RY(-90): x'=74.45-z; z'=x-128.5. PCB component side faces front.
   mat=C.Matrix3D.create();mat.setToRotation(-math.pi/2,C.Vector3D.create(0,1,0),b.p(0,0,0));mat.translation=C.Vector3D.create(7.445+XIAO_SHIFT/10,0,-12.85);move(c,mat)
 for name,value in {'case_d':24,'xiao_flat_pcb_back':19.7,'charger_flat_pcb_back':15.3,'reset_front_freeplay':.25,'reset_front_stroke':.60,'reset_front_projection':2.5}.items():
  p=d.userParameters.itemByName(name)
  if p:p.expression=f'{value} mm'
  else:d.userParameters.add(name,b.vi(value),'mm','v2.7 measured component layout')
 checkpoint('parallel-pcb-layout')

def front():
 c=b.comp('01 Front optical bezel')
 # Move the formerly offset upper-right closure screw to the true corner.
 b.cyl(c,'Close obsolete upper-right screw opening',96,54,0,6.81,9.5);b.union(c)
 b.cutbox(c,'Remove obsolete inboard compression seat',91.79,49.79,1.6,8.42,7.81,7.91)
 b.box(c,'New upper-right corner compression seat',109.8,49.8,1.5,8.4,8.4,8);b.union(c)
 b.cutcyl(c,'New common M3 clearance',114,54,-.02,3.6,9.54)
 b.cutcyl(c,'New common inset head bearing',114,54,-.02,6.8,6.62)
 # Front and rear separated guides support the long plunger. The flange stays
 # entirely above the acrylic outline, and the yoke supplies the travel stop.
 b.box(c,'Front reset guide broad collar',RX-3.5,RY-3.4,1.5,7,6.8,4.5);b.union(c)
 b.cutbox(c,'Front keyed reset running guide',RX-1.4,RY-1.6,-.1,2.8,3.2,6.2)
 b.cutbox(c,'Reset captive flange loading pocket',RX-2.9,RY-2.9,6,5.8,5.8,3.51)
 b.cutcyl(c,'RGB6 front indicator aperture',100.605,55.006,-.02,3.2,9.55)
 b.paint(c);checkpoint('front-controls')

def boss(c,name,x,y,front,nutfront,boreend,entry):
 b.box(c,name,x-4.2,y-4.2,front,8.4,8.4,21.7-front);b.union(c)
 if entry=='down':
  sk=b.sketch(c,name+' nut flats',nutfront);r=6/math.sqrt(3)
  b.polygon(sk,[(x+r*math.cos(math.pi/2+i*math.pi/3),y+r*math.sin(math.pi/2+i*math.pi/3)) for i in range(6)])
  b.extrude(c,sk,-3,name+' nut pocket',F.FeatureOperations.CutFeatureOperation)
  b.cutbox(c,name+' inward nut mouth',x-3,y-4.5,nutfront,6,4.5,3)
 else:
  m.hexcut(c,name+' nut flats',x,y,nutfront,3,6)
  b.cutbox(c,name+' inward nut mouth',x if entry=='right' else x-4.5,y-3,nutfront,4.5,6,3)
 b.cutcyl(c,name+' blind M3 clearance',x,y,front-.02,3.6,boreend-front+.02)

def rear():
 c=b.component('05 Rear electronics housing','24 mm total case; parallel PCB nests; back face on print bed')
 b.rbox(c,'Slim rear envelope',0,0,9.5,120,60,14.5,3)
 b.cutbox(c,'Open electronics cavity',2.4,2.4,9.48,115.2,55.2,12.22)
 for x,y in FAST:boss(c,'Closure boss',x,y,9.5,11.5,15.2,'down' if (x,y)==(6,54) else 'right' if x<60 else 'left')
 for x,y in YFAST:boss(c,'Keeper boss',x,y,12.4,13.8,18.2,'right' if x==35 else 'left')
 # The battery lies clear of the optics. Strap lugs are rooted in the back.
 for x,y,w,h in ((32.4,8.4,57.2,1.6),(32.4,10,1.6,23),(88,10,1.6,17),(32.4,33,41.6,1.6)):
  b.box(c,'Battery low fence',x,y,18,w,h,3.7)
 b.box(c,'Battery insulated bed',34,10,21.4,54,23,.3)
 for x in (28.4,90):b.box(c,'Strap lug',x,18,17,4,7,4.7)
 # Charger support positions keep OUT through-hole joints clear.
 for x in (12.25,27.75):
  for y,h in ((34.3,2),(53.5,3)):b.box(c,'Charger clear-area PCB seat',x,y,16.3,2,h,5.4)
 for x in (10.05,30.05):b.box(c,'Charger side fence',x,31,15,1.9,25,6.7)
 b.box(c,'Charger lower central stop',16,28.1,15,10,1.9,6.7)
 for x in (12.25,27.75):b.box(c,'Charger upper end stop',x,58.65,15,2,1.1,6.7)
 # XIAO pads remain open down both full long edges. Broad short-end seats
 # resist cable and reset forces; no tall edge cage or solder-blocking spine.
 for x in (86.25,101.55):
  for y,h in ((36.8,1.4),(56.65,1.15)):b.box(c,'XIAO short-end PCB seat',x,y,19.7,2,h,2)
 b.box(c,'XIAO reset reaction support',87.8,54.8,19.7,2.4,2.4,2)
 b.box(c,'XIAO bottom end stop',87,34.7,18.25,15,1.85,3.45)
 for x in (86,100.2):b.box(c,'XIAO upper end stop',x,58.05,18.25,3.6,1.7,3.45)
 for x in (83.75,104.05):
  for y,h in ((35.8,2.5),(56.4,1.6)):b.box(c,'XIAO short corner lateral stop',x,y,18.25,2,h,3.45)
 # Matched switch geometry uses the measured successful body and flange fits.
 b.box(c,'POWER nest',30.9,51.15,13.8,20.2,8.6,7.9)
 b.box(c,'MODE nest',53.25,53.65,13.7,13.5,6.1,8)
 b.union(c)
 for x in (28.4,90):m.yz(c,'Strap slot tent roof',x-.1,[(20,20.4),(23,20.4),(23,18.8),(21.5,17.3),(20,18.8)],4.2,True)
 # USB and switch slots are open to the front for straight component loading.
 # Their upper roofs are on the removable keeper, which installs afterwards.
 for name,x,w,back in [('Charger USB',15.775,9.45,19.7),('XIAO USB',90.115,9.57,18.8)]:
  b.cutbox(c,name+' front-loading top aperture',x,57.35,9.48,w,2.8,back-9.48)
 b.cutbox(c,'POWER body fit',35.5,53.15,9.48,11,5.45,10.77)
 b.cutbox(c,'POWER mounting flange fit',30.935,57.65,9.48,20.13,.95,10.77)
 b.cutbox(c,'POWER three solder terminals bay',35.9,48.25,13.9,10.2,5.1,6.6)
 b.cutbox(c,'POWER direct lever top aperture',37.85,58.4,9.48,6.3,1.8,9.295)
 b.cutbox(c,'MODE body pocket 0.20 per side',55.25,55.29,9.48,9.5,3.76,8.34)
 # Two uninterrupted rows, plus solder room below; no individual pin comb.
 b.cutbox(c,'MODE lower solder bay',55.1,48.9,13.3,9.8,4.75,5.2)
 for dep in (13.9,16.92):b.cutbox(c,'MODE terminal row clearance',56.9,53.64,dep,6.2,1.65,1.1)
 b.cutbox(c,'MODE direct actuator top aperture',57.8,58.85,9.48,4.4,1.3,7.53)
 # Same mating tongues as the optical front, with .25 mm clearance.
 for x in (2.4,115.9):b.cutbox(c,'Side tongue clearance',x,16.75,9.48,1.7,9.5,1.77)
 b.cutbox(c,'Top tongue clearance',35.75,55.9,9.48,10.5,1.7,1.77)
 for y in (49.4,44.65):b.cutcyl(c,'Charger rear LED viewing hole',14,y,16.5,3.2,7.7)
 # Side vents retained, centered within the shallower wall.
 for x in (-.1,117.5):
  for cy in (15,24,33):
   u=(math.sqrt(.5),math.sqrt(.5));v=(-u[1],u[0]);pts=[]
   for sign,angles in [(1,range(-90,91,12)),(-1,range(90,271,12))]:
    for deg in angles:
     a=math.radians(deg);pts.append((cy+sign*2.8*u[0]+1.2*(math.cos(a)*u[0]+math.sin(a)*v[0]),16+sign*2.8*u[1]+1.2*(math.cos(a)*u[1]+math.sin(a)*v[1])))
   m.yz(c,'Angled pill vent',x,pts,2.65,True)
 b.paint(c);checkpoint('slim-rear-housing')

def yoke():
 c=b.component('06 Electronics retaining yoke','Flat PCB keeper; broad rails, short contact pads, keyed reset guide')
 b.box(c,'Common 2.75 mm keeper rail',10.05,34,9.65,96.45,4,2.75)
 for x,y in YFAST:b.box(c,'Common screw seat',x-4.2,y-4.2,9.65,8.4,8.4,2.75)
 for x in (10.05,27.5):b.box(c,'Charger side keeper rail',x,33.8,9.65,4.45,23.55,2.75)
 for x in (12.25,27.35):
  for y,h in ((34.3,2),(53.5,3)):b.box(c,'Charger short keeper pad',x,y,12.35,2.4,h,2.80)
 b.box(c,'Charger roof crossbar',10.05,54.65,9.65,21.9,2.7,2.75)
 b.box(c,'Charger square USB roof',15.775,57.3,9.65,9.45,2.45,6.35)
 for x in (33,47.2):b.box(c,'POWER broad side arm',x,36,9.65,3.2,21.5,2.75)
 b.box(c,'POWER upper crossbar',33,54.5,9.65,17.4,2.8,2.75)
 for x in (36.6,43):b.box(c,'POWER short keeper pad',x,54,12.35,2.4,2.5,1.45)
 b.box(c,'POWER square lever roof',37.85,57.25,9.65,6.3,2.5,5.575)
 for x in (53.1,63.2):b.box(c,'MODE broad side arm',x,36,9.65,3.5,21.5,2.75)
 b.box(c,'MODE upper crossbar',53.1,54.65,9.65,13.6,2.7,2.75)
 for x in (55.45,62.05):b.box(c,'MODE keeper 0.15 body freeplay',x,55.85,12.35,2.5,1.9,1.60)
 b.box(c,'MODE square actuator roof',57.8,57.25,9.65,4.4,2.5,5.06)
 for x in (83.5,103):b.box(c,'XIAO broad side rail',x,35.8,9.65,3.5,22,2.75)
 b.box(c,'XIAO upper crossbar',83.5,54.4,9.65,23,3.4,2.75)
 for x in (86.25,101.55):
  for y,h in ((36.8,1.4),(56.65,1.15)):b.box(c,'XIAO short end keeper pad',x,y,12.35,2,h,6)
 b.box(c,'XIAO square USB roof',90.115,57.3,9.65,9.57,2.45,5.38)
 b.box(c,'Deep keyed reset guide',RX-3.5,RY-3.4,12.35,7,6.8,2.65)
 b.union(c)
 for x,y in YFAST:b.cutcyl(c,'M3 keeper clearance',x,y,9.63,3.6,2.79)
 b.cutbox(c,'Rear reset running guide',RX-1.4,RY-1.6,9.63,2.8,3.2,5.40)
 b.cutcyl(c,'RGB6 unobstructed front sight',100.605,55.006,9.63,3.2,9)
 b.cutbox(c,'Top front tongue clearance',35.75,55.9,9.48,10.5,1.7,1.77)
 # Charger pads are 0.15 mm clear. XIAO underside pads and all side pads are
 # outside the short-end contacts; solder before fitting either board.
 b.paint(c);checkpoint('parallel-pcb-keeper')

def reset_and_misc():
 c=b.component('07 Front guided reset button','Print external face on bed; captive keyed plunger; 0.25 gap, 0.60 stroke')
 b.rbox(c,'Rounded front finger and keyed shaft',RX-1.2,RY-1.4,-2.5,2.4,2.8,17.3,.45)
 b.rbox(c,'Broad internal captive flange',RX-2.6,RY-2.6,6,5.2,5.2,3.05,.6)
 b.box(c,'Narrow USB-clear reset contact',RX-1,RY-1,14.7,2,2,2.95)
 b.union(c);b.paint(c,'Control PETG',(95,105,116))
 c=b.component('REF Battery','52 x21 x10, front clearance preserved; no wire bundles on pouch')
 b.box(c,'Battery pouch',35,11,10.9,52,21,10);b.paint(c,'Battery wrap',(165,168,173))
 c=b.component('REF Capacitor','Existing inline 680 uF; laid on its side, maximum 8 dia x11.5 body')
 sk,n=m.plane_sketch(c,'Horizontal capacitor','y',15)
 sk.sketchCurves.sketchCircles.addByCenterRadius(sk.modelToSketchSpace(b.p(103,15,-16)),.4)
 b.extrude(c,sk,11.5/n,'C1 inline capacitor');b.paint(c,'Capacitor',(38,43,47))
 checkpoint('slim-assembly')

def run(_context:str):
 stage=globals().get('STAGE','setup')
 globals()[stage]()
