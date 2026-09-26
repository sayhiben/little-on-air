"""Review saved native-coordinate meshes before revising front cable paths."""
from pathlib import Path
import importlib.util,json
import numpy as np
BASE=Path(__file__).resolve().parents[1]
OUT=BASE/'output/v214';OUT.mkdir(exist_ok=True)
s=importlib.util.spec_from_file_location('mesh_audit',BASE/'audit_print_projects.py')
a=importlib.util.module_from_spec(s);s.loader.exec_module(a)

def segments(tri,d):
    z=-d; result=[]
    for t in tri:
        points=[]
        for p,q in zip(t,np.roll(t,-1,axis=0)):
            if (p[2]<z) != (q[2]<z):
                points.append((p+(q-p)*(z-p[2])/(q[2]-p[2]))[:2])
        if len(points)==2 and np.linalg.norm(points[0]-points[1])>1e-6:result.append(points)
    return result

def main():
    specs=[('Frame',BASE/'output/v213/meshes-assembly-coordinates/01-front-optical-bezel.stl','#263342'),
      ('Optical retainer',BASE/'output/v28/meshes-assembly-coordinates/04-optical-retainer.stl','#b78618'),
      ('Electronics yoke',BASE/'output/v28/meshes-assembly-coordinates/06-electronics-retaining-yoke.stl','#c54865'),
      ('Rear housing',BASE/'output/v213/meshes-assembly-coordinates/05-rear-electronics-housing.stl','#8d8fa3')]
    bodies=[(n,a.stl(p),c) for n,p,c in specs]
    print(json.dumps({n:{'min':t.reshape(-1,3).min(axis=0).tolist(),'max':t.reshape(-1,3).max(axis=0).tolist()} for n,t,c in bodies},indent=2))
    svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1550" height="1450" viewBox="0 0 1550 1450">',
         '<rect width="1550" height="1450" fill="#f6f7f9"/>',
         '<g font-family="Arial" fill="#172535"><text x="30" y="32" font-size="24">Existing frame and adjacent parts — horizontal sections (front-view XY)</text>',
         '<text x="30" y="61" font-size="17">Gray: front frame · Gold: optical retainer · Pink: electronics yoke · Lavender: rear housing · Green: acrylic XY envelope</text></g>']
    for i,d in enumerate([2.4,3.6,6.2,7.8,9.2,11.0]):
        x=30+(i%2)*760;y=105+(i//2)*445
        svg.append(f'<text x="{x}" y="{y-10}" font-family="Arial" font-size="22">Depth {d} mm behind front face</text>')
        svg.append(f'<g transform="translate({x},{y+360}) scale(6,-6)">')
        svg.append('<rect x="0" y="0" width="120" height="60" fill="white"/>')
        for n,t,c in bodies:
            edges=segments(t,d)
            path=' '.join(f'M{p[0]:.4f},{p[1]:.4f} L{q[0]:.4f},{q[1]:.4f}' for p,q in edges)
            svg.append(f'<path d="{path}" fill="none" stroke="{c}" stroke-width=".22"/>')
        svg.append('<path d="M8 11 H112 V49 H11 L8 46 Z" fill="none" stroke="#1c9d64" stroke-width=".15" stroke-dasharray="1 .7"/>')
        for xx in (40,80):
            for yy in (6.8,53.2):svg.append(f'<rect x="{xx-4}" y="{yy-4}" width="8" height="8" fill="#e4bb4040" stroke="#997a1b" stroke-width=".15"/>')
        svg.append('</g>')
        for xx in range(0,121,20):svg.append(f'<text x="{x+6*xx}" y="{y+382}" text-anchor="middle" font-family="Arial" font-size="14">{xx}</text>')
    svg.append('</svg>');(OUT/'existing-sections.svg').write_text('\n'.join(svg),encoding='utf-8')
if __name__=='__main__':main()
