import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('paths23',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(rear,'SPDT internal flange entry clears entire body sweep',30.935,57.35,9.45,20.13,1.25,16.8)
 b.cutbox(rear,'Deep reset cap removable-front clearance',117.35,53.3,9.45,2.8,5.35,5.2)
 # Keep a short guide projection; its underside is a local supported print surface.
 b.cutbox(rear,'Reset underside clears XIAO sliding USB path',114.9,52.0,17.4,1.2,6.5,3.1)
 # The PCB is inserted 8 mm below its final location, then translated toward the port.
 b.cutbox(rear,'XIAO lower axial entry opened for two-step assembly',111.35,34.95,11.6,1.55,1.61,20.15)
 b.box(yoke,'XIAO removable lower axial lock',111.35,35,11.35,1.5,1.55,2.55)
 b.box(yoke,'Reset inward stop broad support',112.8,52.9,11.4,1.15,1.8,2.2)
 b.union(yoke)
 b.cutbox(yoke,'Reset full flange travel pocket',113.95,53.65,12.2,1.0,4.7,4.7)
 b.cutbox(yoke,'Reset cap corner clearance to curved shell',119.4,57.7,9.4,.6,.95,8.1)
 for c in (rear,yoke):b.union(c);b.paint(c)
 m.finish('Assembly sweep corrections and captive reset clearance')
 assert b.design().exportManager.execute(b.design().exportManager.createFusionArchiveExportOptions(str(m.OUT/'assembly-path-refinement.f3d')))
