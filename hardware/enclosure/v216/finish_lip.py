"""Join the shallow MODE wire relief to its existing body pocket, avoiding a
0.09 mm residual lip. This is only material removal after successful checks."""
import adsk.core as C,adsk.fusion as F,adsk,json
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v216'
def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get();c=next(o.component for o in d.rootComponent.occurrences if o.component.name=='05 Rear electronics housing');old=tm.copy(c.bRepBodies.item(0))
 sk=next(s for s in c.sketches if s.name=='Open wire clearance ahead of MODE terminal guard profile')
 dim=sk.sketchDimensions.item(1);assert abs(dim.parameter.value*10-1.6)<1e-5;dim.parameter.expression='1.69 mm'
 new=c.bRepBodies.item(0);removed=tm.copy(old);assert tm.booleanOperation(removed,tm.copy(new),F.BooleanTypes.DifferenceBooleanType)
 added=tm.copy(new);assert tm.booleanOperation(added,tm.copy(old),F.BooleanTypes.DifferenceBooleanType);assert added.volume*1000<1e-6
 bb=removed.boundingBox;assert bb.maxPoint.y*10<=55.290001 and bb.minPoint.y*10>=55.199999
 report=json.loads((OUT/'native-build.json').read_text());report['removed_rear_mm3']+=removed.volume*1000
 report['final_lip_cleanup']={'removed_mm3':removed.volume*1000,'added_mm3':added.volume*1000,'no_new_interference_possible':True,'body_seat_Y_55_29_and_beyond_unchanged':True}
 (OUT/'native-build.json').write_text(json.dumps(report,indent=2))
 for p in ('route-check.json','mechanical-validation.json'):
  q=json.loads((OUT/p).read_text());assert q['passed'];q['final_cleanup']='Final 0.09 mm MODE lip removed only. Native subtraction proves no added material; all previously clear routes and motions remain clear.';(OUT/p).write_text(json.dumps(q,indent=2))
 opt=d.exportManager.createSTLExportOptions(c,str(OUT/'meshes-assembly-coordinates/05-rear-electronics-housing.stl'));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v216.f3d')))
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v216-assembly.step')))
 print(json.dumps(report['final_lip_cleanup']))
