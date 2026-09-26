import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import re
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);out=Path(__file__).resolve().parents[1]/'output/v28/meshes-assembly-coordinates'
 for o in d.rootComponent.occurrences:
  if not o.component.name.startswith(('81','82')):continue
  visible=o.isLightBulbOn;o.isLightBulbOn=True
  try:
   name=re.sub(r'[^a-z0-9]+','-',o.component.name.lower()).strip('-')
   opt=d.exportManager.createSTLExportOptions(o.component,str(out/(name+'.stl')));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False
   assert d.exportManager.execute(opt)
  finally:o.isLightBulbOn=visible
 print('Unchanged optional laminate spacers exported with visibility enabled')
