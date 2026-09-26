"""Reference envelopes for the selected M3 hardware (not printable parts)."""
import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
import math
import json

def run(_context: str):
    spec=importlib.util.spec_from_file_location("loa_builder",str(Path(__file__).with_name("build_enclosure.py")))
    b=importlib.util.module_from_spec(spec); spec.loader.exec_module(b)
    c=b.component("REF M3 screws and nuts","Four M3 x 25 socket heads and M3 hex nuts; threads simplified")
    positions=((6,6),(114,6),(6,54),(96,54))
    for x,y in positions:
        sk=b.sketch(c,"M3 hex nut envelope",24.8); r=5.5/math.sqrt(3)
        b.polygon(sk,[(x+r*math.cos(i*math.pi/3),y+r*math.sin(i*math.pi/3)) for i in range(6)])
        b.extrude(c,sk,-2.4,"M3 hex nut envelope")
        b.cutcyl(c,"Unthreaded nut bore envelope",x,y,24.8,3.1,2.4)
    for x,y in positions:
        b.cyl(c,"M3 socket head",x,y,0.2,5.5,3.0)
        b.cyl(c,"M3 x 25 shaft",x,y,3.2,3.0,25.0)
    b.paint(c,"Fastener steel",(95,106,121))
    b.finish("fastener-reference")
    print(json.dumps({"screws":4,"nuts":4,"head_recess_mm":0.2,"rear_tip_clearance_mm":0.5,"rear_skin_mm":1.3}))
