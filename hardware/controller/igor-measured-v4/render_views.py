"""Render delivered CAD meshes and measured envelopes, without invented features."""
from pathlib import Path
import numpy as np
import vtk,trimesh
from vtk.util.numpy_support import numpy_to_vtk,numpy_to_vtkIdTypeArray
from PIL import Image,ImageDraw,ImageFont
ROOT=Path(__file__).resolve().parent;OUT=ROOT/'output';VIEW=OUT/'views'
def font(s,b=False):return ImageFont.truetype('C:/Windows/Fonts/'+('segoeuib.ttf' if b else 'segoeui.ttf'),s)
def mesh(n):return trimesh.load_mesh(OUT/'assembly-meshes'/f'{n}.stl')
def actor(m,color,delta=(0,0,9.5),clip=False):
 pd=vtk.vtkPolyData();p=vtk.vtkPoints();p.SetData(numpy_to_vtk(m.vertices+np.array(delta),deep=True));pd.SetPoints(p)
 c=vtk.vtkCellArray();c.SetCells(len(m.faces),numpy_to_vtkIdTypeArray(np.column_stack((np.full(len(m.faces),3),m.faces)).ravel().astype(np.int64),deep=True));pd.SetPolys(c)
 norm=vtk.vtkPolyDataNormals();norm.SetInputData(pd);norm.SetFeatureAngle(45);norm.Update()
 mapper=vtk.vtkPolyDataMapper();mapper.SetInputConnection(norm.GetOutputPort())
 if clip:
  plane=vtk.vtkPlane();plane.SetOrigin(0,0,0);plane.SetNormal(-1,0,0)
  cut=vtk.vtkClipPolyData();cut.SetClipFunction(plane);cut.SetInputConnection(norm.GetOutputPort());cut.Update();mapper.SetInputData(cut.GetOutput())
 a=vtk.vtkActor();a.SetMapper(mapper);p=a.GetProperty();p.SetColor(*color);p.SetAmbient(.24);p.SetDiffuse(.76);p.SetSpecular(.15);p.SetSpecularPower(35)
 return a
def render(name,mode='assembled'):
 ren=vtk.vtkRenderer();ren.SetBackground(.953,.957,.945)
 colors={'01':(.33,.44,.41),'02':(.86,.87,.84),'03':(.12,.16,.15),'04':(.86,.87,.84),'05':(.86,.87,.84),'06':(.69,.9,.8),'07':(.65,.72,.65),'08':(.72,.63,.43)}
 if mode=='original':
  for n,c in [('original-shell-reference',colors['01']),('original-faceplate-reference',colors['02']),('original-hat-reference',colors['03'])]:ren.AddActor(actor(mesh(n),c,(0,0,0)))
 else:
  for p in sorted((OUT/'cad').glob('0*.step')):
   if mode=='inside' and p.stem[:2] in ('03','04','05'):continue
   ren.AddActor(actor(mesh(p.stem),colors[p.stem[:2]],clip=mode=='inside' and p.stem[:2] in ('01','02','08')))
 if mode!='original':
  for n in ('oled-pcb','oled-glass','oled-active-area'):
   ren.AddActor(actor(mesh(n),(.01,.025,.02) if n!='oled-pcb' else (.08,.35,.25)))
 if mode=='inside':
  for n,c in [('weight-left',(.55,.58,.6)),('weight-right',(.55,.58,.6)),('xiao',(.36,.42,.4)),('encoder-pcb',(.18,.48,.68)),('encoder-box',(.67,.7,.69)),('encoder-collar',(.69,.71,.7)),('encoder-shaft',(.75,.76,.74)),('encoder-header',(.16,.18,.17)),('encoder-pins',(.85,.73,.45)),('oled-header',(.14,.16,.15)),('oled-pins',(.85,.73,.45)),('pixel-strip-envelope',(.25,.72,.37))]:
   ren.AddActor(actor(mesh(n),c))
 desk=trimesh.creation.box((130,125,1));desk.apply_translation((0,39,-.5));a=actor(desk,(.91,.925,.9),(0,0,0));a.GetProperty().LightingOff();ren.AddActor(a)
 win=vtk.vtkRenderWindow();win.SetOffScreenRendering(1);win.SetSize(1100,1000);win.SetMultiSamples(8);win.AddRenderer(ren)
 cam=ren.GetActiveCamera();cam.SetViewUp(0,0,1);cam.SetFocalPoint(0,35,33);cam.SetPosition(145,-190,142);cam.ParallelProjectionOn();cam.SetParallelScale(55)
 if mode=='inside':cam.SetPosition(170,-140,117)
 ren.ResetCameraClippingRange();win.Render();cap=vtk.vtkWindowToImageFilter();cap.SetInput(win);cap.SetInputBufferTypeToRGB();cap.ReadFrontBufferOff();cap.Update()
 writer=vtk.vtkPNGWriter();writer.SetFileName(str(VIEW/f'{name}.png'));writer.SetInputConnection(cap.GetOutputPort());writer.Write();win.Finalize()
