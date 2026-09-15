from pathlib import Path
import subprocess,sys
H=Path(__file__).resolve().parent
subprocess.run([sys.executable,str(H/'run_build.py'),'setup','front','rear','yoke','reset_and_misc'],check=True)
for name in ('refine_slim.py','loading_clearances.py','final_contacts.py','hardware_refs.py','select_final.py','hardware_clearances.py','validate_slim.py','validate_nut_access.py'):
 print('Running '+name,flush=True)
 subprocess.run([sys.executable,str(H.parent/'fusion_client.py'),'--output',str(H.parent/'output/v27'/(name+'.result.json')),'run',str(H/name)],check=True)
