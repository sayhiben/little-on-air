"""Clone the released Fusion model and add a captive, front-loaded SS12F15 nest."""
import adsk.core as C
import adsk.fusion as F
import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v22'

def run(_context:str):
 app=C.Application.get();imp=app.importManager
 doc=imp.importToNewDocument(imp.createFusionArchiveImportOptions(str(HERE.parent/'output/on-air-v21-fabrication/cad/little-on-air-v21.f3d')))
 doc.name='Little On Air - Enclosure v2.2 - two switches'
 s=importlib.util.spec_from_file_location('loa_v22',str(HERE/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 d=F.Design.cast(app.activeProduct);root=d.rootComponent
 root.attributes.add('LittleOnAirV22','Revision','2.2: SPDT POWER and DPDT RUN-PROGRAM; direct protected battery supply')
 for o in list(root.occurrences):
  if o.component.name.startswith(('REF Auxiliary','REF Harness')):o.deleteMe()
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 slider=b.comp('08 Captive DPDT power slider');slider.name='08 Captive RUN PROGRAM slider'
 for name,value,note in [('spdt_body_length',10.5,'Amazon Tnuocke SS12F15-G5 dimension drawing'),('spdt_body_depth',5.7,'Listing drawing; axis normal to sign face'),('spdt_body_height',5.5,'Drawing: flange face to terminal base'),('spdt_flange_length',19.5,'Drawing; no mounting-hole assumption'),('spdt_knob_height',5,'Drawing'),('spdt_knob_envelope',3.2,'Conservative square envelope; drawing side dimension 2.9 mm'),('spdt_travel',3,'Nominal family travel, unmeasured; aperture allows 4.7 mm total'),('spdt_fit_clearance',.3,'Per side in X and Y; front keeper clearance 0.35 mm')]:
  d.userParameters.add(name,b.vi(value),'mm',note)
 # Retain integrated construction; clear the obsolete booster landing under the new mount.
 b.cutbox(rear,'v22 clear unused booster land and fences',36.05,41.45,27.45,17.2,11.1,4.15)
 # Body nominal X35.75..46.25, Y51.5..57.0, depth20..25.7.
 b.box(rear,'SPDT rear seat',35.45,51.2,25.7,11.1,6.15,6)
 for x in (34.05,46.55):b.box(rear,'SPDT side locating cheek',x,51.2,19.8,1.4,5.05,11.9)
 for x in (34.05,46.55):b.box(rear,'SPDT cheek-to-stop continuous corner',x,50.9,19.8,1.4,.6,11.9)
 for x in (35.45,45.55):b.box(rear,'SPDT terminal-side shoulder stop',x,49.9,20,1,1.3,11.7)
 b.box(rear,'SPDT flange-side stop tied to top wall',35.45,57.3,20,11.1,.4,11.7)
 b.union(rear)
 # An open-front notch permits assembly with the real lever already on the switch.
 b.cutbox(rear,'SPDT front-loading lever notch',37.05,57.25,9.45,7.9,2.9,15.35)
 # Yoke bridges grow from the print bed; no loose switch bracket or extra screws.
 for x in (37.4,43.6):b.box(yoke,'SPDT keeper arm',x,37.5,9.4,2.4,17,2)
 for x in (37.4,44.6):b.box(yoke,'SPDT keeper pad with 0.35mm axial allowance',x,52,11.4,1.2,2.5,8.25)
 b.box(yoke,'SPDT top-opening roof root',37.4,53,9.4,7.2,6.75,2)
 b.box(yoke,'SPDT removable lever-slot roof',37.3,57.3,9.4,7.4,2.45,11.5)
 b.union(yoke)
 b.box(yoke,'SPDT roof ramp reinforcing web',37.4,53,11.3,7.2,4.4,3.5);b.union(yoke)
 m.yz(yoke,'SPDT 45-degree printable roof and tongue clearance',37.2,[(53.95,0),(60.1,0),(60.1,12.75),(57.3,12.75),(53.95,9.4)],7.6,True)
 # Datum bodies document the seller drawing and deliberately conservative knob envelope.
 c=b.component('REF SPDT power switch','SS12F15-G5; drawing dimensions, verify physical switch with coupon')
 b.box(c,'SPDT main body',35.75,51.5,20,10.5,5.5,5.7)
 b.box(c,'SPDT flange envelope',31.25,56.5,20,19.5,.5,5.7)
 for x in (37.5,41,44.5):b.box(c,'SPDT solder terminal envelope',x-.6,49,22.55,1.2,2.5,.6)
 b.union(c);b.paint(c,'SPDT metal body',(120,125,132))
 k=b.component('REF SPDT moving lever','3.2 square conservative envelope; nominal 3mm end-to-end movement')
 b.box(k,'SPDT lever',39.4,57,21.25,3.2,5,3.2);b.paint(k,'Power lever',(28,28,30))
 cap=b.component('REF Capacitor','Only retained extra electrical component envelope besides inline resistor and pigtails')
 b.cyl(cap,'C1 680uF maximum 8x11.5mm',84,47.5,16.2,8,11.5);b.paint(cap,'Capacitor',(36,80,65))
 for c in (rear,yoke,slider):b.paint(c)
 m.finish('v2.2 two-switch rear housing and yoke')
 OUT.mkdir(parents=True,exist_ok=True)
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'two-switch-initial.f3d')))
 print(json.dumps({'document':doc.name,'body_counts':{o.component.name:o.component.bRepBodies.count for o in root.occurrences}}))
