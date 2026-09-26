from pathlib import Path
import subprocess,sys,json
H=Path(__file__).resolve().parent;O=H.parent/'output/v28'
NUMPY='C:/Users/bmene/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'
def native(name):
 print('Checking/exporting '+name,flush=True)
 subprocess.run([sys.executable,str(H.parent/'fusion_client.py'),'--output',str(O/(name+'.result.json')),'run',str(H/name)],check=True)
for name in ('validate_slim.py','validate_harness.py','validate_nut_access.py','check_usb_and_optical.py'):native(name)
subprocess.run([NUMPY,str(H/'check_wire_packing.py')],check=True)
for n in ('native-validation.json','harness-validation.json','wire-packing-validation.json','nut-access-validation.json','usb-and-optical-validation.json','changed-interface-validation.json'):assert json.loads((O/n).read_text())['passed'],n
for name in ('render_and_export.py','export_optional.py','make_fit_sections.py','archive_roundtrip.py'):native(name)
for name,exe in [('prepare_meshes.py',sys.executable),('make_bambu.py',sys.executable),('material_projects.py',sys.executable),('esun_projects.py',sys.executable),('slice_and_audit_all.py',NUMPY),('routing_map.py',sys.executable)]:
 print('Preparing '+name,flush=True)
 with (O/(name+'.log')).open('w') as log:subprocess.run([exe,str(H/name)],check=True,stdout=log,stderr=subprocess.STDOUT)
print('All fabrication checks and exports completed',flush=True)
