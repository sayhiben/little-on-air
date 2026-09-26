"""Render the exported manufacturing meshes, with explicitly illustrative UI."""
from pathlib import Path
import numpy as np
import vtk
from vtk.util.numpy_support import numpy_to_vtk,numpy_to_vtkIdTypeArray
import trimesh
from PIL import Image,ImageDraw,ImageFont

ROOT=Path(__file__).resolve().parent;OUT=ROOT/'output';VIEW=OUT/'views'
COLORS={'01-weighted-shell':(.20,.345,.35),'02-igor-faceplate':(.85,.86,.81),
 '03-igor-hat':(.085,.12,.14),'04-ballast-cover':(.20,.345,.35),'05-led-diffuser':(.95,.09,.05),
 'xiao-reference':(.68,.71,.70),'pixel-envelope':(.08,.13,.12),'ballast-envelopes':(.53,.55,.58)}
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

def screen(renderer):
 im=Image.new('RGB',(480,240),(7,17,20));d=ImageDraw.Draw(im)
 d.text((30,15),'CONFIRMED',font=font(26,True),fill=(151,175,169))
 d.text((27,68),'ON AIR',font=font(71,True),fill=(241,244,232))
 d.text((30,170),'Turn to choose · press to send',font=font(23),fill=(138,166,163))
 im.save(VIEW/'screen-concept.png')
 reader=vtk.vtkPNGReader();reader.SetFileName(str(VIEW/'screen-concept.png'));reader.Update()
 texture=vtk.vtkTexture();texture.SetInputConnection(reader.GetOutputPort());texture.InterpolateOn()
 # Plane is behind the untouched OLED window; no change to manufacturing mesh.
 plane=vtk.vtkPlaneSource();plane.SetOrigin(-12,1.51,12.5);plane.SetPoint1(12,1.51,12.5);plane.SetPoint2(-12,1.51,25.5)
 mapper=vtk.vtkPolyDataMapper();mapper.SetInputConnection(plane.GetOutputPort())
 a=vtk.vtkActor();a.SetMapper(mapper);a.SetTexture(texture);a.GetProperty().LightingOff();renderer.AddActor(a)

def render(name,cutaway=False,underside=False,rear=False):
 ren=vtk.vtkRenderer();ren.SetBackground(.938,.946,.931)
 names=list(COLORS) if cutaway else list(COLORS)[:5]+['xiao-reference']
 for n in names:
  if cutaway and n in ('02-igor-faceplate','05-led-diffuser'):continue
  mesh=trimesh.load_mesh(OUT/'assembly-meshes'/f'{n}.stl')
  delta=(0,0,-15) if cutaway and n=='04-ballast-cover' else (0,0,0)
  ren.AddActor(actor(mesh,COLORS[n],delta,cutaway and n=='01-weighted-shell'))
 if not cutaway:screen(ren)
 else:
  # Board envelope for context only; actual purchased OLED/encoder fit is an
  # acceptance check, whereas XIAO geometry comes directly from Seeed's STEP.
  ren.AddActor(actor(cube((27,1.2,27),(0,4,17.4)),(.09,.14,.13)))
 for x in (-16,16):
  for y in (13,54):
   mesh=trimesh.creation.cylinder(radius=4,height=1.2);mesh.apply_translation((x,y,-14.6 if not cutaway else -29.6))
   ren.AddActor(actor(mesh,(.055,.065,.062)))
 win=vtk.vtkRenderWindow();win.SetOffScreenRendering(1);win.SetSize(1100,1100);win.SetMultiSamples(8);win.AddRenderer(ren)
 cam=ren.GetActiveCamera();cam.SetViewUp(0,0,1);cam.SetFocalPoint(0,27,26 if not cutaway else 23)
 cam.SetPosition(130,-200,117 if not cutaway else 104);cam.ParallelProjectionOn();cam.SetParallelScale(62 if not cutaway else 69)
 if underside:
  cam.SetPosition(100,-160,-170);cam.SetViewUp(0,1,0);cam.SetFocalPoint(0,30,0);cam.SetParallelScale(53)
 if rear:cam.SetPosition(140,205,115)
 ren.ResetCameraClippingRange();win.Render()
 capture=vtk.vtkWindowToImageFilter();capture.SetInput(win);capture.SetInputBufferTypeToRGB();capture.ReadFrontBufferOff();capture.Update()
 writer=vtk.vtkPNGWriter();writer.SetFileName(str(VIEW/f'{name}.png'));writer.SetInputConnection(capture.GetOutputPort());writer.Write();win.Finalize()

def main():
 VIEW.mkdir(exist_ok=True)
 render('assembled');render('section',True);render('underside',True,True);render('rear',rear=True)
 canvas=Image.new('RGB',(2000,1350),(239,241,237));d=ImageDraw.Draw(canvas)
 d.text((72,43),'LITTLE ON AIR',font=font(25,True),fill='#54706d')
 d.text((68,83),'Igor, made for the desk.',font=font(60,True),fill='#183335')
 d.text((72,169),'USB-powered XIAO ESP32-S3  /  OLED  /  push encoder  /  one RGB pixel',font=font(26),fill='#536863')
 for filename,x in [('assembled',0),('section',1000)]:
  im=Image.open(VIEW/f'{filename}.png').resize((1000,1000),Image.Resampling.LANCZOS);canvas.paste(im,(x,224))
 d=ImageDraw.Draw(canvas)
 d.text((72,1120),'ORIGINAL IGOR CONTROLS',font=font(25,True),fill='#183335')
 d.text((72,1162),'Original faceplate and hat; one status light below the display.',font=font(23),fill='#536863')
 d.text((1072,1120),'14 mm ADDED BELOW',font=font(25,True),fill='#183335')
 d.text((1072,1162),'40 × 48 × 10 mm weight pocket; removable bottom cover.',font=font(23),fill='#536863')
 d.line((72,1243,1928,1243),fill='#c7d0c8',width=2)
 d.text((72,1270),'Actual CAD geometry • section at right • screen and colors illustrate the intended UI',font=font(22),fill='#65756e')
 canvas.save(VIEW/'controller-overview.png')
 print(VIEW/'controller-overview.png',flush=True)

if __name__=='__main__':main()
