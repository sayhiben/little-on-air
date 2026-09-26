from pathlib import Path
import importlib.util,json,zipfile,xml.etree.ElementTree as E,subprocess
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v210'
def module(name,path):
 s=importlib.util.spec_from_file_location(name,str(path));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m

def main():
 m=module('orient29',BASE/'v28/prepare_meshes.py');m.OUT=OUT;m.main()
 a=module('package29',BASE/'v28/make_bambu.py');dest=OUT/'bambu-studio';dest.mkdir(exist_ok=True)
 filament_keys=set()
 for p in Path('C:/Program Files/Bambu Studio/resources/profiles/BBL/filament').glob('*.json'):
  filament_keys.update(json.loads(p.read_text(encoding='utf-8')).keys())
 for material in ['eSUN-PLA-plus','PETG']:
  src=BASE/'output/on-air-v28-fabrication/bambu-studio'/f'on-air-v28-X1C-{material}-fit-checks.3mf'
  with zipfile.ZipFile(src) as z:entries={n:z.read(n) for n in ['[Content_Types].xml','_rels/.rels','Metadata/project_settings.config']}
  cfg=json.loads(entries['Metadata/project_settings.config'])
  for k,v in cfg.items():
   if (k in filament_keys or k.startswith('filament_')) and isinstance(v,list):cfg[k]=v[:1]
  cfg.update({'filament_colour':['#161616'],'filament_multi_colour':['#161616'],'filament_self_index':['1'],'filament_extruder_variant':['Direct Drive Standard'],
   'enable_support':'0','enable_prime_tower':'0','scan_first_layer':'0','flush_volumes_matrix':['0'],'flush_volumes_vector':['140','140'],
   'print_settings_id':'ON AIR v2.10 beveled front - structural 0.20 mm','inherits_group':['0.20mm Standard @BBL X1C','',''],
   'different_settings_to_system':[cfg['different_settings_to_system'][0],'','scan_first_layer'],'wipe_tower_x':['22'],'wipe_tower_y':['185']})
  entries['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
  path=OUT/'stl/01-front-optical-bezel.stl';verts,faces,center=a.mesh(path)
  model=E.Element(a.t('model'),{'unit':'millimeter','xml:lang':'en-US','requiredextensions':'p'});E.SubElement(model,a.t('metadata'),name='Application').text='BambuStudio-02.08.02.61';E.SubElement(model,a.t('metadata'),name='BambuStudio:3mfVersion').text='1'
  resources=E.SubElement(model,a.t('resources'));build=E.SubElement(model,a.t('build'),{'{'+a.PROD+'}UUID':a.uid()});rels=E.Element('Relationships',xmlns=a.REL);config=E.Element('config')
  filename='3D/Objects/object_1.model';sub=E.Element(a.t('model'),unit='millimeter');sr=E.SubElement(sub,a.t('resources'));ob=E.SubElement(sr,a.t('object'),id='1',type='model');mesh=E.SubElement(ob,a.t('mesh'));vs=E.SubElement(mesh,a.t('vertices'));ts=E.SubElement(mesh,a.t('triangles'))
  for v in verts:E.SubElement(vs,a.t('vertex'),**{k:f'{q:.7f}' for k,q in zip('xyz',v)})
  for f in faces:E.SubElement(ts,a.t('triangle'),**{k:str(q) for k,q in zip(('v1','v2','v3'),f)})
  E.SubElement(sub,a.t('build'));entries[filename]=a.xml(sub)
  ob=E.SubElement(resources,a.t('object'),{'id':'2','type':'model','{'+a.PROD+'}UUID':a.uid()});cs=E.SubElement(ob,a.t('components'));E.SubElement(cs,a.t('component'),{'objectid':'1','{'+a.PROD+'}path':'/'+filename,'{'+a.PROD+'}UUID':a.uid(),'transform':'1 0 0 0 1 0 0 0 1 0 0 0'})
  E.SubElement(rels,'Relationship',Target='/'+filename,Id='rel1',Type='http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel')
  transform=f'1 0 0 0 1 0 0 0 1 128 128 {center[2]:.7f}'
  E.SubElement(build,a.t('item'),{'objectid':'2','printable':'1','transform':transform,'{'+a.PROD+'}UUID':a.uid()})
  ob=E.SubElement(config,'object',id='2');a.md(ob,'name',path.name);a.md(ob,'extruder',1);a.md(ob,'enable_support',0);a.md(ob,'brim_type','outer_only');a.md(ob,'brim_width',3);a.md(ob,'brim_object_gap',.15);E.SubElement(ob,'metadata',face_count=str(len(faces)))
  p=E.SubElement(ob,'part',id='1',subtype='normal_part',uuid=a.uid());a.md(p,'name',path.name);a.md(p,'matrix','1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1');a.md(p,'source_file',path.name);a.md(p,'source_object_id',0);a.md(p,'source_volume_id',0)
  for axis,c in zip('xyz',center):a.md(p,'source_offset_'+axis,f'{c:.7f}')
  E.SubElement(p,'mesh_stat',face_count=str(len(faces)),edges_fixed='0',degenerate_facets='0',facets_removed='0',facets_reversed='0',backwards_edges='0')
  plate=E.SubElement(config,'plate');a.md(plate,'plater_id',1);a.md(plate,'plater_name','v2.10 beveled front frame - replace part 01 only');a.md(plate,'locked','false')
  inst=E.SubElement(plate,'model_instance');a.md(inst,'object_id',2);a.md(inst,'instance_id',0);a.md(inst,'identify_id',1)
  assemble=E.SubElement(config,'assemble');E.SubElement(assemble,'assemble_item',object_id='2',instance_id='0',transform=transform,offset='0 0 0');E.SubElement(assemble,'assemble_item',object_id='2',volume_id='0',transform='1 0 0 0 1 0 0 0 1 0 0 0')
  entries['3D/3dmodel.model']=a.xml(model);entries['3D/_rels/3dmodel.model.rels']=a.xml(rels);entries['Metadata/model_settings.config']=a.xml(config)
  target=dest/f'on-air-v210-X1C-{material}-beveled-front.3mf'
  with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
   for n,data in entries.items():z.writestr(n,data)
  sliced=dest/('sliced-'+material);sliced.mkdir(exist_ok=True)
  with (sliced/'slice.log').open('w') as log:
   r=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(sliced.resolve()),'--export-3mf',target.name,str(target.resolve())],stdout=log,stderr=subprocess.STDOUT,cwd=sliced,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
  report=json.loads((sliced/'result.json').read_text());assert r.returncode==0 and report['return_code']==0 and all(not x['warning_message'] for x in report['sliced_plates'])
  print(json.dumps({'material':material,'seconds':report['sliced_plates'][0]['total_predication'],'filaments':report['sliced_plates'][0]['filaments'],'warnings':[]}),flush=True)
if __name__=='__main__':main()
