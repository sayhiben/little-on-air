"""Validate the delivered files and bundle the fabrication package."""
import json
from pathlib import Path
import xml.etree.ElementTree as ET
import zipfile

HERE=Path(__file__).resolve().parent
OUT=HERE/"output"

def main():
    fusion=json.loads((OUT/"fusion-verification.json").read_text())
    meshes=json.loads((OUT/"mesh-verification.json").read_text())
    assert not fusion["feature_issues"] and not fusion["interferences"]
    assert fusion["all_occurrences_at_assembly_origin"]
    made=[c for c in fusion["components"] if not c["reference"]]
    assert len(made)==10 and all(c["body_count"]==1 and c["bodies"][0]["solid"] for c in made)
    assert len(meshes)==12 and all(m["watertight_edges"] for m in meshes)
    differences={}
    for mesh in meshes:
        if int(mesh["part"][:2])>=90: continue
        body=next(c for c in made if c["name"].startswith(mesh["part"][:2]))["bodies"][0]
        difference=abs(mesh["volume_mm3"]-body["volume_mm3"])/body["volume_mm3"]
        assert difference<0.002,(mesh["part"],difference)
        differences[mesh["part"]]=round(100*difference,5)
    archives=list((OUT/"print").glob("*.3mf")); assert len(archives)==12
    for path in archives:
        with zipfile.ZipFile(path) as archive:
            assert archive.testzip() is None
            model=ET.fromstring(archive.read("3D/3dmodel.model"))
            assert model.attrib["unit"]=="millimeter"
    for path in (OUT/"laser").glob("*.svg"):
        root=ET.fromstring(path.read_text())
        assert root.attrib["width"]=="104mm" and root.attrib["height"]=="38mm"
    checks={"status":"digital geometry checks passed; physical first-fit verification required",
        "manufactured_solids":10,"printable_parts":9,"fit_samples":3,
        "native_feature_errors":0,"detected_interferences_above_0_001_mm3":0,
        "watertight_print_meshes":12,"valid_millimetre_3mf_archives":12,
        "mesh_to_native_volume_difference_percent":differences}
    (OUT/"release-verification.json").write_text(json.dumps(checks,indent=2))
    guide=(HERE/"README.md").read_text().replace("output/views/","views/")
    (OUT/"ASSEMBLY.md").write_text(guide)
    files=[OUT/name for name in ("little-on-air-enclosure.f3d","little-on-air-assembly.step",
        "fit-coupons.f3d","ASSEMBLY.md","parts-manifest.json","fusion-verification.json",
        "mesh-verification.json","release-verification.json")]
    for directory in ("print","laser","views"):
        files.extend(p for p in (OUT/directory).rglob("*") if p.is_file())
    target=OUT/"little-on-air-fabrication-package.zip"
    with zipfile.ZipFile(target,"w",zipfile.ZIP_DEFLATED) as archive:
        for path in files:
            assert path.is_file() and path.stat().st_size>0,path
            archive.write(path,path.relative_to(OUT))
        for path in HERE.glob("*.py"):
            if path.name in ("inspect_fusion.py","recover_optics.py"): continue
            archive.write(path,"source/"+path.name)
        archive.write(HERE/"README.md","source/README.md")
    with zipfile.ZipFile(target) as archive:
        assert archive.testzip() is None
        count=len(archive.namelist())
    print(json.dumps({"package":str(target),"files":count,"size_bytes":target.stat().st_size,
        "verification":checks},indent=2))

if __name__=="__main__": main()
