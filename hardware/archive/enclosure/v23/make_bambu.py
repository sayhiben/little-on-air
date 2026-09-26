"""Native Bambu multi-plate packaging from the verified oriented STL meshes."""
from pathlib import Path
import json,zipfile,xml.etree.ElementTree as E,uuid,struct,copy
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output'/'v23';DEST=OUT/'bambu-studio'
CORE='http://schemas.microsoft.com/3dmanufacturing/core/2015/02';PROD='http://schemas.microsoft.com/3dmanufacturing/production/2015/06';REL='http://schemas.openxmlformats.org/package/2006/relationships'
E.register_namespace('',CORE);E.register_namespace('p',PROD)
def t(n):return '{'+CORE+'}'+n
def uid():return str(uuid.uuid4())
def md(parent,k,v):E.SubElement(parent,'metadata',key=k,value=str(v))
def xml(root):return E.tostring(root,encoding='utf-8',xml_declaration=True)
def mesh(path):
 raw=path.read_bytes();n=struct.unpack_from('<I',raw,80)[0];verts=[];tris=[];look={}
 for i in range(n):
  points=struct.unpack_from('<9f',raw,96+50*i);ids=[]
  for k in (0,3,6):
   p=tuple(points[k:k+3]);key=tuple(round(x,5) for x in p)
   if key not in look:look[key]=len(verts);verts.append(p)
   ids.append(look[key])
  tris.append(ids)
 center=[(min(v[a] for v in verts)+max(v[a] for v in verts))/2 for a in range(3)]
 return [[v[a]-center[a] for a in range(3)] for v in verts],tris,center
