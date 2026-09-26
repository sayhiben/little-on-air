"""Apply later USB measurements to the first v2.3 native build, before validation."""
import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path

def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('ports23',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 # Preserve the full original right yoke nut-boss wall after the regional replacement.
 b.box(rear,'Preserve right yoke boss outer wall',106.45,33.8,11.4,.75,8.4,20.3)
 b.union(rear)
 m.hexcut(rear,'Right yoke nut clearance retained',103,38,13.6,3,6)
 # Move the reset brace below the port, leaving a full 0.33 mm side clearance.
 b.cutbox(rear,'Reset brace clearance to measured XIAO USB',114.9,53.1,17.4,1.2,5.35,3)
 b.box(rear,'Reset lower-side guide extension',114.95,52.1,14.7,5.05,1.6,2.7)
 m.xz(rear,'Reset broad lateral 45 degree brace',52.1,[(114.95,17.4),(117.7,17.4),(117.7,20.15)],.9)
 b.union(rear)
 # Measured charger USB: 8.85 across X, 3.1 high, face y59.65.
 for c in (rear,):
  b.box(c,'Charger port side allowance correction left',16.7,58.65,19.3,.075,1.35,4.2)
  b.box(c,'Charger port side allowance correction right',26.225,58.65,19.3,.075,1.35,4.2)
 b.box(yoke,'Charger roof to measured socket height',16.95,58.7,19.25,9.1,1.05,.55)
 # Corrected XIAO measurement: 3.17 mm socket thickness, 8.97 across depth.
 b.box(rear,'XIAO measured right port edge',116.07,58.1,17.45,.13,1.9,9.6)
 # Recut the reset bore through the enlarged removable roof.
 pts=[(54.4,13.5),(54.95,12.95),(57.05,12.95),(57.6,13.5),(57.6,15.6),(57.05,16.15),(54.95,16.15),(54.4,15.6)]
 b.union(yoke);m.yz(yoke,'Reset bore through measured USB roof',114.9,pts,5.2,True)
 b.cutbox(yoke,'XIAO PCB clearance in inner port roof',111.35,57.35,11.35,1.5,.65,18.2)
 # Replace only the USB reference solids. PCB and switch position are retained.
 for name,box in [('REF Charger',(17.075,53.25,20.1,8.85,6.4,3.1)),('REF XIAO',(112.6,53.15,17.75,3.17,6.4,8.97))]:
  c=b.comp(name)
  target=next(z for z in c.bRepBodies if 'USB' in z.name and 'envelope' in z.name)
  c.features.removeFeatures.add(target)
  b.box(c,'Measured USB-C socket envelope',*box);b.paint(c,'PCB green',(24,100,63))
 d=b.design()
 for name,val in [('charger_usb_width',8.85),('charger_usb_height',3.1),('charger_usb_overhang',1.25),('xiao_usb_width',8.97),('xiao_usb_height',3.17),('xiao_usb_overhang',1.75)]:
  p=d.userParameters.itemByName(name)
  if p:p.expression=str(val)+' mm'
  else:d.userParameters.add(name,b.vi(val),'mm','User measured September 10, 2026')
 for c in (rear,yoke):b.union(c);b.paint(c)
 issues=[]
 for i in range(d.timeline.count):
  e=d.timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:issues.append(e)
 for e in issues:
  assert 'No target body' in e.errorOrWarningMessage,(e.name,e.errorOrWarningMessage)
  e.deleteMe()
 m.finish('measured USB sockets and support clearance')
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(m.OUT/'measured-port-refinement.f3d')))
