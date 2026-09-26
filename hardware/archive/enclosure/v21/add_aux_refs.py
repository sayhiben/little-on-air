import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).resolve().with_name('build_v2.py');s=importlib.util.spec_from_file_location('v21',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 c=b.component('REF Auxiliary LED supply and signal parts','Purchased boost; 17 x 10 x 1 mm insulated signal carrier; 8 x 11.5 mm maximum bulk capacitor')
 b.box(c,'Pololu U3V16F5 envelope',38,43.3,26,13.2,8.1,3)
 b.box(c,'Signal carrier 17x10x1',72,42.5,28.2,17,10,1)
 b.cyl(c,'C1 680uF 6.3V maximum 8x11.5',84,47.5,16.2,8,11.5)
 b.box(c,'AHCT buffer PFET and local passives',72.5,43,26.2,7,9,2)
 b.paint(c,'Auxiliary electronics',(32,116,72));m.finish('auxiliary component maximum envelopes')
