import argparse,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from fusion_client import FusionClient,unpack
import json
p=argparse.ArgumentParser();p.add_argument('stage');a=p.parse_args()
builder=Path(__file__).with_name('build_v2.py').as_posix()
script=f"import importlib.util\ndef run(_context:str):\n s=importlib.util.spec_from_file_location('loa_v2',{builder!r});m=importlib.util.module_from_spec(s);s.loader.exec_module(m);m.run_stage({a.stage!r})\n"
result=unpack(FusionClient().call('fusion_mcp_execute',{'featureType':'script','object':{'script':script}}))
print(json.dumps(result,indent=2))
if isinstance(result,dict) and result.get('success') is False:sys.exit(1)
