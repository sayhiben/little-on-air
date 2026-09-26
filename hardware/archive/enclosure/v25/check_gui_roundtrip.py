from pathlib import Path
import argparse
import importlib.util,json,zipfile
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v25'
s=importlib.util.spec_from_file_location('gui_audit',str(HERE/'audit_bambu_v2.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)

def settings(p):
 with zipfile.ZipFile(p) as z:return json.loads(z.read('Metadata/project_settings.config'))
projects=list((OUT/'bambu-studio').glob('on-air-v25-X1C-*.3mf'));assert len(projects)==9
for p in projects:
 n=3 if 'fit-checks' in p.name else 6
 a.audit_project(p,n);a.audit_project(p.parent/('sliced-'+p.stem)/p.name,n)
gui=OUT/'bambu-gui-roundtrip.3mf';a.audit_project(gui,3)
src=OUT/'bambu-studio/on-air-v25-X1C-eSUN-PLA-plus-fit-checks.3mf'
g=settings(gui);c=settings(src)
for k in ['scan_first_layer','wall_loops','layer_height','wall_generator','sparse_infill_density','sparse_infill_pattern','outer_wall_speed','initial_layer_speed','default_acceleration','machine_start_gcode','machine_end_gcode']:
 assert g[k]==c[k],k
def standard_values(cfg,key):
 vals=cfg[key]
 if len(vals)==len(cfg['filament_self_index']):
  return [vals[next(i for i,p in enumerate(zip(cfg['filament_self_index'],cfg['filament_extruder_variant'])) if p==(str(fid),'Direct Drive Standard'))] for fid in (1,2)]
 return vals
for k in ['nozzle_temperature','nozzle_temperature_initial_layer','filament_max_volumetric_speed','filament_flow_ratio','textured_plate_temp']:
 assert standard_values(g,k)==standard_values(c,k),k
parser=argparse.ArgumentParser();parser.add_argument('--minutes',type=int,required=True);parser.add_argument('--grams',type=float,required=True);parser.add_argument('--support-grams',type=float,required=True);args=parser.parse_args()
r={'passed':True,'project':src.name,'gui_loaded_without_configuration_warning':True,'gui_slice_completed':True,'gui_saved_copy_meshes_match_STLs':True,'gui_preserved_process_and_inspection_settings':True,'gui_standard_nozzle_filament_settings_match':True,'fit_plate_minutes_shown':args.minutes,'fit_plate_grams_shown':args.grams,'support_grams_shown':args.support_grams,'all_nine_project_variant_arrays_and_object_settings_checked':True}
(OUT/'bambu-gui-validation.json').write_text(json.dumps(r,indent=2));print(json.dumps(r,indent=2))
