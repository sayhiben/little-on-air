import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json,re
OUT=Path(__file__).resolve().parents[1]/'output'/'v22'
def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);ex=d.exportManager;manifest=[]
 dst=OUT/'meshes-assembly-coordinates';dst.mkdir(parents=True,exist_ok=True)
 for o in d.rootComponent.occurrences:
  c=o.component
  if c.name.startswith(('REF','02')):continue
  original_visibility=o.isLightBulbOn;o.isLightBulbOn=True
  slug=re.sub(r'[^a-z0-9]+','-',c.name.lower()).strip('-')
  opt=ex.createSTLExportOptions(c,str(dst/(slug+'.stl')));opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh
  opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.sendToPrintUtility=False
  if not ex.execute(opt):raise RuntimeError('STL export failed: '+slug)
  o.isLightBulbOn=original_visibility
  manifest.append({'name':c.name,'slug':slug,'bodies':c.bRepBodies.count})
 if not ex.execute(ex.createSTEPExportOptions(str(OUT/'little-on-air-v22-assembly.step'))):raise RuntimeError('STEP failed')
 if not ex.execute(ex.createFusionArchiveExportOptions(str(OUT/'little-on-air-v22.f3d'))):raise RuntimeError('Fusion archive failed')
 (OUT/'native-exports.json').write_text(json.dumps(manifest,indent=2));print(json.dumps(manifest))
