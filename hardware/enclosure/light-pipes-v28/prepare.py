from pathlib import Path
import importlib.util,json,zipfile,xml.etree.ElementTree as E
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v28-light-pipes'
def module(name,path):
 s=importlib.util.spec_from_file_location(name,str(path));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m

def main():
 m=module('mesh_orientation',BASE/'v28/prepare_meshes.py');m.OUT=OUT
 m.rotate=lambda v,part:(-v[2],-v[0],v[1])
 m.main()
 a=module('package_helpers',BASE/'v28/make_bambu.py')
 fm=module('filament_helpers',BASE/'v28/material_projects.py')
 with zipfile.ZipFile(BASE/'output/on-air-v28-fabrication/bambu-studio/on-air-v28-X1C-PETG-fit-checks.3mf') as z:
  entries={n:z.read(n) for n in ['[Content_Types].xml','_rels/.rels','Metadata/project_settings.config']}
 cfg=json.loads(entries['Metadata/project_settings.config']);preset=fm.resolve('Generic PETG')
 for k,v in preset.items():
  if k in cfg and k not in ('name','type','inherits','from','instantiation','compatible_printers','description'):cfg[k]=v
 for k,v in cfg.items():
  if (k.startswith('filament_') or k in ('nozzle_temperature','nozzle_temperature_initial_layer')) and isinstance(v,list):cfg[k]=v[:1]
 values={'layer_height':'0.1','initial_layer_print_height':'0.1','wall_loops':'1','top_shell_layers':'1','bottom_shell_layers':'1','top_shell_thickness':'0','bottom_shell_thickness':'0',
 'sparse_infill_density':'100%','sparse_infill_pattern':'alignedrectilinear','internal_solid_infill_pattern':'alignedrectilinear','top_surface_pattern':'alignedrectilinear','bottom_surface_pattern':'alignedrectilinear',
 'infill_direction':'0','infill_rotate_step':'0','detect_narrow_internal_solid_infill':'0','infill_combination':'0','wall_generator':'classic','enable_support':'0','brim_type':'no_brim',
 'outer_wall_speed':'20','inner_wall_speed':'20','top_surface_speed':'20','internal_solid_infill_speed':'20','sparse_infill_speed':'20','gap_infill_speed':'20','initial_layer_speed':'15','initial_layer_infill_speed':'15',
 'default_acceleration':'1000','outer_wall_acceleration':'500','enable_prime_tower':'0','scan_first_layer':'0','ironing_type':'no ironing','elefant_foot_compensation':'0.1','reduce_crossing_wall':'1'}
 for k,v in values.items():
  assert k in cfg,k
  cfg[k]=[v]*len(cfg[k]) if isinstance(cfg[k],list) else v
 cfg.update({'filament_settings_id':['ON AIR clear PETG - calibrate actual spool'],'filament_type':['PETG'],'filament_ids':['GFG99'],
 'filament_colour':['#D8EDF0'],'filament_multi_colour':['#D8EDF0'],'filament_extruder_variant':['Direct Drive Standard'],'filament_self_index':['1'],
 'fan_min_speed':['10'],'fan_max_speed':['30'],'overhang_fan_speed':['30'],'additional_cooling_fan_speed':['0'],'filament_max_volumetric_speed':['4'],
 'filament_notes':['Generic PETG thermal baseline 255 C / 70 C textured PEI. Low fan and 20 mm/s optical process. Dry and flow-calibrate the actual clear spool; confirm its specified temperature range.'],
 'print_settings_id':'ON AIR indicator guides - 0.10 mm aligned lengthwise','flush_volumes_matrix':['0'],'flush_volumes_vector':['140','140'],
 'inherits_group':['0.20mm Standard @BBL X1C','',''],'different_settings_to_system':[';'.join(sorted(values)),'','scan_first_layer'],'wipe_tower_x':['22'],'wipe_tower_y':['185']})
 entries['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
 model=E.Element(a.t('model'),{'unit':'millimeter','xml:lang':'en-US','requiredextensions':'p'});E.SubElement(model,a.t('metadata'),name='Application').text='BambuStudio-02.08.02.61'
 E.SubElement(model,a.t('metadata'),name='BambuStudio:3mfVersion').text='1';resources=E.SubElement(model,a.t('resources'));build=E.SubElement(model,a.t('build'),{'{'+a.PROD+'}UUID':a.uid()});rels=E.Element('Relationships',xmlns=a.REL);config=E.Element('config');assemble=E.Element('assemble')
 plate=E.SubElement(config,'plate');a.md(plate,'plater_id',1);a.md(plate,'plater_name','Complete sets: 2.95 / 3.05 / 3.15 mm fit, increasing bed Y');a.md(plate,'locked','false')
 serial=0;manifest=[]
 for ri,fit in enumerate((2.95,3.05,3.15)):
  for prefix,x in [('08-front-rgb',108),('09-charger',130),('09-charger',144)]:
   serial+=1;oid=serial*2;pid=oid-1;y=112+ri*14;path=OUT/'stl'/f'{prefix}-{fit:.2f}mm.stl';verts,faces,center=a.mesh(path)
   filename=f'3D/Objects/object_{serial}.model';sub=E.Element(a.t('model'),unit='millimeter');sr=E.SubElement(sub,a.t('resources'));ob=E.SubElement(sr,a.t('object'),id=str(pid),type='model');mesh=E.SubElement(ob,a.t('mesh'));vs=E.SubElement(mesh,a.t('vertices'));ts=E.SubElement(mesh,a.t('triangles'))
   for v in verts:E.SubElement(vs,a.t('vertex'),**{k:f'{q:.7f}' for k,q in zip('xyz',v)})
   for f in faces:E.SubElement(ts,a.t('triangle'),**{k:str(q) for k,q in zip(('v1','v2','v3'),f)})
   E.SubElement(sub,a.t('build'));entries[filename]=a.xml(sub)
   ob=E.SubElement(resources,a.t('object'),{'id':str(oid),'type':'model','{'+a.PROD+'}UUID':a.uid()});cs=E.SubElement(ob,a.t('components'));E.SubElement(cs,a.t('component'),{'objectid':str(pid),'{'+a.PROD+'}path':'/'+filename,'{'+a.PROD+'}UUID':a.uid(),'transform':'1 0 0 0 1 0 0 0 1 0 0 0'})
   E.SubElement(rels,'Relationship',Target='/'+filename,Id=f'rel{serial}',Type='http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel')
   transform=f'1 0 0 0 1 0 0 0 1 {x} {y} {center[2]:.7f}'
   E.SubElement(build,a.t('item'),{'objectid':str(oid),'printable':'1','transform':transform,'{'+a.PROD+'}UUID':a.uid()})
   ob=E.SubElement(config,'object',id=str(oid));a.md(ob,'name',path.name);a.md(ob,'extruder',1);a.md(ob,'enable_support',0);a.md(ob,'brim_type','no_brim');E.SubElement(ob,'metadata',face_count=str(len(faces)))
   p=E.SubElement(ob,'part',id=str(pid),subtype='normal_part',uuid=a.uid());a.md(p,'name',path.name);a.md(p,'matrix','1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1');a.md(p,'source_file',path.name);a.md(p,'source_object_id',0);a.md(p,'source_volume_id',0)
   for axis,c in zip('xyz',center):a.md(p,'source_offset_'+axis,f'{c:.7f}')
   E.SubElement(p,'mesh_stat',face_count=str(len(faces)),edges_fixed='0',degenerate_facets='0',facets_removed='0',facets_reversed='0',backwards_edges='0')
   inst=E.SubElement(plate,'model_instance');a.md(inst,'object_id',oid);a.md(inst,'instance_id',0);a.md(inst,'identify_id',serial)
   E.SubElement(assemble,'assemble_item',object_id=str(oid),instance_id='0',transform=transform,offset='0 0 0');E.SubElement(assemble,'assemble_item',object_id=str(oid),volume_id='0',transform='1 0 0 0 1 0 0 0 1 0 0 0')
   manifest.append({'object_id':oid,'source':path.name,'fit_mm':fit,'center_xy':[x,y]})
 config.append(assemble);entries['3D/3dmodel.model']=a.xml(model);entries['3D/_rels/3dmodel.model.rels']=a.xml(rels);entries['Metadata/model_settings.config']=a.xml(config)
 dest=OUT/'bambu-studio';dest.mkdir(exist_ok=True)
 with zipfile.ZipFile(dest/'on-air-v28-clear-PETG-light-pipes.3mf','w',zipfile.ZIP_DEFLATED) as z:
  for n,data in entries.items():z.writestr(n,data)
 (OUT/'plate-manifest.json').write_text(json.dumps(manifest,indent=2))
 print('Six watertight STL variants and one nine-object optical test plate prepared.')
if __name__=='__main__':main()
