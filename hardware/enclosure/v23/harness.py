"""Two-switch circuit clearance routes in X,Y,depth mm; radii include dressing room."""
ROUTES=[
 ('H1 front connector to LED1',1.6,[(68,24,13.7),(47.5,24,13.7),(47.5,6.8,13.7),(47.5,6.8,6.5)]),
 ('H2 LED1 to LED2',1.6,[(32.5,6.8,6.5),(32.5,6.8,18),(87.5,6.8,18),(87.5,6.8,6.5)]),
 ('H3 LED2 to LED3',1.6,[(72.5,6.8,6.5),(72.5,6.8,13.7),(72.5,30,13.7),(87.5,30,13.7),(87.5,53.2,13.7),(87.5,53.2,6.5)]),
 ('H4 LED3 to LED4',1.6,[(72.5,53.2,6.5),(72.5,53.2,13.7),(72.5,45.5,13.7),(34,45.5,13.7),(34,53.2,13.7),(34,53.2,7.5),(32.5,53.2,6.5)]),
 ('B1 battery to charger',1.6,[(87,26,18),(20.5,26,18),(20.5,32,18)]),
 ('P1 charger OUT plus to SPDT',.8,[(23.5,32,18),(23.5,30,18),(41,30,18),(41,49.5,23)]),
 ('P2 SPDT switched plus to DPDT RUN branch',.8,[(42,49.5,23),(50,49.5,24),(60,51,24)]),
 ('P3 switched plus and protected ground distribution',1.2,[(60,51,24),(76,44.5,24)]),
 ('P4 DPDT common A and ground to XIAO',1.2,[(63,51,24),(64.8,44.5,18),(64.8,30,18),(95.5,30,18),(95.5,43.5,18),(109.5,43.5,18),(109.5,43.5,24)]),
 ('G1 charger OUT minus to ground distribution',.8,[(21.5,32,18),(21.5,29,14.7),(76,29,14.7),(76,43,24)]),
 ('D1 XIAO data to DPDT RUN B',.8,[(109.5,50.5,18),(107,48.5,18),(98,47,15),(98,28,16),(68,28,16),(68,39,16),(68,51,20.8),(60,51,20.8)]),
 ('D2 DPDT common B to LED harness junction',.8,[(57,51,20.8),(57,41,23),(79,41,23),(79,44,24)]),
 ('H0 LED harness junction to front connector',1.6,[(79,44,24),(79,36,24),(79,36,13.7),(68,36,13.7),(68,24,13.7)])
]
BAYS=[
 ('SPDT insulated solder bay',(36.8,47.0,20.5),(45.2,50.6,25.3)),
 ('Capacitor and distribution bay',(71.5,41.5,16),(90,53,29)),
 ('Front connector service space',(61,18.5,11.5),(74,28.5,19)),
 ('DPDT insulated solder bay',(56.2,49.2,18.5),(63.8,53,25.3)),
 ('Charger solder bay',(15.3,31.9,17),(25.7,33.8,21.8)),
 ('XIAO lower solder approach',(107.6,39.4,16.7),(110.6,44,25.5)),
 ('XIAO upper solder approach',(107.6,48.3,16.7),(110.6,54.2,25.7)),
]
