import importlib.util
from pathlib import Path
def load(n):
 s=importlib.util.spec_from_file_location(n,str(Path(__file__).with_name(n+'.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def run(_context:str):
 m=load('build_v2');a=load('assembly_access');a.reinforce(m);c=m.b.comp('06 Electronics retaining yoke');m.b.union(c);m.b.paint(c);m.finish('broad port cap roots')
