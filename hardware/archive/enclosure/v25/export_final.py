"""Export the already validated active Fusion revision; do not rebuild it."""
from pathlib import Path
import subprocess, sys, json
HERE=Path(__file__).resolve().parent
OUT=HERE.parent/'output/v25'
n=json.loads((OUT/'native-validation.json').read_text())
assert not n['feature_issues'] and not n['interferences']
assert len(n['motion_checks'])==16 and all(c['passed'] for c in n['motion_checks'])
for f in ('harness-validation.json','wire-packing-validation.json','usb-space-validation.json','nut-access-validation.json','terminal-row-validation.json','reset-fit-validation.json'):
    assert json.loads((OUT/f).read_text())['passed'],f
for name in ('check_final_screw_space.py','paint_final.py','export_native.py','make_fit_sections.py','capture_v2.py','save_archives.py'):
    print('Exporting '+name,flush=True)
    p=subprocess.run([sys.executable,str(HERE.parent/'fusion_client.py'),'--output',str(OUT/(name+'.result.json')),'run',str(HERE/name)],capture_output=True,text=True)
    (OUT/(name+'.log')).write_text(p.stdout+p.stderr,encoding='utf-8')
    p.check_returncode()
    print('Finished '+name,flush=True)
