"""Retrofit solid PETG light guides; the validated v2.8 housing is unchanged."""
import adsk.core as C
import adsk.fusion as F
import adsk,importlib.util,json,re
from pathlib import Path
BASE=Path(__file__).resolve().parents[1]
OUT=BASE/'output/v28-light-pipes'
s=importlib.util.spec_from_file_location('pipe_helpers',str(BASE/'build_enclosure.py'))
b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
SPECS=[('08 Front RGB light guide',103.605,55.006,-.8,17.5,-.8,.8),
       ('09 Upper charger light guide',14,49.4,17.6,23.9,20.5,1.2),
       ('10 Lower charger light guide',14,44.65,17.6,23.9,20.5,1.2)]

def run(_context:str):
 OUT.mkdir(parents=True,exist_ok=True)
 app=C.Application.get()
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE/'output/on-air-v28-fabrication/cad/little-on-air-v28.f3d')))
 doc.name='Little ON AIR v2.8 - retrofit PETG indicator guides'
 d=b.design(); before={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 d.userParameters.add('indicator_guide_diameter',b.vi(3.05),'mm','Fit alternatives 2.95, 3.05, 3.15 mm. Select by physical fit; do not scale the part.')
 for name,x,y,d0,d1,cd,ct in SPECS:
  c=b.component(name,'Solid light pipe, flat at Y-centre minus 0.7 mm. Friction located, with insertion stop collar; no LED preload.')
  b.cyl(c,'Optical shaft',x,y,d0,'indicator_guide_diameter',(14.7 if name.startswith('08') else d1)-d0)
  if name.startswith('08'):b.cyl(c,'Narrow 1.8 mm LED pickup clears USB metal',x,y,14.65,1.8,d1-14.65)
  b.cyl(c,'Insertion stop collar',x,y,cd,4.2,ct)
  b.union(c)
  b.cutbox(c,'Continuous flat printing face',x-3,y-4,d0-.01,6,3.3,d1-d0+.02)
  if not name.startswith('08'):b.cutbox(c,'Charger fence relief flat',x-3,y-3,d0-.01,1.2,6,d1-d0+.02)
  b.paint(c,'Clear acrylic',None)
 after={o.component.name:[q.volume*1000 for q in o.component.bRepBodies] for o in b.root().occurrences}
 assert all(after[k]==v for k,v in before.items()),'Original enclosure was modified'
 tm=F.TemporaryBRepManager.get();checks=[];fail=[]
 def overlap(a,z):
  aa=a.boundingBox;bb=z.boundingBox
  if any(getattr(aa.maxPoint,k)<=getattr(bb.minPoint,k)+1e-9 or getattr(bb.maxPoint,k)<=getattr(aa.minPoint,k)+1e-9 for k in 'xyz'):return 0
  t=tm.copy(a);assert tm.booleanOperation(t,tm.copy(z),F.BooleanTypes.IntersectionBooleanType);return t.volume*1000
 originals=[(o.component.name,q) for o in b.root().occurrences if o.component.name in before and not o.component.name.startswith(('81','82')) for q in o.component.bRepBodies]
 # Largest fit is the limiting assembled clearance. Include every rigid/reference body.
 d.userParameters.itemByName('indicator_guide_diameter').expression='3.15 mm'
 for name,*_ in SPECS:
  q=b.comp(name).bRepBodies.item(0)
  for n,z in originals:
   v=overlap(q,z)
   if v>.001:fail.append({'guide':name,'obstacle':n,'body':z.name,'mm3':v})
  checks.append({'part':name,'obstacles':len(originals),'largest_diameter_mm':3.15})
 # Ensure collars are genuine insertion stops against case material.
 for name,*_ in SPECS:
  q=tm.copy(b.comp(name).bRepBodies.item(0));m=C.Matrix3D.create()
  m.translation=C.Vector3D.create(0,0,-.01) # 0.1 mm toward rear
  tm.transform(q,m)
  target=b.comp('01 Front optical bezel' if name.startswith('08') else '05 Rear electronics housing').bRepBodies.item(0)
  v=overlap(q,target)
  checks.append({'part':name,'stop_probe_mm3':v,'passed':v>.001})
  if v<=.001:fail.append({'guide':name,'missing_stop':v})
 # Front guide inserts through the assembled empty bores from outside.
 front=b.comp(SPECS[0][0]).bRepBodies.item(0)
 for step in range(36):
  t=tm.copy(front);m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,step*.05);tm.transform(t,m)
  for n,q in originals:
   v=overlap(t,q)
   if v>.001:fail.append({'insertion_step':step,'obstacle':n,'mm3':v})
 # Charger guides are fitted before the charger PCB. Check 0..7 mm approach.
 for name,*_ in SPECS[1:]:
  for step in range(15):
   t=tm.copy(b.comp(name).bRepBodies.item(0));m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,step*.05);tm.transform(t,m)
   for n,q in originals:
    if n!='05 Rear electronics housing':continue
    v=overlap(t,q)
    if v>.001:fail.append({'guide':name,'rear_insertion_step':step,'obstacle':n,'mm3':v})
 report={'passed':not fail,'original_components_unchanged':True,'checks':checks,'failures':fail,
  'nominal_hole_diameter_mm':3.2,'guide_fit_diameters_mm':[2.95,3.05,3.15],
  'diametral_clearances_mm':[.25,.15,.05],'front_LED_gap_mm':.4,'charger_LED_gap_mm':.5,
  'front_projection_mm':.8,'rear_outlet_recess_mm':.1,'flat_offset_from_axis_mm':.7,'front_pickup_diameter_mm':1.8,'USB_side_clearance_mm':.32,'charger_fence_clearance_mm':.25,
  'retention':'Close sliding/friction fit with insertion stop collars. Not a positive latch; removable adhesive at collar is optional if axial retention is loose.',
  'limitation':'As-built bore size and optical transmission require physical checks; nominal reference LED heights are not measured optical package tolerances.'}
 (OUT/'native-validation.json').write_text(json.dumps(report,indent=2));assert not fail,fail
 dst=OUT/'meshes-assembly-coordinates';dst.mkdir(exist_ok=True)
 for fit in (2.95,3.05,3.15):
  d.userParameters.itemByName('indicator_guide_diameter').expression=f'{fit} mm'
  for name,*_ in SPECS[:2]:
   c=b.comp(name);slug=('08-front-rgb' if name.startswith('08') else '09-charger')+f'-{fit:.2f}mm'
   opt=d.exportManager.createSTLExportOptions(c,str(dst/(slug+'.stl')));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False
   assert d.exportManager.execute(opt)
 d.userParameters.itemByName('indicator_guide_diameter').expression='3.05 mm'
 for o in b.root().occurrences:
  for sk in o.component.sketches:sk.isVisible=False
  o.component.isConstructionFolderLightBulbOn=False
  o.isLightBulbOn=not o.component.name.startswith(('81','82'))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v28-light-pipes.f3d')))
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v28-light-pipes.step')))
 print(json.dumps(report,indent=2))
