from pathlib import Path
H=Path(__file__).resolve().parent
names=['validate_slim.py','validate_harness.py','harness.py','validate_nut_access.py','check_usb_and_optical.py','render_and_export.py','export_optional.py','make_fit_sections.py','archive_roundtrip.py','prepare_meshes.py','make_bambu.py','material_projects.py','esun_projects.py','slice_and_audit_all.py','audit_bambu_v2.py','check_wire_packing.py','routing_map.py']
for name in names:
 text=(H.parent/'v27'/name).read_text(encoding='utf-8').replace('v27','v28').replace('v2.7','v2.8')
 if name=='render_and_export.py':text=text.replace("HERE/'build_slim.py'","HERE/'revise_fit.py'")
 if name=='validate_slim.py':text=text.replace('range(25)','range(33)')
 if name=='check_usb_and_optical.py':text=text.replace('range(25)','range(33)')
 if name=='make_bambu.py':text=text.replace("('v2.8 slim parallel-PCB fit - 4 parts',[(91,128,60),(99,128,104),(6,128,164),(7,128,198)])","('v2.8 charger stop and reset collar - 2 replacement parts',[(99,128,110),(7,128,155)])")
 if name=='slice_and_audit_all.py':text=text.replace("n=4 if 'fit-checks'","n=2 if 'fit-checks'")
 (H/name).write_text(text,encoding='utf-8')
print('Prepared revision-specific validation and export tools')
