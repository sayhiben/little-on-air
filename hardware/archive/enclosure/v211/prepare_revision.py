"""Reuse the validated single-front fabrication workflow for the seam cleanup."""
from pathlib import Path
HERE=Path(__file__).resolve().parent;BASE=HERE.parent
for name in ['prepare_print.py','audit_and_release.py']:
 text=(BASE/'v210'/name).read_text(encoding='utf-8').replace('v210','v211').replace('v2.10','v2.11').replace('beveled-front','clean-top-front').replace('beveled front','clean top front')
 if name=='audit_and_release.py':
  text=text.replace("['native-validation.json','mesh-validation.json','slicing-validation.json']", "['native-validation.json','mesh-validation.json','slicing-validation.json','seam-wire-clearance.json']")
  text=text.replace("assert json.loads((OUT/'native-validation.json').read_text())['passed']", "assert json.loads((OUT/'native-validation.json').read_text())['passed']\nassert json.loads((OUT/'seam-wire-clearance.json').read_text())['passed']")
 (HERE/name).write_text(text,encoding='utf-8')
print('Prepared v2.11 fabrication tools.')
