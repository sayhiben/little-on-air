"""Check native solid fit, insertion, weight isolation and declared envelopes."""
from pathlib import Path
import json,hashlib
import cadquery as cq
from build import ROOT,OUT,box,cyl,slope,unslope

def main():
    body=cq.importers.importStep(str(OUT/'cad/01-weighted-shell.step')).val()
    cover=cq.importers.importStep(str(OUT/'cad/04-ballast-cover.step')).val()
    lens=cq.importers.importStep(str(OUT/'cad/05-led-diffuser.step')).val()
    original=cq.importers.importStep(str(ROOT/'reference/xiao-esp32s3-seeed.step')).val()
    xiao=slope(original.rotate((0,0,0),(1,1,1),120).translate((6.11,56.82,-6)))
    iv=body.intersect(xiao).Volume()
    assert iv<.001,('XIAO collision',iv)
    insertion=[]
    for dy in range(-80,1,2):
        v=body.intersect(xiao.translate((0,dy,2))).Volume()
        insertion.append({'front_offset_mm':dy,'collision_mm3':v})
    for dz in (1.75,1.5,1.25,1,.75,.5,.25,0):
        v=body.intersect(xiao.translate((0,0,dz))).Volume()
        insertion.append({'lowering_z_mm':dz,'collision_mm3':v})
    assert max(x['collision_mm3'] for x in insertion)<.001,insertion
    # USB overmould maximum 12 x 7 mm; 0.75 x 0.8 mm half clearance to port.
    plug=slope(box(-6,6,70.65,94,-7.2,-.2))
    assert body.intersect(plug).Volume()<.001
    # Nominal 10 x 10 x 1.6 WS2812B breakout and 5050 LED facing forward.
    pixel=box(-5,5,3.8,5.4,-11,-1).fuse(box(-2.5,2.5,2.2,3.8,-8.5,-3.5))
    assert body.intersect(pixel).Volume()<.001
    assert lens.intersect(pixel).Volume()<.001
    assert cover.intersect(pixel).Volume()<.001
    # Completed auxiliary-board and capacitor envelopes, including insulation.
    # These establish a reserved space; hand-soldered wire dressing still needs
    # the first-prototype check described in ASSEMBLY.md.
    auxiliary=box(-22.2,-18.2,16,34,19,31)
    capacitor=cyl(3.15,8.5,(15,9,4))
    for name,part in [('auxiliary',auxiliary),('capacitor',capacitor)]:
        assert body.intersect(part).Volume()<.001,(name,'shell collision')
        assert xiao.intersect(part).Volume()<.001,(name,'XIAO collision')
    # Segments are measured max envelopes, not a universal wheel-weight size.
    # 2 columns x 4 rows x 2 layers; individual max 19 x 11.5 x 4 mm incl. tape.
    weights=[]
    for z in (-12,-8):
        for x in (-19.5,.5):
            for y in (10,21.7,33.4,45.1):
                weights.append(box(x,x+19,y,y+11.5,z,z+4))
    for w in weights:
        assert body.intersect(w).Volume()<.001
        assert cover.intersect(w).Volume()<.001
    # A full empty pocket plus 2 mm protected roof verifies compartment closure.
    pocket=box(-20,20,9,57,-12,-2)
    roof=box(-20,20,9,57,-2,0)
    assert body.intersect(pocket).Volume()<.001
    assert abs(body.intersect(roof).Volume()-roof.Volume())<.01
    # Front-down support is removable through either full-size service opening.
    # No claim is made here about hand-soldered harnesses or physical tolerances.
    for n,s in [('xiao-reference',xiao),('pixel-envelope',pixel),
                ('ballast-envelopes',cq.Compound.makeCompound(weights))]:
        cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{n}.stl'),tolerance=.025,angularTolerance=.1)
    report={'passed':True,'xiao_model_source':'https://files.seeedstudio.com/wiki/SeeedStudio-XIAO-ESP32S3/res/seeed-studio-xiao-esp32s3-3d_model.zip',
      'xiao_model_sha256':hashlib.sha256((ROOT/'reference/xiao-esp32s3-seeed.step').read_bytes()).hexdigest(),
      'xiao_native_collision_mm3':iv,'xiao_front_insertion':insertion,
      'usb_overmould_envelope_mm':[12,7],'usb_outer_tip_local_y_mm':70.63,
      'pixel_pcb_mm':[10,10,1.6],'pixel_led_mm':[5,5,1.6],
      'auxiliary_envelope_mm':[18,12,4],'capacitor_envelope_mm':{'diameter':6.3,'length':8.5},
      'weight_segment_max_mm':[19,11.5,4],'weight_segment_count':16,
      'ballast_target_g_if_5g_segments':80,'weight_pocket_clearance_above_stack_mm':2,
      'weight_roof_min_mm':2,'minimum_front_bay_separator_mm':1.7,
      'physical_fit_verified':False,'oled_and_encoder':'Original Igor interfaces retained; purchased modules require first-article fit.'}
    (OUT/'validation/fit.json').write_text(json.dumps(report,indent=2))
    print(json.dumps(report,indent=2),flush=True)

if __name__=='__main__':main()
