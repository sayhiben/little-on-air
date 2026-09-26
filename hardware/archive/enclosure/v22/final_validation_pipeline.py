from pathlib import Path
import subprocess,sys,json
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v22'
for name in ['validate_native.py','validate_harness.py','capture_v2.py','save_archives.py']:
 print('Running '+name,flush=True)
 p=subprocess.run([sys.executable,str(HERE.parent/'fusion_client.py'),'run',str(HERE/name)],capture_output=True,text=True)
 (OUT/(name+'.log')).write_text(p.stdout+p.stderr,encoding='utf-8');p.check_returncode()
 if name=='validate_native.py':
  r=json.loads((OUT/'native-validation.json').read_text());assert not r['feature_issues'] and not r['interferences'] and all(x['passed'] for x in r['motion_checks'])
 if name=='validate_harness.py':assert json.loads((OUT/'harness-validation.json').read_text())['passed']
 print('Complete '+name,flush=True)
