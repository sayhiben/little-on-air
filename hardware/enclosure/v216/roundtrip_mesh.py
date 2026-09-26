import adsk.core as C,adsk.fusion as F,adsk,json
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v216'
def run(_context:str):
 app=C.Application.get();doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(OUT/'little-on-air-v216.f3d')));doc.name='Little ON AIR v2.16 - rearward wiring release'
 d=F.Design.cast(app.activeProduct);result=[]
 for prefix,name in [('05','05-rear-electronics-housing.stl'),('06','06-electronics-retaining-yoke.stl')]:
  c=next(o.component for o in d.rootComponent.occurrences if o.component.name.startswith(prefix));q=c.bRepBodies.item(0)
  adsk.doEvents();app.activeViewport.refresh();adsk.doEvents()
  opt=d.exportManager.createSTLExportOptions(q,str(OUT/'meshes-assembly-coordinates'/name));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
  result.append({'name':name,'volume_mm3':q.volume*1000,'faces':q.faces.count,'triangles':(OUT/'meshes-assembly-coordinates'/name).stat().st_size})
 (OUT/'archive-roundtrip.json').write_text(json.dumps(result,indent=2));print(json.dumps(result))
