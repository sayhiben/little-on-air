"""Carry forward validated manufacturing helpers without altering the prior release."""
from pathlib import Path
HERE=Path(__file__).resolve().parent
for name in ['build_v2.py','export_native.py','prepare_meshes.py','validate_native.py','make_fit_sections.py','capture_v2.py','make_bambu.py','material_projects.py','audit_bambu_v2.py','slice_and_audit_all.py','validate_harness.py','check_wire_packing.py']:
    text=(HERE.parent/'v21'/name).read_text(encoding='utf-8')
    text=text.replace("'v21'","'v22'").replace('/v21','/v22').replace('-v21','-v22').replace('v21-production','v22-production').replace('v2.1','v2.2')
    (HERE/name).write_text(text,encoding='utf-8')
(HERE.parent/'output/v22').mkdir(parents=True,exist_ok=True)
