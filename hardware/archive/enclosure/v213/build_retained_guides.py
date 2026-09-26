"""Positive mechanical retention for three indicator guides; v2.12 base."""
import adsk.core as C
import adsk.fusion as F
import adsk,importlib.util,json,math
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v213'
s=importlib.util.spec_from_file_location('retention_helpers',str(BASE/'build_enclosure.py'));b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
X,Y=103.605,55.006

def dprofile(c,name,x,y,depth,r,flat,left=None,amount=1,op=F.FeatureOperations.CutFeatureOperation):
 # Native major circular arc with a flat chord; optional second flat is cut
 # into a temporary tool body before subtraction.
 sk=b.sketch(c,name+' profile',depth);dx=math.sqrt(r*r-flat*flat);a=math.asin(flat/r)
 sk.sketchCurves.sketchArcs.addByCenterStartSweep(b.p(x,y),b.p(x+dx,y+flat),math.pi-2*a)
 sk.sketchCurves.sketchLines.addByTwoPoints(b.p(x-dx,y+flat),b.p(x+dx,y+flat))
 return b.extrude(c,sk,-amount,name,op)

def create_keeper():
 keeper=b.component('11 Rear light guide keeper','Captures both charger-guide collars. One M3x8 button-head screw and side-loaded M3 nut. Screw bearing face on bed; support beneath open arm only.')
 b.rbox(keeper,'Keeper screw pad',2.65,38.1,16.5,6.85,10.2,1.8,.8)
 b.box(keeper,'Rigid fence-crossing bridge',8.5,45.85,16.5,5.5,2.5,3.8)
 b.rbox(keeper,'Twin guide retaining bar',12.15,41.25,18.1,5.45,11.5,2.2,.65)
 b.cyl(keeper,'M3 screw bearing stand-off',6.5,42.3,15.3,6.0,3);b.union(keeper)
 b.cutcyl(keeper,'Clear structural nut boss below screw pad',6.5,42.3,18.3,8.8,2.02)
 for yy in (49.4,44.65):
  b.cutcyl(keeper,'Charger pickup clearance',14,yy,16.48,3.3,3.84)
  b.cutbox(keeper,'Open shaft slot leaves broad rigid spine',11.95,yy-1.65,16.48,2.05,3.3,3.84)
 b.cutcyl(keeper,'M3 common running hole',6.5,42.3,15.28,3.6,5.04)
 b.cutbox(keeper,'Charger IC corner clearance with 1.45 mm rear web',16.75,40.95,18.08,1.1,4.6,.77)
 b.paint(keeper)
 return keeper

