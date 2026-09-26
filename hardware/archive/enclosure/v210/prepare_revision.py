"""Prepare the broader front revision without replacing the earlier release."""
from pathlib import Path
HERE=Path(__file__).resolve().parent;BASE=HERE.parent
for name in ['bevel_front.py','prepare_print.py','audit_and_release.py']:
 text=(BASE/'v29'/name).read_text(encoding='utf-8').replace('v29','v210').replace('v2.9','v2.10')
 if name=='bevel_front.py':
  replacements={
   'subtly beveled front frame':'broader beveled front frame',
   "[('outer',.8),('opening',.4)]":"[('outer',1.4),('opening',.8)]",
   'Outer perimeter 0.8 mm highlight':'Outer perimeter 1.4 mm highlight',
   'Display opening 0.4 mm highlight':'Display opening 0.8 mm highlight',
   '0.8 mm outer and 0.4 mm aperture':'1.4 mm outer and 0.8 mm aperture',
   'bb.minPoint.z>=-.0800001':'bb.minPoint.z>=-.1400001',
   'b.p(x+w/2,y+h/2,-.5)':'b.p(x+w/2,y+h/2,-.75)',
   'w/10,h/10,.1))':'w/10,h/10,.15))',
   "'outer_bevel_mm':.8,'aperture_bevel_mm':.4":"'outer_bevel_mm':1.4,'aperture_bevel_mm':.8",
   'all_geometry_deeper_than_0_8_mm_identical':'all_geometry_deeper_than_1_4_mm_identical',
   "'remaining_straight_aperture_wall_mm':1.2":"'remaining_straight_aperture_wall_mm':.8",
  }
  for old,new in replacements.items():
   assert old in text,old;text=text.replace(old,new)
 (HERE/name).write_text(text,encoding='utf-8')
print('Prepared v2.10 builder and fabrication tools.')
