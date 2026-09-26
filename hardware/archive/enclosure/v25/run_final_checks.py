from pathlib import Path
import subprocess,sys,json
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v25'
for name in ['final_motion_checks.py','validate_nut_access.py','validate_terminal_rows.py','validate_harness.py','check_usb_space.py']:
 print('Checking '+name,flush=True)
 p=subprocess.run([sys.executable,str(HERE.parent/'fusion_client.py'),'--output',str(OUT/(name+'.result.json')),'run',str(HERE/name)],capture_output=True,text=True)
 (OUT/(name+'.log')).write_text(p.stdout+p.stderr,encoding='utf-8');p.check_returncode()
 print('Finished '+name,flush=True)
for name in ['nut-access-validation.json','terminal-row-validation.json','harness-validation.json','usb-space-validation.json']:
 d=json.loads((OUT/name).read_text());assert d['passed'],name
print('All final mechanical and harness checks passed',flush=True)
