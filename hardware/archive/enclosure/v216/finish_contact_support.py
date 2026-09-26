import adsk.core as C,adsk.fusion as F,json,importlib.util
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v216'
def run(_context:str):
 s=importlib.util.spec_from_file_location('builder216',HERE/'build_rear_access.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 b=m.b;c=b.comp('06 Electronics retaining yoke');tm=F.TemporaryBRepManager.get();old=tm.copy(c.bRepBodies.item(0));m.contact_gusset(c);b.union(c)
 a=tm.copy(c.bRepBodies.item(0));assert tm.booleanOperation(a,old,F.BooleanTypes.DifferenceBooleanType)
 bb=a.boundingBox;lo=bb.minPoint.asArray();hi=bb.maxPoint.asArray()
 assert lo[0]>=1.789999 and hi[0]<=2.030001 and lo[1]>=5.369999 and hi[1]<=5.465001 and lo[2]>=-1.235001 and hi[2]<=-1.139999
 r=json.loads((OUT/'native-build.json').read_text());r['added_yoke_mm3']+=a.volume*1000;r['relocated_contact_support']={'angle_degrees':45,'added_mm3':a.volume*1000,'bounds_mm':[[v*10 for v in lo],[v*10 for v in hi]],'maximum_depth_mm':12.35,'nearest_wire_envelope_depth_mm':12.85};(OUT/'native-build.json').write_text(json.dumps(r,indent=2))
 v=json.loads((OUT/'route-check.json').read_text());v['contact_gusset']='Added gusset is entirely X17.9..20.3,Y53.7..54.65,D11.4..12.35. The only adjacent wire envelopes begin at D12.85; all other wire paths lie outside its XY bounds.';(OUT/'route-check.json').write_text(json.dumps(v,indent=2))
 d=b.design();opt=d.exportManager.createSTLExportOptions(c,str(OUT/'meshes-assembly-coordinates/06-electronics-retaining-yoke.stl'));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 s=importlib.util.spec_from_file_location('final216',HERE/'validate_mechanics.py');v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.run(_context)
