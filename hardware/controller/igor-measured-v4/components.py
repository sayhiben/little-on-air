"""Measured component envelopes. All distances mm; source is the user's measurements.

Front coordinates: X=right, Y=into case normal to display, Z=up the display.
Desk coordinates: X=right, Y=rear, Z=up. front() maps between them.
Hole edge measurements are approximate and never used as locating pins.
"""
from pathlib import Path
import math,json
import cadquery as cq
ROOT=Path(__file__).resolve().parent
AXIS_Y=49.9117
ENC_PCB_TOP=28.5
OLED_TOP=31.25
OLED_FRONT=4.0
PIXEL_X=18.0
PIXEL_Z=19.0
HAT_LIFT=1.2
PUSH_TRAVEL=1.0

def box(x0,x1,y0,y1,z0,z1):return cq.Solid.makeBox(x1-x0,y1-y0,z1-z0,(x0,y0,z0))
def cylinder(r,h,p,d=(0,0,1)):return cq.Solid.makeCylinder(r,h,p,d)
def front(s):return s.rotate((0,0,0),(1,0,0),-30).translate((0,0,10))
def enc(s):return s.translate((-8.4,-11,0)).rotate((0,0,0),(0,0,1),180).translate((0,AXIS_Y,0))
def compound(ss):return cq.Compound.makeCompound(list(ss))
def d_shape(r,flat_x,z0,z1):
 return cylinder(r,z1-z0,(0,AXIS_Y,z0)).intersect(box(flat_x,r+1,AXIS_Y-r-1,AXIS_Y+r+1,z0,z1))

def encoder():
 t=ENC_PCB_TOP
 pcb=box(0,19.25,0,26.4,t-1.5,t)
 # 1.16 mm edge clearance + hole radius; other edge offsets are approximate.
 holes=[(19.25-1.16-1.375,3.2+1.375),(19.25-1.16-1.375,26.4-3.43-1.375)]
 for x,y in holes:pcb=pcb.cut(cylinder(1.375,2,(x,y,t-1.6)))
 body=box(2.4,14.4,5,17,t,t+7)
 # Width/length of registration tab unspecified: reserve entire rear band.
 tab=box(2.4,14.4,3.5,6.5,t+7,t+8.2)
 collar=cylinder(3.4,7,(8.4,11,t+7))
 header=box(1.2,13.65,22.4,24.9,t,t+2.45)
 pins=[]
 # User's 1.9 mm "spacing" is treated conservatively as a clear gap.
 # Physical pin placement does not drive any printed hole or connector.
 for i in range(5):
  x=2.345+i*2.54
  pins.extend([cylinder(.32,4.85,(x,23.65,t)),
               cylinder(.32,7.45,(x,23.65,t+4.85),(0,1,0))])
 solder=box(.2,19.05,.2,26.2,t-3.5,t-1.5)
 # All solder undersides are conservatively reserved, including around holes.
 parts={'encoder-pcb':enc(pcb),'encoder-box':enc(body),'encoder-tab-envelope':enc(tab),
  'encoder-collar':enc(collar),'encoder-header':enc(header),'encoder-pins':enc(compound(pins)),
  'encoder-solder-envelope':enc(solder)}
 flat=-math.sqrt(3**2-(5.4/2)**2) # User confirmed 5.4 mm along the flat face.
 parts['encoder-shaft']=d_shape(3,flat,t+14,t+27.25)
 parts['encoder-connector-envelope']=box(-5.9,7.6,AXIS_Y-15.4-8.5,AXIS_Y-15.4,t+3.35,t+6.35)
 return parts

def display():
 top=OLED_TOP;bottom=top-27.9;y=OLED_FRONT
 pcb=box(-13.8,13.8,y,y+1.25,bottom,top)
 pcb=pcb.cut(box(-7.25,7.25,y-.1,y+1.35,bottom-.1,bottom+2.5))
 # Hole centers use edge clearance 1.1 mm plus radius 1 mm.
 for x in (-11.7,11.7):
  for z in (bottom+2.1,top-2.1):pcb=pcb.cut(cylinder(1,1.5,(x,y-.1,z),(0,1,0)))
 glass=box(-13.3,13.3,y-2,y,top-4.2-19.2,top-4.2)
 active=box(-13.05,12.45,y-2-.01,y-2,top-5-14.5,top-5)
 # Ribbon wraps through the board's lower central notch. Reserve 0.25 mm
 # around its lower turn; keep supports and adhesive away from this area.
 ribbon=compound([box(-7.25,7.25,y-2,y,bottom,bottom+4.5),
  box(-7.25,7.25,y-2,y+3.25,bottom-.25,bottom),
  box(-7.25,7.25,y+1.25,y+3.25,bottom,bottom+2.5)])
 header=box(-5,5,y+1.25,y+3.25,top-2.5,top-.5)
 pins=compound([cylinder(.32,5.8,(x,y+3.25,top-1.5),(0,1,0)) for x in (-3.81,-1.27,1.27,3.81)])
 solder=box(-5,5,y-1.85,y,top-2.5,top-.5)
 connector=box(-5.4,5.4,y+3.25,y+11.25,top-2.8,top-.2)
 return {n:front(s) for n,s in {'oled-pcb':pcb,'oled-glass':glass,'oled-active-area':active,
  'oled-ribbon-envelope':ribbon,'oled-header':header,'oled-pins':pins,
  'oled-front-solder-envelope':solder,'oled-connector-envelope':connector}.items()}

