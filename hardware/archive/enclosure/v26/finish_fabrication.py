from pathlib import Path
import subprocess,sys
H=Path(__file__).resolve().parent
NUMPY='C:/Users/bmene/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'
stages=[(sys.executable,'export_final.py',['--already-painted']), (sys.executable,'prepare_meshes.py',[]), (sys.executable,'make_bambu.py',[]), (sys.executable,'material_projects.py',[]), (sys.executable,'esun_projects.py',[]), (NUMPY,'slice_and_audit_all.py',[]), (sys.executable,'routing_map.py',[])]
for python,name,args in stages:
 print('Preparing '+name,flush=True)
 subprocess.run([python,str(H/name),*args],check=True)
 print('Finished '+name,flush=True)
