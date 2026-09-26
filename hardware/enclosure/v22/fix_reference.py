import importlib.util
from pathlib import Path

def run(_context:str):
 p=Path(__file__).with_name('build_v2.py')
 s=importlib.util.spec_from_file_location('fix_build',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 c=m.b.comp('REF SPDT power switch');m.b.union(c)
 print('Unified SPDT reference envelope',c.bRepBodies.count)
 p=Path(__file__).with_name('validate_native.py')
 s=importlib.util.spec_from_file_location('v22_native_validation',str(p));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.run(_context)
