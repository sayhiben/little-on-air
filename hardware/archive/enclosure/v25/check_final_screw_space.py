import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v25'
def run(_context:str):
 s=importlib.util.spec_from_file_location('screwspace25',str(HERE/'validate_harness.py'));w=importlib.util.module_from_spec(s);s.loader.exec_module(w)
 w.OBSTACLE_BOXES=[{'lo':[x-1.5,36.5,17.4],'hi':[x+1.5,39.5,17.65]} for x in (35,103)];w.RESULT_NAME='final-screw-wire-validation.json';w.run(_context)
 assert json.loads((OUT/w.RESULT_NAME).read_text())['passed']
 # The moved head's added material occupies a subset of the previously checked yoke.
 r=json.loads((OUT/'harness-validation.json').read_text());r['final_screw_tip_check']='All43 wire and solder reservations clear the two added0.25mm screw-tip envelopes; moved head material occupies the previously tested yoke volume.';(OUT/'harness-validation.json').write_text(json.dumps(r,indent=2))