def panel(filename,title,subtitle,items,footer):
 im=Image.new('RGB',(2000,1210),(243,244,241));d=ImageDraw.Draw(im)
 d.text((62,35),title,font=font(44,True),fill='#253c34');d.text((66,105),subtitle,font=font(26),fill='#53675c')
 for i,(name,label,description) in enumerate(items):
  im.paste(Image.open(VIEW/f'{name}.png').resize((1000,909),Image.Resampling.LANCZOS),(i*1000,155));d=ImageDraw.Draw(im)
  d.text((i*1000+66,1047),label,font=font(28,True),fill='#253c34');d.text((i*1000+66,1094),description,font=font(22),fill='#53675c')
 d.text((66,1160),footer,font=font(21),fill='#6c7c71');im.save(VIEW/filename)
def mechanism():
 ren=vtk.vtkRenderer();ren.SetBackground(.953,.957,.945)
 def local(n):
  m=mesh(n);m.apply_translation((0,0,-10));m.apply_transform(trimesh.transformations.rotation_matrix(np.pi/6,[1,0,0]));return m
 face=actor(local('02-igor-measured-faceplate'),(.82,.84,.79),(0,0,0))
 for origin,normal in [((13.8,0,0),(1,0,0)),((22.1,0,0),(-1,0,0)),((0,0,7.8),(0,0,1)),((0,0,30),(0,0,-1))]:
  plane=vtk.vtkPlane();plane.SetOrigin(*origin);plane.SetNormal(*normal);face.GetMapper().AddClippingPlane(plane)
 ren.AddActor(face)
 ren.AddActor(actor(local('06-front-diffuser-PETG'),(.55,.83,.72),(0,5,0)))
 ren.AddActor(actor(local('07-strip-cassette'),(.48,.6,.51),(0,18,3)))
 ren.AddActor(actor(local('pixel-strip-envelope'),(.22,.65,.3),(0,18,3)))
 win=vtk.vtkRenderWindow();win.SetOffScreenRendering(1);win.SetSize(1500,1100);win.SetMultiSamples(8);win.AddRenderer(ren)
 cam=ren.GetActiveCamera();cam.SetViewUp(0,0,1);cam.SetFocalPoint(18,10,19);cam.SetPosition(53,57,45);cam.ParallelProjectionOn();cam.SetParallelScale(18)
 ren.ResetCameraClippingRange();win.Render();cap=vtk.vtkWindowToImageFilter();cap.SetInput(win);cap.SetInputBufferTypeToRGB();cap.ReadFrontBufferOff();cap.Update()
 writer=vtk.vtkPNGWriter();writer.SetFileName(str(VIEW/'diffuser-detail-raw.png'));writer.SetInputConnection(cap.GetOutputPort());writer.Write();win.Finalize()
 canvas=Image.new('RGB',(1500,1330),(243,244,241));canvas.paste(Image.open(VIEW/'diffuser-detail-raw.png'),(0,140));d=ImageDraw.Draw(canvas)
 d.text((55,30),'Front diffuser and strip holder',font=font(44,True),fill='#253c34')
 d.text((58,99),'Exploded CAD detail; faceplate cropped to show the mounting features.',font=font(25),fill='#53675c')
 d.text((55,1182),'Seat diffuser from inside. Align holder notches with tabs; push in, then slide down 3 mm.',font=font(25),fill='#253c34')
 d.text((55,1231),'A small glue bead at the top locks the slide. The holder captures the diffuser flange.',font=font(25),fill='#53675c')
 d.text((55,1280),'The LED sits behind the diffuser with a 1.5 mm gap when assembled.',font=font(23),fill='#6c7c71')
 canvas.save(VIEW/'diffuser-detail.png')
def main():
 VIEW.mkdir(exist_ok=True)
 render('assembled');render('cutaway','inside');render('original','original');mechanism()
 panel('measured-fit-overview.png','Project IGOR: fitted to your measured parts','Original footprint and orientation. Two weights in one layer. Captured front diffuser.',
  [('assembled','ASSEMBLED','9.5 mm added beneath the flat base'),('cutaway','CUTAWAY','Measured encoder, display, XIAO and both weights')],
  'Actual CAD geometry. Colors and component envelopes are illustrative; physical prototype fit remains to be checked.')
 panel('original-vs-measured.png','Original IGOR and measured-fit revision','Same scale and desk datum. Original rounded outline, upward-facing display and vertical back.',
  [('original','ORIGINAL IGOR','Author-supplied geometry'),('assembled','MEASURED REVISION','Front diffuser; component mounts sized to your measurements')],
  'The active display window is enlarged to avoid cropping. The original knob exterior is retained and lifted 1.2 mm.')
 print(VIEW/'measured-fit-overview.png',flush=True)
if __name__=='__main__':main()
