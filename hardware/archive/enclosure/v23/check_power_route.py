from pathlib import Path
import importlib.util
def run(_context:str):
 p=Path(__file__).with_name('validate_harness.py');s=importlib.util.spec_from_file_location('power_route_check',str(p));v=importlib.util.module_from_spec(s);s.loader.exec_module(v)
 v.FILTER_NAMES={'P4'};v.RESULT_NAME='power-route-validation.json';v.run(_context)
