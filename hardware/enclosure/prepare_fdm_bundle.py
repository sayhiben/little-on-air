"""Make a small fabrication-only delivery from checked native Fusion exports."""
import hashlib
import json
from pathlib import Path
import shutil
import struct
import xml.etree.ElementTree as ET
import zipfile

HERE=Path(__file__).resolve().parent
OUT=HERE/"output"
DEST=OUT/"fdm-and-acrylic"
SVG="http://www.w3.org/2000/svg"
INK="http://www.inkscape.org/namespaces/inkscape"
ET.register_namespace("",SVG)
ET.register_namespace("inkscape",INK)

NOTES={
    1:("Front face down", "Support internal ledges, the reset guide, and USB/slider opening roofs where needed."),
    3:("Flat black back down; letters up", "No supports. Black through Z=1.6 mm; white from Z=1.6 to 2.0 mm."),
    4:("LED fingers toward bed; board mounts up", "Support beneath the optical partition, which begins about 2.925 mm above the bed, and beneath projecting latches. Clean the latch slots."),
    5:("Broad U clip face down; locating pegs up", "Normally no supports; inspect the retaining tabs in preview."),
    6:("Outer fork face down; locating pegs up", "Normally no supports; use a brim if the narrow fingers lift."),
    7:("Wide finger stem end down; narrow contact tip up", "Use a small brim and selective support under the flange rim. Keep support off the sliding stem and contact tip."),
    8:("External finger pad down", "Selective supports under the projecting internal flange; keep the switch socket clear."),
    9:("Rear bridge face down; locating legs up", "Normally no supports; inspect the leg transitions."),
    10:("Flat wall-facing surface down; nut blocks up", "Inspect the short roofs over nut-loading slots. Avoid trapped supports in blind nut/screw pockets."),
}

def acrylic_svg():
    root=ET.parse(OUT/"laser"/"acrylic-rear-face.svg").getroot()
    assert root.attrib["width"]=="104mm" and root.attrib["height"]=="38mm"
    layers={g.attrib["id"]:g for g in root.findall(f"{{{SVG}}}g")}
    assert set(layers)=={"CUT","ENGRAVE"}
    for g in list(layers.values()): root.remove(g)
    root.find(f"{{{SVG}}}title").text="02 Acrylic: rear engraving and outline cut; 104 x 38 mm"
    ET.SubElement(root,f"{{{SVG}}}desc").text=(
        "Already mirrored for REAR-face engraving, including the keyed corner. Do not mirror again. "
        "Blue: fill engrave first. Red: vector cut last. No kerf compensation applied. "
        "Nominal stock 3.175 mm; measure actual thickness before fitting. All lettering is paths.")
    for key,label in (("ENGRAVE","01 ENGRAVE - blue fill - rear face"),("CUT","02 CUT - red outline - last")):
        group=layers[key]
        group.set(f"{{{INK}}}groupmode","layer"); group.set(f"{{{INK}}}label",label)
        root.append(group)
    assert len(root.findall(f".//{{{SVG}}}text"))==0
    assert layers["ENGRAVE"][0].attrib["fill-rule"]=="evenodd"
    path=DEST/"acrylic"/"02-acrylic-rear-engrave-and-cut.svg"
    ET.indent(root,space="  ")
    ET.ElementTree(root).write(path,encoding="utf-8",xml_declaration=True)
    # Layer metadata/order changes must not change either geometric path.
    check=ET.parse(path).getroot()
    for group in check.findall(f"{{{SVG}}}g"):
        assert group[0].attrib["d"]==layers[group.attrib["id"]][0].attrib["d"]
    return path

