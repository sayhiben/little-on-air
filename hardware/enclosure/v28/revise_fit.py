"""Small, archived v2.7 revision driven by the user's physical fit results."""
import adsk.core as C
import adsk.fusion as F
import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
BASE=HERE.parent
OUT=BASE/'output/v28'
s=importlib.util.spec_from_file_location('helpers28',str(BASE/'build_enclosure.py'))
b=importlib.util.module_from_spec(s);s.loader.exec_module(b);b.OUT=OUT

def run(_context:str):
 app=C.Application.get();OUT.mkdir(parents=True,exist_ok=True)
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE/'output/on-air-v27-fabrication/cad/little-on-air-v27.f3d')))
 doc.name='Little ON AIR v2.8 - charger corner stop and reset travel'
 rear=b.comp('05 Rear electronics housing');button=b.comp('07 Front guided reset button')
 before={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 # Restore the lower-edge stop across both solid PCB corner feet. Its depth
 # and 0.30 mm board-edge clearance remain the proven v2.7 dimensions.
 b.box(rear,'Full 17.5 mm charger lower edge stop',12.25,28.1,15,17.5,1.9,6.7)
 b.union(rear)
 f=next(f for f in button.features.extrudeFeatures if f.name=='Broad internal captive flange')
 extent=F.DistanceExtentDefinition.cast(f.extentOne)
 assert extent is not None
 old=extent.distance.expression
 assert abs(abs(extent.distance.value*10)-3.05)<.0001,old
 extent.distance.expression='-2.85 mm' if extent.distance.value<0 else '2.85 mm'
 button.description='Captive front reset: 2.85 mm collar, 0.80 mm available travel; unchanged resting tip and guides. Physical click/release must be verified.'
 b.design().userParameters.itemByName('reset_front_stroke').expression='0.80 mm'
 b.paint(rear);b.paint(button,'Button grey',(105,112,121))
 for o in b.root().occurrences:
  for sk in o.component.sketches:sk.isVisible=False
  o.component.isConstructionFolderLightBulbOn=False
 after={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 changed=[n for n in before if before[n]!=after[n]]
 assert set(changed)=={'05 Rear electronics housing','07 Front guided reset button'},changed
 report={'changed_components':changed,'old_collar_expression':old,'new_collar_mm':2.85,'old_travel_mm':.6,'new_travel_mm':.8,'charger_stop_width_mm':17.5,'charger_edge_freeplay_mm':.3,'volumes_before':before,'volumes_after':after}
 (OUT/'revision-changes.json').write_text(json.dumps(report,indent=2))
 assert b.design().exportManager.execute(b.design().exportManager.createFusionArchiveExportOptions(str(OUT/'revised-fit-checkpoint.f3d')))
 print(json.dumps({k:v for k,v in report.items() if not k.startswith('volumes')},indent=2))