def other():
 model=cq.importers.importStep(str(ROOT/'reference/xiao-esp32s3-seeed.step')).val()
 xiao=model.rotate((0,0,0),(1,1,1),120).translate((6.11,58.62,3.35))
 pixel=front(box(PIXEL_X-2.5,PIXEL_X+2.5,3.8,5.2,PIXEL_Z-8.8,PIXEL_Z+8.8))
 tape=front(box(PIXEL_X-2.5,PIXEL_X+2.5,5.2,5.4,PIXEL_Z-8.8,PIXEL_Z+8.8))
 return {'xiao':xiao,'pixel-strip-envelope':pixel,'pixel-mount-tape':tape,
  'weight-left':box(-20.25,-.25,34.75,68.25,-6.4,.1),
  'weight-right':box(.25,20.25,34.75,68.25,-6.4,.1),
  'auxiliary-envelope':box(-21.8,-17.8,43,61,9,21),
  'capacitor-envelope':cylinder(3.15,8.5,(16.5,50,10))}

def all_components():return {**encoder(),**display(),**other()}

MEASUREMENTS={
 'source':'User supplied hand measurements; no inferred vendor CAD for these modules',
 'weight':{'size_mm':[20,33.5,6.5],'height_includes_foam_adhesive':True,'count':2,'single_layer':True},
 'encoder':{'pcb_mm':[19.25,26.4,1.5],'solder_below_pcb_mm':2,'box_mm':[12,12,7],
  'box_offsets_from_non_header_short_edge_and_opposite_holes_edge_mm':[5,2.4],
  'tab_height_above_box_mm':1.2,'tab_reserved_plan_mm':[12,3],
  'collar_diameter_height_mm':[6.8,7],'shaft_diameter_length_mm':[6,13.25],
  'flat_face_chord_mm':5.4,'header_plastic_mm':[12.45,2.5,2.45],
  'header_pin_extra_up_mm':2.4,'header_pin_overhang_mm':4.7,'pin_diameter_mm':.64,
  'header_edge_offsets_mm':[1.5,1.2,5.75],'hole_diameter_mm':2.75,
  'hole_inner_edge_spacing_mm':13.85,'hole_edge_clearances_mm':[1.16,3.43,3.2],
  'push_travel_reserved_mm':PUSH_TRAVEL},
 'pixel':{'strip_mm':[5,17.6,1.4],'centered_led':True,'additional_mount_tape_mm':.2},
 'oled':{'pcb_mm':[27.6,27.9,1.25],'front_solder_height_mm':1.85,'active_mm':[25.5,14.5],
  'active_offsets_top_left_mm':[5,.75],'glass_mm':[26.6,19.2,2],
  'glass_top_offset_mm':4.2,'ribbon_notch_mm':[14.5,2.5],'ribbon_height_mm':2,
  'hole_diameter_mm':2,'hole_edge_clearance_mm':[1,1.15],
  'header_mm':[10,2,2],'header_pin_length_mm':5.8,'header_top_edge_clearance_mm':.5,
  'pin_diameter_mm':.64,'pin_gap_mm':1.9},
 'assumptions':['Approximate mounting-hole offsets are edge clearances, not centers; no printed locating pins depend on them.',
  'Encoder 1.9 mm pin spacing is conservatively treated as clear gap, or 2.54 mm pitch; no mating connector is fabricated.',
  'Encoder tab plan dimensions and push travel were not supplied; reserve 12 x 3 mm and 1 mm travel.',
  'Connector housings were not supplied; modeled clear envelopes are stated separately from measured pin fit.',
  'Glass height means its front is 2 mm above PCB front; the entire 2 mm volume is reserved.']}
