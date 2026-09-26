import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('paths24',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(rear,'Lowered XIAO insertion path',110.5,34.3,11.6,1.5,2.25,20.1)
 b.box(yoke,'Removable robust XIAO lower stop',110.3,34.1,11.3,1.8,2.45,3.1);b.union(yoke)
 b.cutbox(yoke,'Internal USB roof clears full reset flange travel',114.65,57.4,12.2,.55,.95,5.4)
 b.comp('REF XIAO').description='v2.4: 0.8 mm inward from v2.3; reset installed first, board enters 8 mm low then slides upward'
 for name in ['switch_w','switch_h','switch_t','switch_throw','actuator_w','actuator_d','actuator_h']:
  b.design().userParameters.itemByName(name).comment='Measured after second physical fit test; body 9.1 x3.72 x3.36; actuator1.5 square x1.87, travel2.4'
 for c in (rear,yoke):b.paint(c)
 m.finish('Final board slide and reset travel clearances')
