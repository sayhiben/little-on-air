from pathlib import Path
import subprocess,sys,json
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v24'
for name in ['validate_native.py','validate_harness.py','check_usb_space.py']:
 print('Checking '+name,flush=True)
 p=subprocess.run([sys.executable,str(HERE.parent/'fusion_client.py'),'--output',str(OUT/(name+'.result.json')),'run',str(HERE/name)],capture_output=True,text=True)
 (OUT/(name+'.log')).write_text(p.stdout+p.stderr,encoding='utf-8');p.check_returncode()
 print('Finished '+name,flush=True)
native=json.loads((OUT/'native-validation.json').read_text());wires=json.loads((OUT/'harness-validation.json').read_text());usb=json.loads((OUT/'usb-space-validation.json').read_text())
print(json.dumps({'features':native['feature_issues'],'static':native['interferences'],'failed_motion':[c for c in native['motion_checks'] if not c['passed']],'failed_wires':[i for i in wires['items'] if not i['passed']],'usb':usb['passed']},indent=2))
