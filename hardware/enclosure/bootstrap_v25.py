from pathlib import Path
B=Path(__file__).resolve().parent;D=B/'v25';D.mkdir(exist_ok=True);(B/'output/v25').mkdir(exist_ok=True)
names=['build_v2.py','start_revision.py','validate_native.py','validate_harness.py','check_usb_space.py','check_wire_packing.py','harness.py','paint_final.py','export_native.py','make_fit_sections.py','capture_v2.py','save_archives.py','prepare_meshes.py','make_bambu.py','material_projects.py','esun_projects.py','audit_bambu_v2.py','slice_and_audit_all.py','routing_map.py','check_package.py','check_gui_roundtrip.py','export_final.py']
for name in names:
 text=(B/'v24'/name).read_text(encoding='utf-8').replace('v24','v25').replace('v2.4','v2.5').replace('2.4 second physical','2.5 third physical')
 if name=='start_revision.py':
  text=text.replace('on-air-v23-fabrication','on-air-v24-fabrication').replace("('06 ','07 ','REF DPDT','REF Harness')","('07 ','REF XIAO','REF DPDT','REF Harness')").replace('second physical fit revision','third physical fit revision').replace('Inherited tested v2.3 solid','Inherited tested v2.4 solid')
 (D/name).write_text(text,encoding='utf-8')
print(D)
