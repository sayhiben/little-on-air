"""Annotated native-mesh section and nominal wire-channel cross-section."""
from pathlib import Path
import importlib.util,json
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v215'
s=importlib.util.spec_from_file_location('sections214',BASE/'v214/inspect_sections.py')
m=importlib.util.module_from_spec(s);s.loader.exec_module(m)

def main():
    tri=m.a.stl(OUT/'meshes-assembly-coordinates/01-front-optical-bezel.stl')
    edges=m.segments(tri,5)
    path=' '.join(f'M{p[0]:.4f},{p[1]:.4f} L{q[0]:.4f},{q[1]:.4f}' for p,q in edges)
    report=json.loads((BASE/'output/v214/native-build.json').read_text())
    svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1400" height="1020" viewBox="0 0 1400 1020">',
         '<rect width="1400" height="1020" fill="#f4f6f8"/>',
         '<g font-family="Arial, sans-serif" fill="#17283b">',
         '<text x="34" y="49" font-size="30" font-weight="bold">ON AIR v2.15 — front-frame wire routing</text>',
         '<text x="34" y="82" font-size="19">Replace part 01 only. Front 129 × 69 mm; rear housing, acrylic and mounting locations remain unchanged.</text>',
         '<rect x="24" y="111" width="928" height="609" rx="14" fill="white" stroke="#d4dce4"/>',
         '<text x="43" y="143" font-size="21" font-weight="bold">Front-view coordinates · section 5 mm behind the face</text>',
         '<text x="43" y="168" font-size="16">Acrylic hidden. For assembly from the rear, left and right appear reversed.</text>',
         '<g transform="translate(58,635) scale(6.7,-6.7)">',
         '<rect x="-4.5" y="-4.5" width="129" height="69" rx="7.5" fill="#eceff2"/>',
         '<rect x="8" y="11" width="104" height="38" fill="white"/>',
         '<path d="M5.2 -.8 H114.8 A6 6 0 0 1 120.8 5.2 V54.8 A6 6 0 0 1 114.8 60.8 H5.2 A6 6 0 0 1 -.8 54.8 V5.2 A6 6 0 0 1 5.2 -.8 Z" fill="none" stroke="#9cdde9" stroke-width="4.2"/>']
    for q in report['led_access_windows']:
        svg.append(f'<rect x="{q["x"]}" y="{q["y"]}" width="{q["width"]}" height="{q["height"]}" fill="#9cdde9"/>')
    svg.append(f'<path d="{path}" fill="none" stroke="#394b5d" stroke-width=".16"/>')
    svg.append('<rect x="0" y="0" width="120" height="60" rx="3" fill="none" stroke="#718091" stroke-width=".17" stroke-dasharray="1 .8"/>')
    for number,x,y,dy in [(1,40,6.8,1),(2,80,6.8,1),(3,80,53.2,-1),(4,40,53.2,-1)]:
        svg.append(f'<rect x="{x-4}" y="{y-4}" width="8" height="8" fill="#f4c870" fill-opacity=".7" stroke="#a16c05" stroke-width=".2"/>')
        svg.append(f'<path d="M{x-2.8} {y+dy*4} H{x+2.8}" stroke="#df9a15" stroke-width=".7"/>')
        svg.append(f'<g transform="translate({x},{y}) scale(1,-1)"><text y="1.2" text-anchor="middle" font-size="3.8" font-weight="bold">{number}</text></g>')
    svg.extend(['</g>',
      '<text x="48" y="695" font-size="16">Blue: open cable loop + inward access · Amber: LED positions · Dashed: original 120 × 60 outline</text>',
      '<rect x="973" y="111" width="403" height="609" rx="14" fill="white" stroke="#d4dce4"/>',
      '<text x="996" y="145" font-size="21" font-weight="bold">Open channel section</text>',
      '<text x="996" y="174" font-size="16">Nominal clear opening: 4.2 × 7.7 mm</text>',
      '<rect x="1018" y="224" width="296" height="380" fill="#44566a"/>',
      '<rect x="1082" y="296" width="168" height="308" fill="#d5f3f7"/>'])
    for xx in (1126,1206):
        for yy in (344,424,504):
            svg.append(f'<circle cx="{xx}" cy="{yy}" r="40" fill="none" stroke="#1c7d95" stroke-width="1.2" stroke-dasharray="4 3"/><circle cx="{xx}" cy="{yy}" r="36" fill="#53b9ce" stroke="#19728a"/>')
    svg.extend(['<text x="1166" y="216" text-anchor="middle" font-size="17">Front face / print bed</text>',
      '<text x="1166" y="264" text-anchor="middle" fill="white" font-size="15">1.8 mm floor</text>',
      '<text x="1166" y="588" text-anchor="middle" font-size="15">Open toward the rear</text>',
      '<text x="996" y="623" font-size="16">Original six-wire allowance retained.</text>',
      '<text x="996" y="649" font-size="16">Use wire insulation OD ≤ 1.8 mm.</text>',
      '<text x="996" y="677" font-size="15">Small glue anchors retain the wires.</text>',
      '<rect x="24" y="742" width="1352" height="250" rx="14" fill="white" stroke="#d4dce4"/>',
      '<text x="44" y="777" font-size="22" font-weight="bold">Install and dress the harness before closing the optical stack</text>',
      '<text x="44" y="812" font-size="18">1. Measure insulation diameter: AWG specifies the copper, not the outside size. Flexible 24 AWG is easier to thread.</text>',
      '<text x="44" y="847" font-size="18">2. Lay the wires into the open channels around the bosses. Keep connectors and R1 in their original service bays.</text>',
      '<text x="44" y="882" font-size="18">3. Preserve DIN → DOUT order. Dress overlaps and bends in the open bays; tack wires down with small glue anchors.</text>',
      '<text x="44" y="917" font-size="18">4. Seat each LED on its original floor, emitter inward. Use small hot-glue anchors clear of pads and the light-emitting edge.</text>',
      '<text x="44" y="952" font-size="18">5. Fit the acrylic, backing and retainer. All seats and screws must close by hand without crushing or pinching wires.</text>',
      '</g></svg>'])
    (OUT/'front-wiring.svg').write_text('\n'.join(svg),encoding='utf-8')
if __name__=='__main__':main()
