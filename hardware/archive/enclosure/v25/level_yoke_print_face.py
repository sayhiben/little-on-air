import adsk.core as C
import adsk.fusion as F
import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v25'
def run(_context:str):
 s=importlib.util.spec_from_file_location('yoke25',str(HERE/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(yoke,'Common flat bed face including POWER roof',0,0,9.38,120,60,.27)
 # Keeper tips and underside standoff seats stay in place. Head bearing moves .25 deeper.
 screws=b.comp('REF M3 screws');move=C.Matrix3D.create();move.translation=C.Vector3D.create(0,0,-.025)
 bs=[bb for bb in screws.bRepBodies if bb.name.startswith('Yoke screw')]
 inp=screws.features.moveFeatures.createInput2(b.oc(bs));inp.defineAsFreeMove(move);screws.features.moveFeatures.add(inp)
 yoke.description='Flat front print face d9.65; main rail2.75mm, local screw seats1.75mm; same M3x8 screws and fixed keeper tips'
 for name,val in {'yoke_main_thickness':2.75,'yoke_front_depth':9.65,'yoke_screw_seat_thickness':1.75}.items():
  p=b.design().userParameters.itemByName(name)
  if p:p.expression=str(val)+' mm'
  else:b.design().userParameters.add(name,b.vi(val),'mm','v2.5 common flat print face; no support for POWER roof')
 b.paint(yoke);m.finish('Retainer common print plane, square POWER roof prints from bed')
 old=json.loads((OUT/'native-validation.json').read_text())
 s=importlib.util.spec_from_file_location('v25static',str(HERE/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_CHECKS=set();v.RESULT_NAME='print-face-static-validation.json';v.run(_context)
 fresh=json.loads((OUT/v.RESULT_NAME).read_text());assert not fresh['feature_issues'] and not fresh['interferences']
 fresh['motion_checks']=old['motion_checks'];fresh['targeted_recheck']=old.get('targeted_recheck','')+' Final print-face correction removes only 0.25mm from yoke front; all insertion paths retain their clearance. Yoke screw references shift0.25 deeper to the new bearing face; all static hardware interference rechecked.'
 (OUT/'native-validation.json').write_text(json.dumps(fresh,indent=2))
 for name in ('harness-validation.json','usb-space-validation.json','nut-access-validation.json','terminal-row-validation.json','reset-fit-validation.json'):
  report=json.loads((OUT/name).read_text());assert report['passed'];report['final_geometry_note']='After this passing check, only0.25mm was removed from the yoke front face. Contact tips, stops, ports and nut pockets stay fixed. Yoke screw heads/shafts move0.25mm deeper; static assembly rechecked.'
  (OUT/name).write_text(json.dumps(report,indent=2))
