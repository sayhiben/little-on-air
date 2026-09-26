"""Prepare the final side-notch cleanup and single-front fabrication outputs."""
from pathlib import Path
HERE=Path(__file__).resolve().parent;BASE=HERE.parent
text=(BASE/'v211/clean_top_seam.py').read_text(encoding='utf-8').replace('v211','v212').replace('v2.11','v2.12')
replacements={
 'Restore three obsolete top notch floors on the archived v2.10 front.':'Restore the remaining old side reset notch; inspect all sides and corners.',
 "BASE/'output/on-air-v210-beveled-front/cad/little-on-air-v210.f3d'":"BASE/'output/on-air-v211-clean-top-front/cad/little-on-air-v211.f3d'",
 'Little ON AIR v2.12 - clean top seam':'Little ON AIR v2.12 - complete perimeter cleanup',
 'and f.boundingBox.minPoint.y>5.7':'and f.boundingBox.minPoint.x>11.7',
 'assert len(faces)==3':'assert len(faces)==1',
 'good=len(fills)==3':'good=len(fills)==1',
 'Restore three legacy top seam recesses by 0.35 mm':'Restore obsolete right-side reset recess by 0.35 mm',
 'Join restored top rim':'Join restored right rim',
 'v2.12: three obsolete top seam notches closed.':'v2.12: final obsolete right-side reset notch closed; previous three top closures retained.',
 "regions=[{'name':'Charger legacy notch','lo':[14.8,57.6,9.15],'hi':[28.2,60,9.5]}, {'name':'MODE legacy notch','lo':[55.25,57.6,9.15],'hi':[64.75,60,9.5]}, {'name':'Old XIAO legacy notch','lo':[110.4,58.2,9.15],'hi':[117.5,60,9.5]}]":"regions=[{'name':'Old right-side reset notch','lo':[118.2,52.55,9.15],'hi':[120,56.85,9.5]}]",
 'Restored top rim':'Restored right rim',
 'remaining_obsolete_top_floor_count':'remaining_obsolete_side_floor_count',
 'outside these three regions':'outside the corrected region',
 'conservative enclosing boxes of the three restored top notches':'a conservative enclosing box of the restored right-side notch',
 "view('clean-top-seam.png'":"view('clean-top-left-seam.png'",
 '(135,180,45)':'(-75,180,45)',
}
for old,new in replacements.items():
 assert old in text,old;text=text.replace(old,new)
anchor=' before={o.component.name:'
assert anchor in text
text=text.replace(anchor," s=importlib.util.spec_from_file_location('full_rim_audit',str(BASE/'v212/perimeter_audit.py'));pa=importlib.util.module_from_spec(s);s.loader.exec_module(pa)\n perimeter_before=pa.audit(old)\n before={o.component.name:",1)
anchor=" (OUT/'native-validation.json').write_text(json.dumps(report,indent=2))"
assert anchor in text
text=text.replace(anchor," perimeter_after=pa.audit(new);assert perimeter_after['passed'],perimeter_after\n perimeter_report={'passed':True,'before':perimeter_before,'after':perimeter_after}\n report['full_perimeter_audit_passed']=True\n (OUT/'perimeter-validation.json').write_text(json.dumps(perimeter_report,indent=2))\n"+anchor,1)
anchor=" view('clean-assembly.png'"
assert anchor in text
text=text.replace(anchor," view('clean-right-bottom-seam.png',('01','05','06'),(190,-95,65),(60,30,-9),(0,0,1))\n"+anchor,1)
(HERE/'clean_perimeter.py').write_text(text,encoding='utf-8')
for name in ['prepare_print.py','audit_and_release.py']:
 text=(BASE/'v211'/name).read_text(encoding='utf-8').replace('v211','v212').replace('v2.11','v2.12').replace('clean-top-front','clean-perimeter-front').replace('clean top front','clean perimeter front')
 if name=='audit_and_release.py':
  text=text.replace("'slicing-validation.json','seam-wire-clearance.json']", "'slicing-validation.json','seam-wire-clearance.json','perimeter-validation.json']")
  text=text.replace("assert json.loads((OUT/'native-validation.json').read_text())['passed']", "assert json.loads((OUT/'native-validation.json').read_text())['passed']\nassert json.loads((OUT/'perimeter-validation.json').read_text())['passed']")
 (HERE/name).write_text(text,encoding='utf-8')
print('Prepared v2.12 perimeter cleanup and fabrication tools.')