def main():
    for name in ("stl","fit-samples","acrylic"): (DEST/name).mkdir(parents=True,exist_ok=True)
    checks=json.loads((OUT/"mesh-verification.json").read_text())
    assert len(checks)==12 and all(c["watertight_edges"] for c in checks)
    manifest=[]
    for item in checks:
        part=int(item["part"][:2]); source=OUT/"print"/(item["part"]+".stl")
        target=DEST/("fit-samples" if part>=90 else "stl")/source.name
        shutil.copyfile(source,target)
        data=target.read_bytes(); n=struct.unpack_from("<I",data,80)[0]
        assert len(data)==84+50*n
        vertices=[]
        for i in range(n):
            values=struct.unpack_from("<12fH",data,84+50*i)
            vertices.extend(values[k:k+3] for k in (3,6,9))
        mins=[min(p[k] for p in vertices) for k in range(3)]
        assert all(abs(v)<0.0001 for v in mins)
        orientation,supports=NOTES.get(part,("As supplied, on Z=0","Check slot roofs and use the same settings as the mating part."))
        manifest.append({"file":str(target.relative_to(DEST)).replace("\\","/"),"quantity":1,
            "units":"mm","bounds_mm":item["print_bounds_mm"],"watertight":True,
            "orientation":orientation,"supports":supports,"sha256":hashlib.sha256(data).hexdigest()})
    assert len([m for m in manifest if m["file"].startswith("stl/")])==9
    artwork=acrylic_svg()
    (DEST/"manifest.json").write_text(json.dumps({"parts":manifest,
        "acrylic":{"file":artwork.relative_to(DEST).as_posix(),"size_mm":[104,38],
        "nominal_thickness_mm":3.175,"rear_face_already_mirrored":True,"kerf_compensated":False}},indent=2))
    lines=["# Little On Air: FDM and acrylic files", "",
        "Print one of each of the nine separate files in `stl/`. Part 02 is acrylic and has no STL.",
        "All STL coordinates are millimetres; import at 100% scale and select mm if asked.",
        "The supplied orientations place every part on Z=0. Keep them for the first slicing pass.","",
        "## FDM setup", "",
        "Starting setup: PETG, 0.4 mm nozzle, 0.2 mm layers, four walls on structural parts.",
        "Use solid infill for the small controls and keepers. Use your calibrated filament profile.",
        "The files are meshes, not sliced jobs: inspect the layer preview and add selective supports", 
        "where listed. The carrier has a supported partition; none of these files contains support geometry.","",
        "| Part | Bed orientation | Support / color notes |","| --- | --- | --- |"]
    for item in manifest:
        if item["file"].startswith("stl/"):
            label=Path(item["file"]).stem
            lines.append(f"| {label} | {item['orientation']} | {item['supports']} |")
    lines.extend(["","For part 03, add a manual filament change **after the 1.6 mm black base**,",
        "before printing any white lettering. With uniform 0.2 mm layers this is after eight",
        "black layers, then two white layers. STL does not store colors or pauses.","",
        "## Acrylic", "",
        "Use `acrylic/02-acrylic-rear-engrave-and-cut.svg` at **104 x 38 mm**.",
        "The stock is nominally **3.175 mm (1/8 inch)**. A 3.0 mm sheet needs its fit checked.",
        "Place the acrylic's eventual rear face upward. The lettering and keyed corner are",
        "already mirrored together: **do not mirror the file again**.","",
        "1. Blue ENGRAVE layer: fill/raster engrave the letters, leaving the letter holes clear.",
        "2. Red CUT layer: vector cut the single closed outside outline, after engraving.",
        "3. Flip the finished piece left-to-right for installation. ON AIR reads normally",
        "   through its front, and the keyed corner is at the upper left when viewed from the front.","",
        "All lettering is converted to paths; no font installation is required. The outline",
        "has no kerf offset. Calibrate the cut/engrave settings on scrap of the same acrylic",
        "and apply any needed kerf compensation in the laser software. Keep the light-entry edges clean.","",
        "## First-fit checks", "",
        "Start with the three files in `fit-samples/`, then the small keepers, plunger and slider.",
        "These check the M3 head/nut pockets, LED/acrylic interface and reset guide. The M3 sample",
        "is deliberately shorter than the case, so a 25 mm screw extends through that sample.",
        "Digital mesh checks passed; physical fit has not been tested. Confirm actual board",
        "and solder dimensions, reset travel, DPDT throw and acrylic thickness before full fabrication.","",
        "The back uses four M3 x 25 socket-head screws inserted from the front and four M3 nuts",
        "loaded sideways into the backplate's integral mounting blocks. No screw exits the rear face.","",
        "See `ASSEMBLY.md` for the full installation order and remaining measurements.",""])
    (DEST/"PRINT-AND-LASER.md").write_text("\n".join(lines))
    # Standalone assembly notes, without broken image paths or source reproduction commands.
    guide=(HERE/"README.md").read_text().split("## Reproduction")[0]
    guide=guide.replace("![Assembled enclosure in Fusion](output/views/assembled.png)","")
    guide=guide.replace("![Exploded Fusion assembly](output/views/exploded.png)","")
    start=guide.find("The exploded view separates")
    if start>=0: guide=guide[:start]
    intro=guide.find("This is a **first-fit prototype**")
    guide="# Little On Air assembly\n\n"+guide[intro:]
    (DEST/"ASSEMBLY.md").write_text(guide)
    target=OUT/"little-on-air-fdm-and-acrylic.zip"
    with zipfile.ZipFile(target,"w",zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(DEST.rglob("*")):
            if path.is_file(): archive.write(path,path.relative_to(DEST))
    with zipfile.ZipFile(target) as archive: assert archive.testzip() is None
    print(json.dumps({"package":str(target),"separate_stls":9,"fit_samples":3,
        "acrylic_svg":str(artwork),"instructions":str(DEST/"PRINT-AND-LASER.md"),
        "size_bytes":target.stat().st_size},indent=2))

if __name__=="__main__": main()
