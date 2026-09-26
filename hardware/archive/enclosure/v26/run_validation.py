from pathlib import Path
import subprocess,sys,json
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
for name in sys.argv[1:] or ['validate_native.py','validate_nut_access.py','validate_terminal_rows.py','check_usb_space.py','validate_reset.py','validate_harness.py']:
 print('Checking '+name,flush=True)
 p=subprocess.run([sys.executable,str(H.parent/'fusion_client.py'),'--output',str(O/(name+'.result.json')),'run',str(H/name)],capture_output=True,text=True)
 (O/(name+'.log')).write_text(p.stdout+p.stderr);p.check_returncode()
 print('Finished '+name,flush=True)
