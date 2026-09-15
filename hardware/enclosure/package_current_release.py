"""Curate the current manufacturing release without regenerating fabrication data."""
from pathlib import Path
import csv, hashlib, io, json, subprocess, zipfile
import xml.etree.ElementTree as E

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]
DOCS=BASE/'release-docs'
OUT=ROOT/'release/little-on-air-enclosure-v2.13'
V28=BASE/'output/on-air-v28-fabrication'
V213=BASE/'output/on-air-v213-captive-light-guides'
PRINT=BASE/'output/on-air-v213-complete-print'
USERPRINT=BASE/'output/v213-complete/user-layout-release-check'
PROVENANCE={}

def write(rel,data,source=None):
    path=OUT/rel;path.parent.mkdir(parents=True,exist_ok=True)
    path.write_bytes(data.encode('utf-8') if isinstance(data,str) else data)
    if source:
        PROVENANCE[rel]={'source':str(source.relative_to(ROOT)).replace('\\','/'),'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'exact_copy':path.read_bytes()==source.read_bytes()}
    else:PROVENANCE[rel]={'source':'Consolidated for the current release','exact_copy':False}

def copy(source,rel):write(rel,source.read_bytes(),source)

def write_csv(rel,rows,source=None):
    stream=io.StringIO(newline='');csv.writer(stream).writerows(rows);write(rel,stream.getvalue(),source)

def make():
    OUT.mkdir(parents=True,exist_ok=True)
    for name in ['README.md','BUILD-AND-ASSEMBLY.md','LASER.md','FIRMWARE-STATUS.md','PRINTING.md']:
        copy(DOCS/name,name if name=='README.md' else 'guides/'+name)
    copy(DOCS/'LAMINATE-ALTERNATIVE.md','alternatives/laminate/README.md')
    copy(ROOT/'LICENSE','LICENSE')
    parts=[]
    for number,label,quantity,material,plate,revision in [
        ('01','Front frame',1,'Black PLA+',1,'v2.13'),
        ('03','Registered display backing',1,'Black and white PLA+',2,'v2.8 unchanged'),
        ('04','Optical retainer',1,'Black PLA+',1,'v2.8 unchanged'),
        ('05','Rear electronics housing',1,'Black PLA+',1,'v2.13'),
        ('06','Electronics yoke',1,'Black PLA+',1,'v2.8 unchanged'),
        ('07','Front reset button',1,'Black PLA+',1,'v2.8 unchanged'),
        ('08','Captive front RGB guide',1,'Transparent PETG',3,'v2.13'),
        ('09','Rear charger guide',2,'Transparent PETG',3,'v2.13 release; identical pair'),
        ('11','Rear guide keeper',1,'Black PLA+',1,'v2.13')]:
        parent=V213 if number in ('01','05','08','09','11') else V28
        matches=list((parent/'stl').glob(number+'-*.stl'));assert len(matches)==1
        p=matches[0];copy(p,'stl/'+p.name)
        parts.append([number,label,quantity,material,plate,revision,'stl/'+p.name])
    write_csv('PARTS.csv',[['Part','Description','Quantity','Material','Bambu plate','Geometry provenance','Release file']]+parts+[['02','Rear-engraved acrylic panel',1,'Clear PMMA measured 3.00-3.45 mm','Laser','Shared artwork unchanged since v2.8','laser/02-acrylic-REAR-engrave-and-cut.svg']])
    for p in (V213/'cad').iterdir():
        if p.is_file():copy(p,'cad/'+p.name)
    project='on-air-v213-X1C-all-plates.3mf';copy(USERPRINT/'final-sliced'/project,'bambu-studio/'+project)
    copy(USERPRINT/'user-layout-validation.json','validation/printing.json')
    change=json.loads((USERPRINT/'material-corrections.json').read_text())
    change['spare_keeper_removed_from_insert_plate']=True
    change['black_to_white_flush_mm3']=700
    write('validation/printing-source-manifest.json',json.dumps(change,indent=2),USERPRINT/'material-corrections.json')
    for name in ['native-validation.json','harness-validation.json','perimeter-validation.json','mesh-validation.json','build-record.json']:
        copy(V213/'validation'/name,'validation/cad-v213/'+name)
    for name in ['wire-packing-validation.json','usb-and-optical-validation.json','nut-access-validation.json','changed-interface-validation.json']:
        copy(V28/'validation'/name,'validation/unchanged-v28/'+name)
    for p in (V213/'views').glob('*.png'):copy(p,'reference/views/'+p.name)
    for p in (V28/'laser').iterdir():
        if p.name.startswith(('90-','91-','92-')):rel='laser/calibration/'+p.name
        elif p.name.startswith('03-'):rel='alternatives/laminate/'+p.name
        elif p.name.startswith('02-'):rel='laser/'+p.name
        else:continue
        copy(p,rel)
    for p in (V28/'optional-laminate').glob('*.stl'):copy(p,'alternatives/laminate/'+p.name)
    for name in ['routing-coordinates.json','harness-length-guide.csv']:copy(V28/name,'reference/'+name)

    # The wire paths are unchanged. Remove the obsolete thickness-comparison
    # footer; identify this as a harness diagram rather than an exact CAD view.
    route=E.parse(V28/'routing-map.svg').getroot();ns='{http://www.w3.org/2000/svg}'
    route.set('height','710');route.set('viewBox','0 0 1240 710')
    for node in route.iter(ns+'text'):
        if node.get('y')=='40':node.text='ON AIR v2.13 - retained harness routes - 120 x 60 x 24 mm'
        if node.text=='R1 inline':node.set('y','597')
    for parent in route.iter():
        for child in list(parent):
            if float(child.get('y','0'))>=600:parent.remove(child)
    group=next(route.iter(ns+'g'))
    E.SubElement(group,ns+'line',x1='400',y1='550',x2='400',y2='581',stroke='#b35568',attrib={'stroke-width':'1.5'})
    for y,text in [(622,'Harness diagram only. Guide keeper 11 and collar pockets are detailed in the current assembly views.'),(650,'Crossing lines may be at different depths. Follow routing-coordinates.json and the build guide.'),(678,'Leave service slack, keep the battery pouch free, and verify real solder joints and connectors before closing.')]:
        E.SubElement(group,ns+'text',x='64',y=str(y),attrib={'font-size':'15'}).text=text
    E.register_namespace('',ns[1:-1])
    write('reference/routing-map.svg',E.tostring(route,encoding='utf-8',xml_declaration=True),V28/'routing-map.svg')
    hardware=json.loads((V28/'hardware-layout.json').read_text())
    hardware.append({'type':'Rear light-guide keeper screw','xy':[6.5,42.3],'screw':'M3x8 button head','nut':'M3, 5.5 mm AF x 2.4 mm','nut_loading':'Lower into bay; slide 7.8 mm toward top under roof before fitting keeper','nut_roof_mm':2,'note':'See current Fusion/STEP for complete depth geometry; current native clamp/access audit is included.'})
    write('reference/fastener-layout.json',json.dumps({'units':'mm','view':'Front; x right, y up; depth measured behind front face','fasteners':hardware},indent=2),V28/'hardware-layout.json')

    wiring=(BASE/'v22/TWO-SWITCH-WIRING.md').read_text(encoding='utf-8')
    wiring='# Two-switch wiring - enclosure v2.13\n'+wiring.split('\n',1)[1]
    wiring+='\n\n## Firmware status for this release\n\nThe reserved output is XIAO D2/P0.28. The packaged firmware v0.1.2 still uses onboard RGB PWM only; it does not send NeoPixel data. See [firmware status](FIRMWARE-STATUS.md) before commissioning the external harness. The mechanical guide is [BUILD-AND-ASSEMBLY.md](BUILD-AND-ASSEMBLY.md).\n'
    write('guides/WIRING.md',wiring,BASE/'v22/TWO-SWITCH-WIRING.md')

    bom=list(csv.reader((V28/'BOM.csv').open(encoding='utf-8',newline='')))
    rows=[bom[0]]
    for part,label,qty,material,plate,revision,file in parts:
        rows.append(['P'+part,qty,label,material+'; supplied orientation',file+'; plate '+str(plate),'Make'])
    for row in bom[1:]:
        if row[0]=='P01-P07':continue
        if row[0] in ('H1','H4'):row[1]='9'
        if row[0]=='H1':row[4]='4 closure; 2 optical retainer; 2 electronics yoke; 1 rear guide keeper'
        if row[0]=='S1':row[4]='Integrated POWER nest; retained by yoke';row[5]='Owned; measured body fit retained'
        if row[0]=='S2':row[4]='Exposed fingernail slider; retained by yoke; open terminal channels'
        if row[0]=='LED1-4':row[5]='Owned; keep existing SMD components'
        rows.append(row)
    rows.append(['R_CHG','Only if required','Charger current-programming resistor replacement','Select for confirmed charger IC and battery permitted charge current; verify measured result','Existing resistor pads on charger; no new carrier or enclosure bay','Conditional; not an unconditional extra part'])
    write_csv('BOM.csv',rows,V28/'BOM.csv')

    checks=[
        ('Printer / spool','X1C 0.4 mm; actual black/white PLA+ and clear PETG; calibrated flow'),
        ('Current print set','Ten pieces; latest front and rear; one captive front guide; two rear guides; keeper 11'),
        ('Surface tolerance / seam','Critical mating faces checked; halves seat by hand; no trapped wire; seam reasonably flat'),
        ('Nine screws and nuts','All M3x8 button heads; 4 closure +2 optical +2 yoke +1 guide keeper; all inset'),
        ('Nut access','All entries clear; rear guide nut lowers into bay then slides under roof before keeper'),
        ('POWER SPDT','Measured 10.6x6x5.05 body; 19.73 flange; full detents without bracket or terminal clash'),
        ('MODE DPDT','9.1x3.72x3.36 body; two rows of three 0.7 legs with 1.85 gaps; body seated; no printed actuator'),
        ('Reset','Twenty clicks/releases before stop; no binding or PCB flex; current collar has 0.80 mm available stroke'),
        ('USB access','Both real cable overmolds latch and unplug without moving the boards'),
        ('Charger support','Both lower corners meet full-width stop; OUT solder clears raised seats'),
        ('Front guide','Internal collar caught by frame and yoke; nominal 0.25 axial play; actual LED remains clear'),
        ('Rear guides','Both collars caught by housing and keeper 11; nominal 0.20 axial play; actual LEDs remain clear'),
        ('LED modules','All four complete segment outlines fit; emitting faces toward clear acrylic edges'),
        ('Pigtails / capacitor / resistor','Insulated real bodies and bends fit reserved bays; polarity/pinout marked'),
        ('Wire routing','Outside diameters fit; staged depth crossings; service slack; no wires across pouch or guide keeper'),
        ('Acrylic stock','Confirmed laser-suitable PMMA; thickness measured at five points; range 3.00-3.45'),
        ('Optical cushion','Rear gap =0.45-(acrylic thickness-3.175); shims/compliant layer fill without bowing'),
        ('RF laser setup','Nova Plus24 60W RF profile; actual lens/focus/air recorded'),
        ('Kerf','Record plug and opening X/Y, top and bottom; outside outline offset by half full kerf'),
        ('Engraving','Record RF speed/min-max power/interval/passes; shallow even frosted fill; 0.05-0.15 mm target'),
        ('Registration','Rear SVG already mirrored; common datums; correct reading face; white letters behind acrylic with air gap'),
        ('Continuity without battery','S1 commons/throws; both independent S2 poles; unused throws insulated; no shorts'),
        ('POWER off','Load rail disconnected from charger OUT+; cell remains connected to charger'),
        ('PROGRAM','XIAO BAT+ and DATA each isolated from battery/pixel branch'),
        ('USB modes','POWER off and PROGRAM before either USB; one USB only; unplug before RUN'),
        ('Cell specification','Verify protection and maximum charge current; capacity alone is insufficient'),
        ('Charge test','Load disconnected; measured current within cell rating; normal termination'),
        ('Switch currents','Steady load within confirmed SPDT rating; startup/inrush checked; MCU branch within confirmed DPDT rating'),
        ('Firmware','External four-pixel output still required; included firmware v0.1.2 is onboard-RGB only'),
        ('External lighting after firmware','Verify data/color order and initial 12.5% ceiling across intended battery range'),
        ('Temperature','Measure intended brightness and charging closed-case tests; aim <=40 C at20-25 C ambient or lower cell-maker limit'),
        ('Final retention / wall mount','No unwanted movement; strap does not compress pouch; wall strips clear rear indicator holes')]
    write_csv('guides/COMMISSIONING.csv',[['Check','Acceptance / instruction','Measured result','Pass / date']]+[[k,v,'',''] for k,v in checks])

    # Firmware source is immutable and identified by commit. It is not promoted
    # to a new firmware release and no local build directory is used.
    commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    version=subprocess.check_output(['git','show','HEAD:VERSION'],cwd=ROOT,text=True).strip()
    source_zip=OUT/f'firmware/little-on-air-firmware-v{version}-source.zip';source_zip.parent.mkdir(exist_ok=True)
    # Once manufacturing files are tracked, keep them out of the firmware
    # snapshot so later packages cannot recursively include earlier releases.
    tracked_roots=subprocess.check_output(['git','ls-tree','--name-only','HEAD'],cwd=ROOT,text=True).splitlines()
    firmware_roots=[name for name in tracked_roots if name not in ('hardware','release')]
    assert 'src' in firmware_roots and 'apps' in firmware_roots
    subprocess.run(['git','archive','--format=zip','--prefix=little-on-air-firmware-v'+version+'/','-o',str(source_zip),'HEAD','--',*firmware_roots],cwd=ROOT,check=True)
    PROVENANCE[str(source_zip.relative_to(OUT)).replace('\\','/')]={'source':'Git tracked source snapshot','git_commit':commit,'firmware_version':version,'exact_copy':True}
    write('firmware/README.md',f'# Firmware source snapshot\n\nVersion **{version}**, commit `{commit}`. The source ZIP includes build, flashing and pairing instructions and LICENSE. It uses onboard RGB PWM only; the four external NeoPixels are not implemented. Read [firmware status](../guides/FIRMWARE-STATUS.md) and the enclosure USB operating procedure before flashing. No UF2/ELF or build toolchain is included.\n')
    write('validation/README.md','# Validation records\n\n`release-audit.json` checks this package after copying: inventory, source identity, STL topology, 3MF contents, SVG registration, disabled LightBurn review output, local guide links and ZIP checksums.\n\n`printing.json` is the completed three-plate slicer/mesh/toolpath audit. `cad-v213/` retains the completed native interference, motion, guide-retention, nut-access, harness and seam checks. `unchanged-v28/` retains the applicable earlier solder/USB/reset and wire-packing checks for unchanged interfaces. These are existing validation results; packaging did not rerun Fusion or change geometry. Paths in historical JSON records identify the original workspace provenance.\n\nPhysical fit, actual charge current, optical clarity and external-pixel firmware remain commissioning tasks described in the guides.\n')
    write('RELEASE-NOTES.md','# Current release contents\n\nThis consolidates the v2.13 frame, rear housing and captive guides with the unchanged v2.8 backing, optical retainer, electronics yoke and corrected reset button. The complete editable Fusion/STEP assembly is v2.13. Laser artwork and the optional laminate stack are unchanged.\n\nThe Bambu project retains the user\'s three-plate arrangement and painted insert. It restores black/white PLA+ and clear optical PETG profiles, and removes the user-identified spare guide keeper. The original edited file is preserved outside the release. All three plates were re-sliced and verified.\n\nDocumentation now gives one current assembly order, nine matching screws/nuts, direct DPDT actuation, full-width charger stop, corrected reset stroke, front and rear guide capture, the selected capacitor/resistor-only two-switch circuit and the firmware limitation. Old fit coupons and alternate-size guide sets are excluded from production files.\n')
    (OUT/'MANIFEST.json').write_text(json.dumps({'enclosure_version':'2.13','firmware_version':version,'firmware_commit':commit,'packaged_date':'2026-09-14','production_stl_count':9,'production_print_instances':10,'bambu_plates':3,'provenance':PROVENANCE},indent=2),encoding='utf-8')
    print(json.dumps({'release':str(OUT),'files':len(list(OUT.rglob('*'))),'firmware_source_commit':commit},indent=2))

if __name__=='__main__':make()
