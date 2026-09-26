"""Import the released v2 archive into a separate document; apply manufacturing delta."""
import adsk.core as C
import adsk.fusion as F
import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
def run(_context:str):
 app=C.Application.get();imp=app.importManager
 doc=imp.importToNewDocument(imp.createFusionArchiveImportOptions(str(HERE.parent/'output/on-air-v2-fabrication/cad/little-on-air-v2.f3d')))
 doc.name='Little On Air - Enclosure v2.1 - manufacturing and harness'
 spec=importlib.util.spec_from_file_location('v21',str(HERE/'build_v2.py'));m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);b=m.b
 d=F.Design.cast(app.activeProduct);d.rootComponent.attributes.add('LittleOnAirV21','Revision','2.1 manufacturing and harness')
 front=b.comp('01 Front optical bezel');rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke');ret=b.comp('04 Optical retainer');slider=b.comp('08 Captive DPDT power slider')
 # Captured hardware, not press fits. Preserve bearing planes and screw lengths.
 for c,points,nutfront in [(front,[(60,6),(60,54)],3.2),(rear,m.FAST,24.8),(rear,[(35,38),(103,38)],13.8)]:
  for x,y in points:
   m.hexcut(c,'v21 clearance M3 nut',x,y,nutfront-.2,3.0,6.0)
   side=1 if c==front or x<60 else -1
   b.cutbox(c,'v21 nut loading clearance',x if side>0 else x-4.5,y-3,nutfront-.2,4.5,6,3)
 for x,y in m.FAST:
  b.cutcyl(front,'v21 closure screw clearance',x,y,-.02,3.6,9.6)
  b.cutcyl(front,'v21 socket head clearance',x,y,-.02,6.8,3.22)
  b.cutcyl(rear,'v21 closure blind clearance',x,y,9.48,3.6,19.72)
 for x,y in [(60,6),(60,54)]:
  b.cutcyl(front,'v21 optical blind clearance',x,y,2.6,3.6,4.9)
  b.cutcyl(ret,'v21 optical screw clearance',x,y,7.45,3.6,1.65)
 for x,y in [(35,38),(103,38)]:
  b.cutcyl(rear,'v21 yoke blind clearance',x,y,11.38,3.6,6.82)
  b.cutcyl(yoke,'v21 yoke screw clearance',x,y,9.38,3.6,2.04)
 # Relieve keeper faces for measured, compressible pads rather than rigid PCB loading.
 for x in (13.1,26.9):
  for y in (34,51):b.cutbox(yoke,'v21 PCB axial clearance',x-.01,y-.01,22.85,2.02,2.02,.22)
 for x in (55.9,63.1):b.cutbox(yoke,'v21 DPDT axial clearance',x-.01,49.69,19.65,1.02,2.32,.22)
 b.cutbox(yoke,'v21 XIAO axial clearance',110.8,35.4,11.2,1.3,21.2,.25)
 # Retainer screw seats stay fixed; optical stack receives .45 mm compliant allowance.
 b.cutbox(ret,'v21 optical stack allowance',7.99,10.99,7.47,104.02,38.02,.255)
 for x in (40,80):
  for y in (5.2,49.2):b.cutbox(ret,'v21 LED cushion clearance',x-1.51,y-.01,4.34,3.02,5.62,.26)
 # Side solder exits: 4 mm wide, open to rear; never across an acrylic entry edge.
 for x in (40,80):
  for y in (6.8,53.2):
   for sx in (x-5.6,x+4.1):b.cutbox(front,'v21 LED solder-wire exit',sx,y-2,2.4,1.5,4,2.2)
 # More room for the real 1.42 mm actuator, retaining the front-open assembly fork.
 b.cutbox(slider,'v21 actuator running clearance',58.95,52.3,18,2.1,2.23,4.6)
 # Increase running slot depth/width without enlarging the captive flange aperture.
 b.cutbox(rear,'v21 reset guide running clearance',116.1,52.45,13.6,4.1,4.5,3.1)
 b.cutbox(yoke,'v21 reset roof running clearance',116.19,52.79,13.6,3.57,3.82,.12)
 for name,val in [('m3_hole',3.6),('nut_af',6),('head_d',6.8)]:d.userParameters.itemByName(name).expression=str(val)+' mm'
 for c in (front,rear,yoke,ret,slider):b.paint(c)
 m.finish('v2.1 tolerance and solder exits')
 print(json.dumps({'document':doc.name,'revision':'2.1'}))
