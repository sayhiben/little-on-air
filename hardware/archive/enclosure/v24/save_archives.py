from pathlib import Path
import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 out=Path(__file__).resolve().parents[1]/'output/v24';app=C.Application.get();original=app.activeDocument;d=F.Design.cast(app.activeProduct);ex=d.exportManager
 def shape_signature(design):
  return {o.component.name:[round(b.volume*1000,5) for b in o.component.bRepBodies] for o in design.rootComponent.occurrences if not o.component.name.startswith('REF Harness')}
 before=shape_signature(d)
 assert ex.execute(ex.createSTEPExportOptions(str(out/'little-on-air-v24-assembly.step')))
 assert ex.execute(ex.createFusionArchiveExportOptions(str(out/'little-on-air-v24.f3d')))
 check=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(out/'little-on-air-v24.f3d')))
 try:
  clone=F.Design.cast(app.activeProduct);assert shape_signature(clone)==before
  bodies=C.ObjectCollection.create()
  for o in clone.rootComponent.occurrences:
   if o.component.name.startswith(('81','82','REF Harness')):continue
   for b in o.component.bRepBodies:bodies.add(b.createForAssemblyContext(o))
  inp=clone.createInterferenceInput(bodies);inp.areCoincidentFacesIncluded=False
  collisions=[{'one':i.entityOne.parentComponent.name,'two':i.entityTwo.parentComponent.name,'volume_mm3':i.interferenceBody.volume*1000} for i in clone.analyzeInterference(inp) if i.interferenceBody and i.interferenceBody.volume*1000>.001]
  assert not collisions,collisions
  yoke=next(o.component.bRepBodies.item(0) for o in clone.rootComponent.occurrences if o.component.name.startswith('06'))
  # Native containment enums: PointOutsidePointContainment is required at the old collision.
  assert yoke.pointContainment(C.Point3D.create(4,5.9,-1))==F.PointContainment.PointOutsidePointContainment
  report={'passed':True,'archive':'little-on-air-v24.f3d','component_volume_signatures_match':True,'static_interferences':collisions,'roof_clearance_point_outside':True}
  (out/'archive-roundtrip-validation.json').write_text(json.dumps(report,indent=2))
 finally:check.close(False);original.activate()
 print('Final native assembly and STEP saved; reimported archive matches and clears static interference')
