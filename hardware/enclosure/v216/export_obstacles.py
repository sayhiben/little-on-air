import adsk.core as C,adsk.fusion as F,json
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v216'
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);dest=OUT/'obstacles';dest.mkdir(exist_ok=True);data=[]
 for i,o in enumerate(d.rootComponent.occurrences):
  if o.component.name.startswith(('81','82','REF Harness')):continue
  file=f'{i:02d}.stl';opt=d.exportManager.createSTLExportOptions(o.component,str(dest/file));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False
  assert d.exportManager.execute(opt)
  data.append({'file':file,'name':o.component.name})
 (dest/'index.json').write_text(json.dumps(data,indent=2));print('Exported '+str(len(data))+' assembly obstacles.')
