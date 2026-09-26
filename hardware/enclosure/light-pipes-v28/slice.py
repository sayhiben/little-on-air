from pathlib import Path
import subprocess,json
OUT=Path(__file__).resolve().parents[1]/'output/v28-light-pipes/bambu-studio'
src=OUT/'on-air-v28-clear-PETG-light-pipes.3mf';dst=OUT/'sliced';dst.mkdir(exist_ok=True)
with (dst/'slice.log').open('w') as log:
 p=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(dst.resolve()),'--export-3mf',src.name,str(src.resolve())],stdout=log,stderr=subprocess.STDOUT,cwd=dst,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
r=json.loads((dst/'result.json').read_text());print(json.dumps(r,indent=2));assert p.returncode==0 and r['return_code']==0
assert all(not x['warning_message'] for x in r['sliced_plates'])
