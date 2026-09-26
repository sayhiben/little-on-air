import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('validate_native.py');s=importlib.util.spec_from_file_location('static26',str(p));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_CHECKS=set();v.RESULT_NAME='static-study.json';v.run(_context)
