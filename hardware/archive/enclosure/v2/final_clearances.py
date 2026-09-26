import importlib.util
from pathlib import Path
def load(n):
 s=importlib.util.spec_from_file_location(n,str(Path(__file__).with_name(n+'.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def run(_context:str):
 m=load('build_v2');a=load('assembly_access');a.final_clearances(m)
 m.b.cutbox(m.b.comp('07 Captive reset plunger'),'Reset flange to upper port clearance',115.19,56.9,13.94,.82,.61,3.22)
 m.finish('final mechanical clearances')