def build(manual=False,calibration=False):
 with zipfile.ZipFile(BASE/'output'/'bambu-studio'/'little-on-air-X1C-PETG-AMS-ready.3mf') as z:
  template={n:z.read(n) for n in ['[Content_Types].xml','_rels/.rels','Metadata/project_settings.config']}
 settings=json.loads(template['Metadata/project_settings.config'])
 values={'layer_height':'0.2','initial_layer_print_height':'0.2','wall_loops':'4','top_shell_layers':'5','bottom_shell_layers':'5','sparse_infill_density':'25%','sparse_infill_pattern':'gyroid','wall_generator':'arachne','enable_support':'0','brim_type':'no_brim','brim_width':'3','brim_object_gap':'0.15','outer_wall_speed':'60','inner_wall_speed':'100','top_surface_speed':'45','internal_solid_infill_speed':'100','sparse_infill_speed':'120','gap_infill_speed':'60','bridge_speed':'25','initial_layer_speed':'25','initial_layer_infill_speed':'40','default_acceleration':'3000','outer_wall_acceleration':'1500','enable_prime_tower':'0' if manual or calibration else '1','flush_into_infill':'0','flush_into_objects':'0','flush_into_support':'0'}
 for k,v in values.items():
  assert k in settings,k;settings[k]=[v]*len(settings[k]) if isinstance(settings[k],list) else v
 settings['scan_first_layer']='0'
 settings['filament_colour']=['#161616','#FFFFFF'];settings['filament_multi_colour']=['#161616','#FFFFFF'];settings['flush_volumes_matrix']=['0','700','220','0']
 settings['print_settings_id']='ON AIR v2 - PETG 0.20 structural, 0.10 graphic';settings['inherits_group']=['0.20mm Standard @BBL X1C','','','']
 old=settings['different_settings_to_system'][0].split(';');settings['different_settings_to_system']=[';'.join(sorted(set(old)|set(values))),'','','scan_first_layer']
 source={int(p.name[:2]):p for p in (OUT/'stl').glob('*.stl')}
 plates=[('01 Bezel and integrated rear housing',[(1,128,84),(5,128,174)]),('02 Optical retainer, yoke and controls',[(4,128,164),(6,128,103),(7,128,63)]),('03 Registered black and white graphic',[(3,128,128)])]
 if calibration:
  source.update({int(p.name[:2]):p for p in (OUT/'fit-samples').glob('*.stl')})
  plates=[('v2.3 measured-fit revisions - 6 parts',[(92,65,78),(93,103,78),(94,139,78),(98,176,78),(6,128,135),(7,128,174)])]
 settings['wipe_tower_x']=['22']*len(plates);settings['wipe_tower_y']=['185']*len(plates)
 entries={'[Content_Types].xml':template['[Content_Types].xml'],'_rels/.rels':template['_rels/.rels'],'Metadata/project_settings.config':json.dumps(settings,indent=2).encode()}
 model=E.Element(t('model'),{'unit':'millimeter','xml:lang':'en-US','requiredextensions':'p'});E.SubElement(model,t('metadata'),name='Application').text='BambuStudio-02.08.02.61'
 E.SubElement(model,t('metadata'),name='BambuStudio:3mfVersion').text='1';E.SubElement(model,t('metadata'),name='Title').text='Little ON AIR v2.3'
 resources=E.SubElement(model,t('resources'));build=E.SubElement(model,t('build'),{'{'+PROD+'}UUID':uid()});rels=E.Element('Relationships',xmlns=REL);config=E.Element('config');assemble=E.Element('assemble')
 serial=0
 for pi,(label,parts) in enumerate(plates):
  plate=E.SubElement(config,'plate');md(plate,'plater_id',pi+1);md(plate,'plater_name',label);md(plate,'locked','false');md(plate,'filament_map_mode','Auto For Flush')
  for part,x,y in parts:
   serial+=1;oid=serial*2;pid=oid-1;path=source[part];verts,faces,center=mesh(path)
   filename=f'3D/Objects/object_{serial}.model';sub=E.Element(t('model'),unit='millimeter');sr=E.SubElement(sub,t('resources'));ob=E.SubElement(sr,t('object'),id=str(pid),type='model');m=E.SubElement(ob,t('mesh'));vs=E.SubElement(m,t('vertices'));ts=E.SubElement(m,t('triangles'))
   for v in verts:E.SubElement(vs,t('vertex'),**{k:f'{q:.7f}' for k,q in zip('xyz',v)})
   for f in faces:E.SubElement(ts,t('triangle'),**{k:str(q) for k,q in zip(('v1','v2','v3'),f)})
   E.SubElement(sub,t('build'));entries[filename]=xml(sub)
   obj=E.SubElement(resources,t('object'),{'id':str(oid),'type':'model','{'+PROD+'}UUID':uid()});cs=E.SubElement(obj,t('components'));E.SubElement(cs,t('component'),{'objectid':str(pid),'{'+PROD+'}path':'/'+filename,'{'+PROD+'}UUID':uid(),'transform':'1 0 0 0 1 0 0 0 1 0 0 0'})
   E.SubElement(rels,'Relationship',Target='/'+filename,Id=f'rel{serial}',Type='http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel')
   tx=x+(pi%2)*307.2;ty=y-(pi//2)*307.2;transform=f'1 0 0 0 1 0 0 0 1 {tx} {ty} {center[2]:.7f}'
   E.SubElement(build,t('item'),{'objectid':str(oid),'printable':'1','transform':transform,'{'+PROD+'}UUID':uid()})
   ob=E.SubElement(config,'object',id=str(oid));md(ob,'name',path.name);md(ob,'extruder',1);md(ob,'enable_support',1 if part in (5,7,93) else 0);md(ob,'brim_type','outer_only');md(ob,'brim_width',3 if part in (1,5) else 2)
   if part not in (1,5):md(ob,'sparse_infill_density','100%');md(ob,'sparse_infill_pattern','zig-zag')
   if part in (3,7,97):md(ob,'layer_height','0.1')
   E.SubElement(ob,'metadata',face_count=str(len(faces)));p=E.SubElement(ob,'part',id=str(pid),subtype='normal_part',uuid=uid());md(p,'name',path.name);md(p,'matrix','1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1');md(p,'source_file',path.name);md(p,'source_object_id',0);md(p,'source_volume_id',0)
   for axis,c in zip('xyz',center):md(p,'source_offset_'+axis,f'{c:.7f}')
   E.SubElement(p,'mesh_stat',face_count=str(len(faces)),edges_fixed='0',degenerate_facets='0',facets_removed='0',facets_reversed='0',backwards_edges='0')
   inst=E.SubElement(plate,'model_instance');md(inst,'object_id',oid);md(inst,'instance_id',0);md(inst,'identify_id',serial)
   E.SubElement(assemble,'assemble_item',object_id=str(oid),instance_id='0',transform=transform,offset='0 0 0');E.SubElement(assemble,'assemble_item',object_id=str(oid),volume_id='0',transform='1 0 0 0 1 0 0 0 1 0 0 0')
 config.append(assemble)
 entries['3D/3dmodel.model']=xml(model);entries['3D/_rels/3dmodel.model.rels']=xml(rels);entries['Metadata/model_settings.config']=xml(config)
 if not calibration:
  custom=E.Element('custom_gcodes_per_layer');p=E.SubElement(custom,'plate');E.SubElement(p,'plate_info',id='3')
  E.SubElement(p,'layer',top_z='1.7',type='1' if manual else '2',extruder='1' if manual else '2',color='' if manual else '#FFFFFF',extra='Load white PETG, purge, then resume' if manual else '',gcode='M400 U1' if manual else 'tool_change')
  E.SubElement(p,'mode',value='SingleExtruder' if manual else 'MultiAsSingle');entries['Metadata/custom_gcode_per_layer.xml']=xml(custom)
 DEST.mkdir(exist_ok=True);name='on-air-v23-X1C-PETG-'+('fit-checks' if calibration else 'manual-swap' if manual else 'AMS')+'.3mf';p=DEST/name
 with zipfile.ZipFile(p,'w',zipfile.ZIP_DEFLATED) as z:
  for n,data in entries.items():z.writestr(n,data)
 print(p)
if __name__=='__main__':
 build();build(True)
 if list((OUT/'fit-samples').glob('*.stl')):build(calibration=True)
