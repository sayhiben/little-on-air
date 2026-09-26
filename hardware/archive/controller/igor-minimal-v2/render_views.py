"""Same-scale comparison of exact source and minimally revised CAD meshes."""
from pathlib import Path
import numpy as np
import vtk
from vtk.util.numpy_support import numpy_to_vtk,numpy_to_vtkIdTypeArray
import trimesh
from PIL import Image,ImageDraw,ImageFont
ROOT=Path(__file__).resolve().parent;OUT=ROOT/'output';VIEW=OUT/'views'
def font(size,bold=False):
 return ImageFont.truetype('C:/Windows/Fonts/'+('segoeuib.ttf' if bold else 'segoeui.ttf'),size)

def actor(mesh,color,delta=(0,0,0),clip=False):
 pd=vtk.vtkPolyData();pts=vtk.vtkPoints();pts.SetData(numpy_to_vtk(mesh.vertices+np.array(delta),deep=True));pd.SetPoints(pts)
 ca=vtk.vtkCellArray();ca.SetCells(len(mesh.faces),numpy_to_vtkIdTypeArray(np.column_stack((np.full(len(mesh.faces),3),mesh.faces)).ravel().astype(np.int64),deep=True));pd.SetPolys(ca)
 normals=vtk.vtkPolyDataNormals();normals.SetInputData(pd);normals.SetFeatureAngle(45);normals.SplittingOn();normals.Update()
 mapper=vtk.vtkPolyDataMapper();mapper.SetInputConnection(normals.GetOutputPort())
 if clip:
  plane=vtk.vtkPlane();plane.SetOrigin(0,0,0);plane.SetNormal(-1,0,0)
  cut=vtk.vtkClipPolyData();cut.SetClipFunction(plane);cut.SetInputConnection(normals.GetOutputPort());cut.Update();mapper.SetInputData(cut.GetOutput())
 a=vtk.vtkActor();a.SetMapper(mapper);p=a.GetProperty();p.SetColor(*color);p.SetAmbient(.20);p.SetDiffuse(.8);p.SetSpecular(.13);p.SetSpecularPower(35)
 return a

def cube(size,center):
 m=trimesh.creation.box(size);m.apply_translation(center);return m


def render(name,original=False,inside=False,side=False):
 ren=vtk.vtkRenderer();ren.SetBackground(.953,.957,.945)
 parts=[('original-shell-reference' if original else '01-igor-shell-minimal',(.33,.44,.41)),
        ('02-igor-faceplate-original',(.86,.87,.84)),('03-igor-hat-original',(.12,.16,.15)),
        ('04-igor-small-inlay-original',(.86,.87,.84)),('05-igor-large-inlay-original',(.86,.87,.84))]
 if inside:parts=[parts[0],('xiao-reference',(.63,.67,.63)),('pixel-reference',(.13,.28,.18)),('weight-reference',(.53,.56,.58))]
 for n,c in parts:
  mesh=trimesh.load_mesh(OUT/'assembly-meshes'/f'{n}.stl')
  ren.AddActor(actor(mesh,c,clip=inside and n=='01-igor-shell-minimal'))
 if not inside:
  # Same plain screen in both views, for context only.
  ren.AddActor(actor(cube((25,.2,14),(0,1.7,19)),(.035,.055,.045)))
  if not original:
   ren.AddActor(actor(cube((5,5,1.6),(12.2,6.7,35.1)),(.2,.85,.28)))
 win=vtk.vtkRenderWindow();win.SetOffScreenRendering(1);win.SetSize(1100,1000);win.SetMultiSamples(8);win.AddRenderer(ren)
 cam=ren.GetActiveCamera();cam.SetViewUp(0,0,1);cam.SetFocalPoint(0,27,34)
 cam.SetPosition(135,-200,120);cam.ParallelProjectionOn();cam.SetParallelScale(53)
 if side:cam.SetPosition(220,27,34);cam.SetParallelScale(47)
 if inside:cam.SetPosition(150,-190,120);cam.SetParallelScale(53)
 ren.ResetCameraClippingRange();win.Render()
 cap=vtk.vtkWindowToImageFilter();cap.SetInput(win);cap.SetInputBufferTypeToRGB();cap.ReadFrontBufferOff();cap.Update()
 writer=vtk.vtkPNGWriter();writer.SetFileName(str(VIEW/f'{name}.png'));writer.SetInputConnection(cap.GetOutputPort());writer.Write();win.Finalize()

def main():
 VIEW.mkdir(exist_ok=True)
 for name,orig,inside,side in [('original',True,False,False),('revised',False,False,False),('original-side',True,False,True),('revised-side',False,False,True),('inside',False,True,False)]:
  if not inside or (OUT/'assembly-meshes/weight-reference.stl').exists():render(name,orig,inside,side)
 canvas=Image.new('RGB',(2000,1210),(243,244,241));d=ImageDraw.Draw(canvas)
 d.text((62,37),'Project IGOR: minimal alterations',font=font(49,True),fill='#253c34')
 d.text((66,110),'Original faceplate, hat, encoder position and display opening retained exactly.',font=font(26),fill='#53675c')
 for name,x,title,desc in [('original',0,'ORIGINAL IGOR','Unmodified author-supplied model'),('revised',1000,'REVISED','6 mm lower base · XIAO holder · small top LED opening')]:
  im=Image.open(VIEW/f'{name}.png').resize((1000,909),Image.Resampling.LANCZOS);canvas.paste(im,(x,170))
  d=ImageDraw.Draw(canvas);d.text((x+66,1046),title,font=font(28,True),fill='#253c34');d.text((x+66,1094),desc,font=font(22),fill='#53675c')
 d.text((66,1160),'Same scale and camera. Rendered from the actual CAD; colors and plain screen are illustrative.',font=font(21),fill='#6c7c71')
 canvas.save(VIEW/'original-vs-minimal.png')
 canvas=Image.new('RGB',(2000,1170),(243,244,241));d=ImageDraw.Draw(canvas)
 d.text((62,36),'The original rear slope stays intact',font=font(48,True),fill='#253c34')
 for name,x,title in [('original-side',0,'ORIGINAL'),('revised-side',1000,'REVISED: 6 mm added downward')]:
  im=Image.open(VIEW/f'{name}.png').resize((1000,909),Image.Resampling.LANCZOS);canvas.paste(im,(x,140));d=ImageDraw.Draw(canvas);d.text((x+66,1070),title,font=font(26,True),fill='#253c34')
 canvas.save(VIEW/'side-profile-comparison.png')
 print(VIEW/'original-vs-minimal.png',flush=True)

if __name__=='__main__':main()