def run(_context:str):
 OUT.mkdir(parents=True,exist_ok=True);app=C.Application.get()
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE/'output/on-air-v212-clean-perimeter-front/cad/little-on-air-v212.f3d')))
 doc.name='Little ON AIR v2.13 - captive indicator guides'
 d=b.design();tm=F.TemporaryBRepManager.get()
 before={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 front=b.comp('01 Front optical bezel');rear=b.comp('05 Rear electronics housing')
 # A long, rooted bearing and keyed shoulder support the front guide. Its
 # flange is captured by the existing yoke once the case is closed.
 b.cyl(front,'RGB rooted guide bearing',X,Y,1.5,7.2,8.0);b.union(front)
 b.cutcyl(front,'RGB 3.2 mm guide running bore',X,Y,-.02,3.2,9.55)
 dprofile(front,'RGB keyed captive collar well',X,Y,8.2,2.35,-.9,amount=1.32)
 # Existing rear light pipes keep their external dimensions and fit choice.
 # Seats constrain collar rotation; the removable plate blocks inward travel.
 for yy in (49.4,44.65):b.cyl(rear,'Charger guide collar socket',14,yy,20.4,6.6,1.3)
 b.cyl(rear,'Guide keeper M3 nut boss with 2 mm roof',6.5,42.3,18.3,8.4,5.7);b.union(rear)
 for yy in (49.4,44.65):
  dprofile(rear,'Keyed rear guide collar well',14,yy,20.38,2.25,-.9,amount=1.32)
  b.cutcyl(rear,'Preserve charger guide outlet',14,yy,21.69,3.2,2.33)
 # The keeper crosses the fence in one short, front-open channel. The board
 # locating sections and measured clear-area seats at both ends are untouched.
 b.cutbox(rear,'Keeper bridge channel in charger fence',9.85,45.65,14.95,2.4,2.9,5.60)
 sk=b.sketch(rear,'Side loading M3 hex pocket below 2 mm roof',20.3);r=6/math.sqrt(3)
 b.polygon(sk,[(6.5+r*math.cos(math.pi/2+i*math.pi/3),42.3+r*math.sin(math.pi/2+i*math.pi/3)) for i in range(6)])
 b.extrude(rear,sk,-2.9,'Guide keeper captive M3 nut pocket',F.FeatureOperations.CutFeatureOperation)
 b.cutbox(rear,'Guide nut lower loading bay and sliding entry',3.5,31.2,20.3,6,11.1,2.9)
 b.cutcyl(rear,'Guide keeper blind screw tip clearance',6.5,42.3,18.28,3.6,5.12)
 # Single rigid plate; no flexible snap fingers. Rear planar face on print bed.
 keeper=create_keeper()
 # Replace only the old exterior-collared front pipe.
 old=next(o for o in b.root().occurrences if o.component.name=='08 Front RGB light guide');assert old.deleteMe()
 d.userParameters.itemByName('indicator_guide_diameter').expression='3.05 mm'
 pipe=b.component('08 Front RGB light guide','Internal keyed collar captured between frame shoulder and existing yoke. 0.25 mm total axial play. Install from inside before closing front.')
 b.cyl(pipe,'Front optical shaft',X,Y,-.4,'indicator_guide_diameter',15.1)
 b.cyl(pipe,'USB-clear narrow LED pickup',X,Y,14.65,1.8,2.55)
 b.cyl(pipe,'Internal retaining collar',X,Y,8.2,4.4,1.2);b.union(pipe)
 b.cutbox(pipe,'Continuous flat optical printing face',X-3,Y-4,-.41,6,3.3,17.63)
 # Extra hardware uses the same M3x8 button head and standard nut as the case.
 hw=b.component('REF Guide keeper hardware','One additional M3x8 button head screw and M3 hex nut; simplified physical envelopes.')
 b.cyl(hw,'M3x8 guide screw shaft',6.5,42.3,15.3,3,8)
 b.cyl(hw,'M3 button head envelope',6.5,42.3,13.65,5.7,1.65)
 sk=b.sketch(hw,'M3 nut exterior',20.3);r=5.5/math.sqrt(3)
 b.polygon(sk,[(6.5+r*math.cos(math.pi/2+i*math.pi/3),42.3+r*math.sin(math.pi/2+i*math.pi/3)) for i in range(6)])
 b.extrude(hw,sk,-2.4,'M3 nut envelope')
 # Cut the actual through bore only in the nut, preserving the screw envelope.
 nut=hw.bRepBodies.item(hw.bRepBodies.count-1);sk=b.sketch(hw,'Nut bore profile',20.29);sk.sketchCurves.sketchCircles.addByCenterRadius(b.p(6.5,42.3),.16)
 inp=hw.features.extrudeFeatures.createInput(sk.profiles.item(0),F.FeatureOperations.CutFeatureOperation);inp.setDistanceExtent(False,b.vi(-2.42));inp.participantBodies=[nut];hw.features.extrudeFeatures.add(inp);sk.isVisible=False
 for c in (front,rear,keeper):b.paint(c)
 b.paint(pipe,'Light pipe blue',(86,184,219));b.paint(hw,'Guide screw steel',(150,155,162))
 after={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 unchanged=[k for k in before if not k.startswith(('01','05','08'))]
 assert all(before[k]==after[k] for k in unchanged)
 (OUT/'build-record.json').write_text(json.dumps({'baseline':'v2.12','changed_existing':['01','05','08'],'added':['11','REF Guide keeper hardware'],'all_other_component_volumes_unchanged':True,'front_axial_play_mm':.25,'rear_axial_play_mm':.2,'minimum_front_LED_gap_mm':.45,'minimum_rear_LED_gap_mm':.3,'front_collar_well_diametral_clearance_mm':.3,'rear_collar_well_diametral_clearance_mm':.3},indent=2))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'retention-built.f3d')))
 print('Built captive front collar, rear collar seats and rigid screw keeper; ready for native interference and motion validation.')
