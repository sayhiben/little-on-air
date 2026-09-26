"""Create a fresh-sliced diagnostic copy of the user's edited fit project."""
from pathlib import Path
import json,zipfile,subprocess,hashlib,copy,re,shutil,importlib.util

BASE=Path(__file__).resolve().parents[1]
SOURCE=BASE/'output/on-air-v22-fabrication/bambu-studio/on-air-v22-X1C-PLA-fit-checks2.3mf'
OUT=BASE/'output/on-air-v22-first-layer-recovery'
NAME='on-air-v22-X1C-eSUN-PLA-plus-fit-NO-FIRST-LAYER-SCAN.3mf'
STUDIO='C:/Program Files/Bambu Studio/bambu-studio.exe'

def archive(path):
 with zipfile.ZipFile(path) as z:return {n:z.read(n) for n in z.namelist()}
def write(path,entries):
 with zipfile.ZipFile(path,'w',zipfile.ZIP_DEFLATED) as z:
  for n,data in entries.items():z.writestr(n,data)
def commands(code):return [line.split(';',1)[0].strip() for line in code.splitlines() if line.split(';',1)[0].strip()]

def main():
 OUT.mkdir(exist_ok=True);work=OUT/'validation';work.mkdir(exist_ok=True)
 raw=archive(SOURCE);cfg=json.loads(raw['Metadata/project_settings.config']);fixed=copy.deepcopy(cfg)
 assert str(cfg['scan_first_layer'])=='1'
 fixed['scan_first_layer']='0'
 # Keep the machine override attached when Bambu restores the project presets.
 markers=fixed['different_settings_to_system'];markers[-1]=';'.join(sorted(set(filter(None,markers[-1].split(';')))|{'scan_first_layer'}))
 changed=[k for k in fixed if fixed[k]!=cfg[k]];assert set(changed)<= {'scan_first_layer','different_settings_to_system'}
 revised=dict(raw);revised['Metadata/project_settings.config']=json.dumps(fixed,indent=2).encode()
 for n in raw:
  if n!='Metadata/project_settings.config':assert revised[n]==raw[n]
 source_copy=work/'user-original.3mf';source_copy.write_bytes(SOURCE.read_bytes());write(work/NAME,revised)
 s=importlib.util.spec_from_file_location('geometry_audit',str(BASE/'audit_print_projects.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
 source_meshes,_,_=a.project_meshes(SOURCE)
 report={'source_file':str(SOURCE),'source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),'changed_settings':changed,'source_is_preserved':True,'printer_templates':{},'slices':{}}
 machine=Path('C:/Program Files/Bambu Studio/resources/profiles/BBL/machine')
 for include in json.loads((machine/'Bambu Lab X1 Carbon 0.4 nozzle.json').read_text())['include']:
  for k,v in json.loads((machine/(include+'.json')).read_text()).items():
   if 'gcode' in k:report['printer_templates'][k]={'matches_installed_factory':cfg[k]==v,'characters':len(v)}
 assert all(x['matches_installed_factory'] for x in report['printer_templates'].values())
 for variant,src in [('original',source_copy),('inspection-off',work/NAME)]:
  dest=work/variant;dest.mkdir(exist_ok=True)
  with (dest/'slice.log').open('w') as log:
   process=subprocess.run([STUDIO,'--slice','0','--debug','2','--outputdir',str(dest),'--export-3mf',src.name,str(src)],stdout=log,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
  result=json.loads((dest/'result.json').read_text());assert process.returncode==0 and result['return_code']==0,result
  assert len(result['sliced_plates'])==1 and not result['sliced_plates'][0]['warning_message'],result
  saved=dest/src.name;saved_entries=archive(saved);saved_cfg=json.loads(saved_entries['Metadata/project_settings.config'])
  expected=cfg if variant=='original' else fixed
  # Bambu may normalize serialization, so compare values instead of JSON whitespace.
  assert str(saved_cfg['scan_first_layer'])==str(expected['scan_first_layer'])
  for k in ['filament_settings_id','filament_type','nozzle_temperature','nozzle_temperature_initial_layer','textured_plate_temp','filament_flow_ratio','enable_support','layer_height','wall_loops','machine_start_gcode','machine_end_gcode']:
   assert saved_cfg[k]==expected[k],(k,saved_cfg[k],expected[k])
  meshes,_,_=a.project_meshes(saved);assert len(meshes)==len(source_meshes)==12
  # Match names to allow Bambu to renumber internal object IDs while saving.
  original_by_name={o['name']:o for o in source_meshes.values()}
  for o in meshes.values():assert a.canonical(o['triangles'])==a.canonical(original_by_name[o['name']]['triangles']),o['name']
  code=saved_entries['Metadata/plate_1.gcode'].decode();active=commands(code)
  scans=[c for c in active if re.match(r'M97[67](?:\s|$)',c)]
  pauses=[c for c in active if re.match(r'(?:M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',c)]
  assert not pauses,pauses
  assert 'M104 S0' in active and 'M140 S0' in active
  assert any(c.startswith('G29 A ') for c in active)
  assert '; Z_HEIGHT: 0.4' in code and '; Z_HEIGHT: 24.6' in code
  if variant=='original':assert 'M976 S1 P1' in scans and 'M977 S1 P60' in scans
  else:assert not scans,scans
  report['slices'][variant]={'slicer':result,'inspection_commands':scans,'user_pause_commands':pauses,'mesh_placements_match_user_file':True,'object_count':len(meshes),'bed_leveling_sequence_present':True,'normal_heater_shutdown_present':True,'scan_first_layer':saved_cfg['scan_first_layer']}
  print(variant,'sliced; inspection commands:',scans,'pauses:',pauses,flush=True)
 final=OUT/NAME;shutil.copyfile(work/'inspection-off'/NAME,final)
 report['final_sha256']=hashlib.sha256(final.read_bytes()).hexdigest();(work/'validation.json').write_text(json.dumps(report,indent=2))
 (OUT/'READ-ME.md').write_text('''# First-layer inspection recovery — your edited PLA fit plate

Open **on-air-v22-X1C-eSUN-PLA-plus-fit-NO-FIRST-LAYER-SCAN.3mf** in Bambu Studio as a project. It is a freshly sliced copy of your `PLA-fit-checks2.3mf`, preserving your eSUN PLA+ material, temperatures, geometry, placement and other settings. The only functional setting changed is `scan_first_layer`: on → off. The original file is untouched.

Your original uses the installed factory X1C printer command templates. Its freshly generated code contains the normal `M976 S1 P1` inspection request before layer two, and no user-pause command. This points to the inspection step as the next diagnostic target; it does not prove a firmware or sensor fault, or guarantee the cause of the reported hang.

Both copies sliced without warnings and all twelve object meshes/placements match your edited file. The recovery file contains no executable M976/M977 scan commands or user pauses. Bed leveling, nozzle wiping, normal heating and end-of-job heater shutdown remain. Automated first-layer inspection is disabled, so watch the first two layers yourself.

1. Cancel the stalled job from the printer screen. Let the machine cool and remove the previous first layer before restarting.
2. Open the new file as a complete project. Retain its embedded settings; replacing the printer preset may restore scanning. Keep **Bed leveling** enabled in the send dialog.
3. If **First Layer Inspection** is also enabled in the printer's Print Options, turn that one option off for this diagnostic retry. Flow calibration and bed leveling are separate settings.
4. Send this new project rather than resuming or reprinting the previous cached job. Watch it pass into layer two; inspect adhesion yourself.
5. If it still stalls, cancel it and record the exact HMS code, printer firmware version and where the head parks. If the same inspection timeout appears, first verify the newly sent job is this recovery file. A continued hang then needs printer-side diagnosis and logs; repeated hot-idle retries are not useful.

This is an inspection-off workaround, not a physically verified repair. The earlier geometry/slicing checks did not exercise the printer's inspection firmware. No printer setting was changed remotely and no job was started by the assistant.

The local `validation/validation.json` records the original and changed settings, factory-template comparison, both slices, and command/geometry checks.
''',encoding='utf-8')
 print('Recovery project:',final,flush=True)

if __name__=='__main__':main()
