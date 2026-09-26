"""Configure a native Bambu Studio import without modifying its meshes."""
from pathlib import Path
import copy
import json
import zipfile
import xml.etree.ElementTree as ET

OUT = Path(__file__).parent / "output" / "bambu-studio"
CORE = "http://schemas.microsoft.com/3dmanufacturing/core/2015/02"
PROD = "http://schemas.microsoft.com/3dmanufacturing/production/2015/06"
ET.register_namespace("", CORE)
ET.register_namespace("p", PROD)
ET.register_namespace("BambuStudio", "http://schemas.bambulab.com/package/2021")

# Object ids in the native import; centers are local to each 256 mm plate.
PLATES = [
    ("01 Fit samples first", {20: (80, 128), 22: (128, 128), 24: (176, 128)}),
    ("02 Body and back", {2: (128, 90), 18: (128, 178)}),
    ("03 Carrier and controls", {6: (128, 148), 8: (68, 80), 10: (104, 80),
                                  12: (133, 80), 14: (156, 80), 16: (185, 80)}),
    ("04 Black and white backing", {4: (128, 128)}),
]


def metadata(parent, key, value):
    node = next((x for x in parent.findall("metadata") if x.get("key") == key), None)
    if node is None:
        node = ET.SubElement(parent, "metadata", key=key)
    node.set("value", str(value))


def build(manual=False):
    with zipfile.ZipFile(OUT / "imported-baseline.3mf") as source:
        entries = {n: source.read(n) for n in source.namelist()}
    settings = json.loads(entries["Metadata/project_settings.config"])
    values = {
        "layer_height": "0.2", "initial_layer_print_height": "0.2",
        "wall_loops": "4", "top_shell_layers": "5", "bottom_shell_layers": "5",
        "sparse_infill_density": "25%", "sparse_infill_pattern": "gyroid",
        "wall_generator": "arachne", "enable_support": "0",
        "support_type": "normal(auto)", "support_style": "snug",
        "support_threshold_angle": "30", "support_on_build_plate_only": "0",
        "support_top_z_distance": "0.2", "support_bottom_z_distance": "0.2",
        "support_interface_top_layers": "3", "support_interface_bottom_layers": "3",
        "support_interface_spacing": "0.3", "support_object_xy_distance": "0.35",
        "bridge_no_support": "0", "brim_type": "no_brim", "brim_width": "3",
        "brim_object_gap": "0.15", "outer_wall_speed": "60", "inner_wall_speed": "100",
        "top_surface_speed": "45", "internal_solid_infill_speed": "100",
        "sparse_infill_speed": "120", "gap_infill_speed": "60", "bridge_speed": "25",
        "initial_layer_speed": "25", "initial_layer_infill_speed": "40",
        "default_acceleration": "3000", "outer_wall_acceleration": "1500",
        "enable_prime_tower": "0" if manual else "1",
        "flush_into_infill": "0", "flush_into_objects": "0", "flush_into_support": "0",
    }
    for key, value in values.items():
        if key not in settings:
            raise KeyError(f"Setting not present in native profile: {key}")
        previous = settings[key]
        settings[key] = [value] * len(previous) if isinstance(previous, list) else value
    settings["filament_colour"] = ["#161616", "#FFFFFF"]
    settings["filament_multi_colour"] = ["#161616", "#FFFFFF"]
    settings["flush_volumes_matrix"] = ["0", "700", "220", "0"]
    settings["wipe_tower_x"] = ["22"] * 4
    settings["wipe_tower_y"] = ["185"] * 4
    # Bambu reloads unlisted process keys from its system preset. Explicitly
    # identify all customized settings so they survive opening and saving.
    settings["print_settings_id"] = "Little ON AIR - PETG 0.20 strength and detail"
    settings["inherits_group"] = ["0.20mm Standard @BBL X1C", "", "", ""]
    settings["different_settings_to_system"] = [";".join(sorted(values)), "", "", ""]
    entries["Metadata/project_settings.config"] = json.dumps(settings, indent=2).encode()

    model = ET.fromstring(entries["3D/3dmodel.model"])
    config = ET.fromstring(entries["Metadata/model_settings.config"])
    instances = {int(next(m.get("value") for m in i.findall("metadata") if m.get("key") == "object_id")): copy.deepcopy(i)
                 for p in config.findall("plate") for i in p.findall("model_instance")}
    positions = {}
    for index, (name, objects) in enumerate(PLATES):
        origin = ((index % 2) * 307.2, -(index // 2) * 307.2)
        plate = config.findall("plate")[index]
        metadata(plate, "plater_name", name)
        for instance in list(plate.findall("model_instance")):
            plate.remove(instance)
        for object_id, (x, y) in objects.items():
            positions[object_id] = (x + origin[0], y + origin[1])
            plate.append(instances[object_id])
    transforms = {}
    for item in model.find(f"{{{CORE}}}build"):
        object_id = int(item.get("objectid"))
        transform = item.get("transform").split()
        transform[9:11] = [f"{x:.6f}" for x in positions[object_id]]
        item.set("transform", " ".join(transform))
        transforms[object_id] = item.get("transform")
    for item in config.find("assemble"):
        if "instance_id" in item.attrib:
            item.set("transform", transforms[int(item.get("object_id"))])

    for obj in config.findall("object"):
        oid = int(obj.get("id"))
        metadata(obj, "enable_support", "1" if oid in (2, 6, 12, 14) else "0")
        if oid in (2, 6, 18, 8, 10, 12, 14, 16):
            metadata(obj, "brim_type", "outer_only")
            metadata(obj, "brim_width", "3" if oid in (2, 6, 18, 12, 14) else "2")
        if oid in (8, 10, 12, 14, 16, 20, 22, 24):
            metadata(obj, "sparse_infill_density", "100%")
            metadata(obj, "sparse_infill_pattern", "zig-zag")
        if oid == 4:
            metadata(obj, "sparse_infill_density", "100%")
            metadata(obj, "sparse_infill_pattern", "zig-zag")
    entries["3D/3dmodel.model"] = ET.tostring(model, encoding="utf-8", xml_declaration=True)
    entries["Metadata/model_settings.config"] = ET.tostring(config, encoding="utf-8", xml_declaration=True)
    custom = ET.Element("custom_gcodes_per_layer")
    plate = ET.SubElement(custom, "plate")
    ET.SubElement(plate, "plate_info", id="4")
    if manual:
        ET.SubElement(plate, "layer", top_z="1.8", type="1", extruder="1", color="", extra="Load white PETG and purge, then resume", gcode="M400 U1")
    else:
        ET.SubElement(plate, "layer", top_z="1.8", type="2", extruder="2", color="#FFFFFF", extra="", gcode="tool_change")
    ET.SubElement(plate, "mode", value="SingleExtruder" if manual else "MultiAsSingle")
    entries["Metadata/custom_gcode_per_layer.xml"] = ET.tostring(custom, encoding="utf-8", xml_declaration=True)
    path = OUT / f"little-on-air-X1C-PETG-{'manual-swap' if manual else 'AMS'}.3mf"
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as target:
        for name, data in entries.items():
            target.writestr(name, data)
    print(path)


if __name__ == "__main__":
    build()
    build(manual=True)
