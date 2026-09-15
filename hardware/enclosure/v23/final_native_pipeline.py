from pathlib import Path
import subprocess,sys,json
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v23'
assert json.loads((OUT/'harness-validation.json').read_text())['passed']
native=json.loads((OUT/'native-validation.json').read_text())
assert not native['feature_issues'] and not native['interferences'] and all(x['passed'] for x in native['motion_checks'])
for name in ['paint_final.py','export_native.py','make_fit_sections.py','capture_v2.py','save_archives.py']:
 print('Running '+name,flush=True)
 p=subprocess.run([sys.executable,str(HERE.parent/'fusion_client.py'),'run',str(HERE/name)],capture_output=True,text=True)
 (OUT/(name+'.log')).write_text(p.stdout+p.stderr,encoding='utf-8');p.check_returncode()
 if name=='validate_native.py':
  r=json.loads((OUT/'native-validation.json').read_text());assert not r['feature_issues'] and not r['interferences'] and all(x['passed'] for x in r['motion_checks']),r
 print('Complete '+name,flush=True)
