"""Use the successful user-edited eSUN PLA+ material and factory printer templates."""
from pathlib import Path
import zipfile,json
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v25/bambu-studio'
SOURCE=BASE/'output/on-air-v22-first-layer-recovery/on-air-v22-X1C-eSUN-PLA-plus-fit-NO-FIRST-LAYER-SCAN.3mf'

def main():
 with zipfile.ZipFile(SOURCE) as z:user=json.loads(z.read('Metadata/project_settings.config'))
 # The saved user profile includes Standard and High Flow variants for filament 1.
 # This X1C project uses Standard only: retain the matching entry for each filament.
 indices=user['filament_self_index'];variants=user['filament_extruder_variant']
 standard=[next(i for i,(fid,variant) in enumerate(zip(indices,variants)) if str(fid)==str(n) and variant=='Direct Drive Standard') for n in (1,2)]
 # Filament scope is supplied by Bambu's own preset key list. Include temperatures,
 # cooling and extrusion, while retaining new geometry-specific process settings.
 filament_keys=set()
 for p in Path('C:/Program Files/Bambu Studio/resources/profiles/BBL/filament').glob('*.json'):
  d=json.loads(p.read_text(encoding='utf-8'));filament_keys.update(k for k in d if k not in ('name','type','inherits','from','instantiation','compatible_printers','compatible_prints','description','setting_id'))
 filament_keys.update(['filament_settings_id','filament_ids','filament_colour','filament_multi_colour'])
 for src in OUT.glob('on-air-v25-X1C-PLA-*.3mf'):
  with zipfile.ZipFile(src) as z:entries={n:z.read(n) for n in z.namelist()}
  cfg=json.loads(entries['Metadata/project_settings.config'])
  for key in filament_keys:
   if key in user and key in cfg:
    value=user[key]
    cfg[key]=[value[i] for i in standard] if isinstance(value,list) and len(value)==len(indices) else value
  cfg['filament_self_index']=['1','2'];cfg['filament_extruder_variant']=['Direct Drive Standard']*2
  for key in ('machine_start_gcode','machine_end_gcode','layer_change_gcode','time_lapse_gcode','change_filament_gcode'):cfg[key]=user[key]
  cfg['scan_first_layer']='0';cfg['different_settings_to_system'][-1]='scan_first_layer'
  # Keep two visible colors for the graphic. The fit plate uses the user's red spool.
  if 'fit-checks' not in src.name:
   cfg['filament_colour']=['#161616','#FFFFFF'];cfg['filament_multi_colour']=['#161616','#FFFFFF']
  cfg['print_settings_id']='ON AIR v2.5 eSUN PLA+ - inspection off'
  entries['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
  dest=src.with_name(src.name.replace('X1C-PLA-','X1C-eSUN-PLA-plus-'))
  with zipfile.ZipFile(dest,'w',zipfile.ZIP_DEFLATED) as z:
   for name,data in entries.items():z.writestr(name,data)
  print(dest.name)

if __name__=='__main__':main()
