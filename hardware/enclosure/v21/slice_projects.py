from pathlib import Path
import subprocess,json,time
OUT=Path(__file__).resolve().parents[1]/'output'/'v21'/'bambu-studio'
EXE=Path('C:/Program Files/Bambu Studio/bambu-studio.exe')
def main():
 reports=[]
 for name in ['AMS','manual-swap','fit-checks']:
  src=OUT/f'on-air-v21-X1C-PETG-{name}.3mf';dest=OUT/('sliced-'+name);dest.mkdir(exist_ok=True)
  with (dest/'slice.log').open('w') as log:
   start=time.monotonic();p=subprocess.run([str(EXE),'--slice','0','--debug','2','--outputdir',str(dest.resolve()),'--export-3mf',src.name,str(src.resolve())],stdout=log,stderr=subprocess.STDOUT,cwd=dest,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
  report={'project':name,'exit_code':p.returncode,'seconds':round(time.monotonic()-start,2)}
  if (dest/'result.json').exists():report['result']=json.loads((dest/'result.json').read_text())
  reports.append(report);print(json.dumps(report),flush=True)
  if p.returncode!=0:raise RuntimeError('Slicing failed: '+name)
 (OUT/'slicing-results.json').write_text(json.dumps(reports,indent=2))
if __name__=='__main__':main()
