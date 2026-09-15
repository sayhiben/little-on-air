"""Capture removable keepers when assembled and remove a tangent-only collar join."""
import importlib.util
from pathlib import Path
import json

def run(_context: str):
    spec=importlib.util.spec_from_file_location("loa_builder",str(Path(__file__).with_name("build_enclosure.py")))
    b=importlib.util.module_from_spec(spec); spec.loader.exec_module(b)
    shell=b.comp("01 Body and front frame"); back=b.comp("10 Wall back plate")
    # A 7 mm collar only touched the lower stop along a line. Overlap by 0.1 mm.
    sk=next(s for s in shell.sketches if s.name=="Internal reset guide collar profile")
    sk.sketchCurves.sketchCircles.item(0).radius=0.36
    for x,w in ((11.0,1.8),(29.6,2.2)):
        b.box(back,"Charger keeper capture rib",x,43.5,15.55,w,4.8,12.15)
    b.box(back,"Switch keeper capture rib",58.5,53.3,22.3,3.0,2.0,5.4)
    b.union(back,"Back with positive keeper retention")
    b.box(shell,"XIAO fork withdrawal stop",114.4,33.1,10.2,3.3,1.4,16.5)
    b.union(shell,"Body with captive XIAO fork")
    b.comp("05 Charger keeper").description="Slip-fit locating legs; captured by back-plate ribs when closed"
    b.comp("06 XIAO keeper").description="Side-inserted fork; install on tray before latching tray into body"
    b.comp("04 Optical and electronics tray").description="Rear removable carrier; three side spring latches; battery strap channels"
    b.paint(shell); b.paint(back); b.finish("positive-keeper-retention")
    print(json.dumps({"charger_switch_capture_gap_mm":0.15,"xiao_capture_gap_mm":0.2,"collar_diameter_mm":7.2}))
