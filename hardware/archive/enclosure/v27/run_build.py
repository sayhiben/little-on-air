from pathlib import Path
import sys, json
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from fusion_client import FusionClient,unpack
HERE=Path(__file__).resolve().parent
OUT=HERE.parent/'output/v27'
for stage in sys.argv[1:] or ['front','rear','yoke','reset_and_misc']:
 print('Building '+stage,flush=True)
 script="import importlib.util\ndef run(_context:str):\n    s=importlib.util.spec_from_file_location('slim',"+repr(str(HERE/'build_slim.py'))+");m=importlib.util.module_from_spec(s);s.loader.exec_module(m);m."+stage+"()\n"
 result=unpack(FusionClient().call('fusion_mcp_execute',{'featureType':'script','object':{'script':script}}))
 (OUT/(stage+'-result.json')).write_text(json.dumps(result,indent=2))
 if isinstance(result,dict) and result.get('success') is False:raise RuntimeError(result)
 print('Finished '+stage,flush=True)
