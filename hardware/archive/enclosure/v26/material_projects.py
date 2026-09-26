"""Resolve installed factory material presets; retain X1C process and placement."""
from pathlib import Path
import json,zipfile
BASE=Path('C:/Program Files/Bambu Studio/resources/profiles/BBL/filament')
OUT=Path(__file__).resolve().parents[1]/'output/v26/bambu-studio'
def resolve(name):
 x=json.loads((BASE/(name+'.json')).read_text());r=resolve(x['inherits']) if x.get('inherits') else {};r.update(x);return r
def main():
 pla=resolve('Generic PLA');reports=[]
 for src in sorted(OUT.glob('*PETG-*.3mf')):
  if 'ready' in src.name:continue
  with zipfile.ZipFile(src) as z:raw={n:z.read(n) for n in z.namelist()}
  for material in ['PLA']:
   entries=dict(raw);cfg=json.loads(entries['Metadata/project_settings.config'])
   for k,v in pla.items():
    if k in cfg and k not in ('name','type','inherits','from','instantiation','compatible_printers','description'):
     cfg[k]=v*2 if isinstance(v,list) and len(v)==1 and isinstance(cfg[k],list) and len(cfg[k])==2 else v
   cfg['filament_settings_id']=['Generic PLA','Generic PLA'];cfg['filament_colour']=['#161616','#FFFFFF'];cfg['filament_multi_colour']=['#161616','#FFFFFF']
   cfg['filament_ids']=['GFL99','GFL99'];cfg['additional_cooling_fan_speed']=['0','0']
   cfg['print_settings_id']='ON AIR v2.6 '+material+' - calibrate actual spool and fit coupons'
   cfg['filament_notes']=['PLA+ uses Generic PLA as a starting point. Set spool maker temperatures and calibrate before printing.']*2 if 'plus' in material else ['Calibrate this PLA spool and print the fit samples first.']*2
   entries['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
   if 'Metadata/custom_gcode_per_layer.xml' in entries:entries['Metadata/custom_gcode_per_layer.xml']=entries['Metadata/custom_gcode_per_layer.xml'].replace(b'white PETG',b'white PLA')
   dest=src.with_name(src.name.replace('PETG',material))
   with zipfile.ZipFile(dest,'w',zipfile.ZIP_DEFLATED) as z:
    for n,data in entries.items():z.writestr(n,data)
   reports.append({'project':dest.name,'filament_type':cfg['filament_type'],'nozzle':cfg['nozzle_temperature'],'textured_bed':cfg['textured_plate_temp'],'max_volume':cfg['filament_max_volumetric_speed']})
 (OUT/'material-presets.json').write_text(json.dumps(reports,indent=2));print(json.dumps(reports))
if __name__=='__main__':main()
