import importlib.util
from pathlib import Path
def run(_context:str):
 s=importlib.util.spec_from_file_location('wired26',str(Path(__file__).with_name('prewired_access.py')));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.CHECK_ONLY=True;v.run(_context)
