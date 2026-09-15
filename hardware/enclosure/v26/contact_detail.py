import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get();g={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences}
 a=tm.copy(g['06 Electronics retaining yoke'][0]);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,.05);tm.transform(a,mat)
 assert tm.booleanOperation(a,tm.copy(g['07 Guided rounded reset button'][0]),F.BooleanTypes.IntersectionBooleanType)
 print(json.dumps({'volume':a.volume*1000,'min':[v*10 for v in a.boundingBox.minPoint.asArray()],'max':[v*10 for v in a.boundingBox.maxPoint.asArray()]}))
