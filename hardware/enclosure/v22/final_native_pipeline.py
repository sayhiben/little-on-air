from pathlib import Path
import subprocess,sys,json
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v22'
report=json.loads((OUT/'harness-validation.json').read_text());assert report['passed'],report
(OUT/'meshes-assembly-coordinates').mkdir(exist_ok=True)
for name in ['make_fit_sections.py','capture_v2.py','export_native.py']:
 print('Running '+name,flush=True)
 p=subprocess.run([sys.executable,str(HERE.parent/'fusion_client.py'),'run',str(HERE/name)],capture_output=True,text=True)
 (OUT/(name+'.log')).write_text(p.stdout+p.stderr,encoding='utf-8');p.check_returncode()
 print('Complete '+name,flush=True)
