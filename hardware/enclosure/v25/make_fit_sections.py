"""Clip production solids, retaining their real interfaces and bed orientation."""
import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output'/'v25'
def run(_context:str):
 app=C.Application.get();original=app.activeDocument;design=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get();temp=[]
 def get(prefix):return next(o.component.bRepBodies.item(0) for o in design.rootComponent.occurrences if o.component.name.startswith(prefix))
 for name,source,lo,hi in [('90 rear nut boss section','05',(0,0,-34),(12,12,-9.5)),('91 front screw recess section','01',(0,0,-11),(12,12,0)),('92 charger fit section','05',(9,27,-34),(33,60,-9.5)),('93 XIAO and reset fit section','05',(105.5,33,-34),(120,60,-9.5)),('94 DPDT fit section','05',(51,46,-34),(69,60,-9.5)),('95 optical bezel section','01',(34,0,-11),(65,17,0)),('96 optical retainer section','04',(34,0,-10),(65,17,0)),('97 optical spacing section','03',(34,11,-8),(65,17,0))]:
  center=C.Point3D.create(*[(lo[i]+hi[i])/20 for i in range(3)])
  ob=C.OrientedBoundingBox3D.create(center,C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*( (hi[i]-lo[i])/10 for i in range(3)))
  body=tm.copy(get(source));box=tm.createBox(ob)
  if not tm.booleanOperation(body,box,F.BooleanTypes.IntersectionBooleanType):raise RuntimeError('Fit section clipping failed')
  temp.append((name,body))
 lo=(28,46,-34);hi=(54,60,-9.5)
 center=C.Point3D.create(*[(lo[i]+hi[i])/20 for i in range(3)])
 box=tm.createBox(C.OrientedBoundingBox3D.create(center,C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
 body=tm.copy(get('05'))
 assert tm.booleanOperation(body,box,F.BooleanTypes.IntersectionBooleanType)
 temp.append(('98 SPDT power fit section',body))
 lo=(0,26,-34);hi=(120,60,-9.5)
 center=C.Point3D.create(*[(lo[i]+hi[i])/20 for i in range(3)])
 box=tm.createBox(C.OrientedBoundingBox3D.create(center,C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
 body=tm.copy(get('05'));assert tm.booleanOperation(body,box,F.BooleanTypes.IntersectionBooleanType)
 temp.append(('99 upper housing complete fit section',body))
 doc=app.documents.add(C.DocumentTypes.FusionDesignDocumentType);doc.name='Little ON AIR v2.5 - production fit sections';d=F.Design.cast(app.activeProduct);d.designType=F.DesignTypes.ParametricDesignType;d.unitsManager.distanceDisplayUnits=F.DistanceUnits.MillimeterDistanceUnits
 try:
  for name,body in temp:
   o=d.rootComponent.occurrences.addNewComponent(C.Matrix3D.create());c=o.component;c.name=name
   feature=c.features.baseFeatures.add();feature.startEdit();c.bRepBodies.add(body,feature);feature.finishEdit()
   path=OUT/'meshes-assembly-coordinates'/(name.replace(' ','-')+'.stl');opt=d.exportManager.createSTLExportOptions(c,str(path));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False
   if not d.exportManager.execute(opt):raise RuntimeError('Coupon export failed')
  if not d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'v25-production-fit-sections.f3d'))):raise RuntimeError('Fit archive failed')
 finally:original.activate()
 print(json.dumps({'actual_clipped_production_sections':len(temp)}))
