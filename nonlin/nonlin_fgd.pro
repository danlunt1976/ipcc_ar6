pro nl

; TO DO:
; differentiate g-ig from pre-quat?

forcing=3.7

make_pdf=1
make_png=1
make_eps=1

npp=3
pname=strarr(npp)
pname(*)=['old','new','final']
plot_uncert=1
do_ass=intarr(npp)
do_ass(0:npp-1)=[0,0,1]
plot_range=0

; plot limits
xmin=-10
xmax=26
ymax=0
ymin=-2.3

; for IPCC assessed range (table 7.10)
l_ass=[-1.54,-0.78]
vl_ass=[-1.81,-0.51]
t_ass=[0,3]

; for models
l_thick=2

; for proxies
e_thick=0.2


; for legend
inc=0.12
x1=-6
y1=ymin+0.1
x2=12.5
y2=y1
legcharsize=0.8
legcharsizen=0.4
x1n=x1+4
x2n=x2+8
delt=0.03
dist1=3
dist2=1

; for explainer
; xx is the start and end points of the explainer lines
; yy1 is the heigth of the non-lin explainer lines
; yy2 is the height of the lin explainer lines
do_explainer=0
xx1=[-6.5,-4.5]
dyy=0.2
ddyy=0.15
xxx=0.5
yy1=fltarr(2)
yy3=fltarr(2)
yy1(0)=-0.4
yy1(1)=yy1(0)+dyy
yy2=[yy1(0)-ddyy,yy1(0)-ddyy]
yy3(0)=yy1(0)-2*ddyy
yy3(1)=yy3(0)-dyy

; box around the explainer:
xl=xx1(0)-0.5
xr=xl+9
yt=yy1(1)+0.1
yb=yy3(1)-0.1

; for arrow
arx=-8
ary1=-2.1
ary2=-0.4
arnx=arx+1
arny=-1.2


; ************ + Add new Model
nstudies=17

data_n_max=5

refname=strarr(nstudies)
; ************ + Add new Model
refname(0:nstudies-1)=['Meraner et al (2013)','Good et al (2015)','Jonko et al (2013)','Caballero and Huber (2013)','Friedrich et al (2016)','Kohler et al (2017)','Anagnostou et al (2016)','Shaffer et al (2016)','Zhu et al (2019)','Mauritsen et al (2019)','Stolpe et al (2019)','von der Heydt (2014)','Royer (2016)','Stap et al (2019)','Snyder (2019)','Duan et al (2019)','Anagnostou et al (2020)']
studname=strarr(nstudies)
; ************ + Add new Model
studname(0:nstudies-1)=['ECHAM6','HadGEM2-ES','CCSM3','CCSM3 (Eocene)','G-IG','G-IG','Eocene','PETM','CESM1.2 (Eocene)','MPI-ESM1.2','CESM1.2.2','G-IG','G-IG','G-IG','G-IG','CESM1.2','Eocene']
studcols=intarr(nstudies)
studbar=intarr(nstudies)
cprox=100
cmod=250
; ************ + Add new Model
studbar(*)=[1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,1,0]


; data_n is the number of transitions (typically 1 less than the
; number of simulaitons for the GCMs)

; for paleo:
;     data_t is the temperature
;     data_t_s is the range of temperature
;     data_l is the alpha
;     data_t_l is the range of alpha

; for models: 
;   data_t is the upper of the two simulation temperatures [used in 'old']
;   data_t_s is the uncertainty in the lower of the two simulation temperatures  
;   data_t_r(0) is the values of the lower temperature in the transition
;   data_t_r(1) is the values of the upper temperature in the transition = data_t
;   data_t_r(2) is the values of the mean temperature in the
;     transition [used in 'new' and 'final']
;   data_l is the feedback parameter for each transition; if defined
;     using temperature then relative to control [used in 'old']
;   data_l_s is the uncertainty in the feedback parameter
;   data_l_r is the feedback parameter for each transition; if defined
;     using temperature then relative to next temp in step [used in 'new' and 'final']

data_n=intarr(nstudies)
data_t=fltarr(data_n_max,nstudies)
data_t_r=fltarr(3,data_n_max,nstudies)
data_t_s=fltarr(data_n_max,nstudies)
data_l=fltarr(data_n_max,nstudies)
data_l_s=fltarr(data_n_max,nstudies)
data_l_r=fltarr(data_n_max,nstudies)


data_n=intarr(nstudies)
; ************ + Add new Model
data_n(*)=[4,2,3,5,2,2,2,2,3,4,3,2,2,2,2,4,2]

do_plot=intarr(nstudies)
; ************ + Add new Model
do_plot(*)=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

is_paleo=intarr(nstudies)
; ************ + Add new Model
is_paleo(*)=[0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1]



; ************ - Add new Model


; Note that for the models, the temperature on the x axis is the
; temperature of the Warmest of the two simulations that are used to
; estimate alpha.


; Meraner
; values from their Table 1
xx=0
data_t(0:data_n(xx)-1,xx)=[2.79,6.7,12.46,22.68]
data_t_s(0:data_n(xx)-1,xx)=[0.04,0.04,0.07,0.11]
data_l(0:data_n(xx)-1,xx)=[-1.65,-1.35,-1.03,-0.67]
data_l_s(0:data_n(xx)-1,xx)=[0.04,0.01,0.01,0.01]

data_t_r(0,0:data_n(xx)-1,xx)=[0,2.79,6.7,12.46]
data_t_r(1,0:data_n(xx)-1,xx)=[2.79,6.7,12.46,22.68]
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=[-1.65,-1.35,-1.03,-0.67]


; Good
; asume F = 3.7 for both co2 doublings (they state that forcing is the
;   same for both doublings), 
; assume T21=2.75 (Their Supp info, Figure S1)
; T42=2.75+2.75*1.18=6.00 (they say that T42/T21=1.18) (also see Their Supp info, Figure S)
; lambda21=-3.7/2.75=-1.35 ; lambda42=-(3.7*2)/(6.00)=-1.23
; lambda42_r=-3.7(6.00-2.75)=-1.14
xx=1
data_t(0:data_n(xx)-1,xx)=[2.75,6.00]
data_t_s(0:data_n(xx)-1,xx)=[0,0]
data_l(0:data_n(xx)-1,xx)=[-1.35,-1.23]
data_l_s(0:data_n(xx)-1,xx)=[0,0]
data_t_r(0,0:data_n(xx)-1,xx)=[0,2.75]
data_t_r(1,0:data_n(xx)-1,xx)=[2.75,6.00]
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=[-1.35,-1.14]


; Jonko
; values for DT from text of paper.
; "In CCSM, the global mean surface air temperature
;   increases by 2.2 K in 2xCO2, 4.7 K in 4xCO2, and by
;   7.9 K in 8xCO2 relative to the control run for each forced
;   simulation by the last common decade of the simulations"
; values for s = 1/lambda from their table 1.
; 2x-1x (1x kernel); s=0.65 ; -1/0.65=-1.54
; 4x-2x (avg. kernel); s=0.73; -1/0.73=-1.37
; 8x-4x (8x kernel); s=0.8; -1/0.8=-1.25
xx=2
data_t(0:data_n(xx)-1,xx)=[2.2,4.7,7.9]
data_t_s(0:data_n(xx)-1,xx)=[0,0,0]
data_l(0:data_n(xx)-1,xx)=[-1.54,-1.37,-1.25]
data_l_s(0:data_n(xx)-1,xx)=[0,0,0]
data_t_r(0,0:data_n(xx)-1,xx)=[0,2.2,4.7]
data_t_r(1,0:data_n(xx)-1,xx)=[2.2,4.7,7.9]
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=[-1.54,-1.37,-1.25]


; Caballero
; assume T_preind=14 (black line, their figure 1)
; values for s = 1/lambda and T from their fig 3A (hard to read s,
;   black solid line)
; However, their MAT is for the Lower value of MAT, not the upper.  As
;   such, I need to shoft along the x axis by one.  Value for MAT from
;   warmest simulation is in Figure 1 = 38.5 (take their slab runs, as
;   these are more consistent with figure 3)
;   Figure 1: MAT = [20, 22, 24, 30, 39] - 14
;   Figure 3A: s  = [0.6,0.62,0.75,1.63,1.55]; alpaha =-1/s
;   Lowest temp is about 18.
xx=3
data_t(0:data_n(xx)-1,xx)=[6,8,10,16,25]
data_t_s(0:data_n(xx)-1,xx)=[0,0,0,0,0]
data_l(0:data_n(xx)-1,xx)=[-1.67,-1.64,-1.33,-0.625,-0.67] ; this is not 1/s above!!
data_l_s(0:data_n(xx)-1,xx)=[0,0,0,0,0]
data_t_r(0,0:data_n(xx)-1,xx)=[4,6,8,10,16]
data_t_r(1,0:data_n(xx)-1,xx)=[6,8,10,16,25]
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=[-1.67,-1.61,-1.33,-0.61,-0.64]

; Friedrich (2016)
; Section "specific equilibrium climate sensitivity". 
; cold climate (Scold) amounts to 0.41 to 0.55 K W−1 m2 (likely
;  range, mean: 0.48 KW−1 m2).
; warm climates, Swarm attains values of 1.16 to 1.47 (mean 1.32) 
; cold climates about -5.5 (Figure 3, dark blue, +- 1 ish) 
; warm climates about 0 (Figure 3, orange, +- 1 ish) 
xx=4
data_t(0:data_n(xx)-1,xx)=[-5.5,0]
data_t_s(0:data_n(xx)-1,xx)=[1,1]
data_l(0:data_n(xx)-1,xx)=-1.0/[0.48,1.32]
data_l_s(0:data_n(xx)-1,xx)=[0.5*(1.0/0.41-1.0/0.55),0.5*(1.0/1.16-1.0/1.47)]

; Kohler (2017)
; Figure 6.  Right hand part.  S[CO2,LI].  Honish plot, red lines.
; Cold: 16th to 84th percentile is 0.83 to 1.36; central is 1.07 
; Warm: 16th to 84th percentile is 0.96 to 2.19; central is 1.51  
; 'cold' temp is about -4.5 degrees (Figure 4c)
; 'warm' temp is about -2 degrees

xx=5
data_t(0:data_n(xx)-1,xx)=[-4.5,-2.0]
data_t_s(0:data_n(xx)-1,xx)=[1,1]
data_l(0:data_n(xx)-1,xx)=-1.0/([1.07,1.51])
data_l_s(0:data_n(xx)-1,xx)=[0.5*(1.0/0.83-1.0/1.36),0.5*(1.0/0.96-1.0/2.19)]

; Anagnostou (2016)
; DT from text:
;   "The most recent of these transitions occurred between the warmest time interval of the last
;    65 million years - the EECO (about 14 ± 3 °C warmer than
;                       preindustrial times)"
; and
;   "The global mean surface temperature change for the EECO is thought
;    to be ~14 ± 3 °C warmer than the pre-industrial period, and ~5 °C
;    warmer than the late Eocene (35 Myr ago; refs 2 and 29).
; So, delta-temps are 14 and 9, +- 3.
; lambda from anagnostou et al fig 4f.  ECS is roughly 2.5 and 3.75.
; forcing is 3.7
; 3.7/2.5=1.48 . 3.7/3.75=0.99
; uncertainty range given in abstract is 2.1 to 4.6 = range of 2.5,
; so +- 1.25.
; 3.7/(3.75+1.25)=3.7/5=0.74.  SO uncertainty is roughly 0.99-0.74 ~ 0.25 
xx=6
data_t(0:data_n(xx)-1,xx)=[9,14]
data_t_s(0:data_n(xx)-1,xx)=[3,3]
data_l(0:data_n(xx)-1,xx)=[-1.48,-0.99]
data_l_s(0:data_n(xx)-1,xx)=[0.25,0.25]

; Shaffer
; DT from "discussions and conclusions:
;   "Our pre-PETM CS range of 3.3-5.6 K is for a MAT of about 25°C, while the PETM CS range of 3.7-6.5 K is for
;    a MAT of about 30°C."
;   25-14=11; 30-14=16    
; lambda from Shaffer abstract: CS from 3.3-5.6, goes to 3.7-6.5
; assume forcing is 3.7.
; assume uncertaintes of +-3 degrees for now for temp.
rf=-3.7
shaff=fltarr(3,2)
shaff(0:1,0)=[3.3,5.6]
shaff(0:1,1)=[3.7,6.5]
shaff(2,0:1)=(shaff(0,0:1)+shaff(1,0:1))/2.0

xx=7
data_t(0:data_n(xx)-1,xx)=[11,16]
data_t_s(0:data_n(xx)-1,xx)=[3,3]
data_l(0:data_n(xx)-1,xx)=[rf/shaff(2,0),rf/shaff(2,1)]
data_l_s(0:data_n(xx)-1,xx)=[0.5*(rf/shaff(2,0)-rf/shaff(0,0))+(rf/shaff(1,0)-rf/shaff(2,0)),0.5*(rf/shaff(2,1)-rf/shaff(0,1))+(rf/shaff(1,1)-rf/shaff(2,1))]


; Zhu
; PI = 13.5 (their figure 1A)
; In text:
; "Global mean surface temperature (GMST) in the Eocene 1× simulation
;  is 4.5°C higher than in the PI simulation (Fig. 1A) due to the
;  absence of ice sheets and anthropogenic aerosols, more widespread
;  vegetation cover, and differences in the distribution of natural aerosols.
;  Eocene GMST increases to 25.0°, 29.8°, and 35.5°C in the 3×, 6×,
;  and 9× CO2 simulations, respectively"
; So DT=[25,29.8,35.3]-13.5= 11.5,16.3,21.8 ; n.b. 21.8 should be 22.0
; Take ECS from their figure 3a. 
; or from text:
; "ECS for the Eocene 1× case is 3.5°C, about 0.7°C lower
;  than the PI ECS due primarily to a lower surface albedo feedback
;  (Fig. 3B and table S3). Eocene ECS increases significantly with higher
;  background CO2 levels to 6.6° and 9.7°C in the 3× and 6× simulations,
;  respectively"
; Assume F = 3.7.  ECS =3.7/(3.5, 6.6, 9.7) =  1.06,0.56,0.38

; Here, from offline radiation calculations, we estimate the efficacy
; of CO2 forcing to be 3.8 W m−2 for the PI simulation and 4.0,
; 4.7, and 5.2 W m−2 for the Eocene 1×, 3×, and 6× experiments using
; CAM5, respectively.

rf_zhu=[3.8,4.7,5.2]
dt_zhu=[3.5,6.6,9.7]
bt_zhu=[18.0,25.0,29.8]-13.5

xx=8
data_t(0:data_n(xx)-1,xx)=[11.5,16.3,21.8]
data_t_s(0:data_n(xx)-1,xx)=[0,0,0]
data_l(0:data_n(xx)-1,xx)=[-1.06,-0.56,-0.38]
data_l_s(0:data_n(xx)-1,xx)=[0,0,0]

data_t_r(0,0:data_n(xx)-1,xx)=bt_zhu
data_t_r(1,0:data_n(xx)-1,xx)=bt_zhu+dt_zhu
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=-1.0*rf_zhu/dt_zhu

; Mauritsen
; From text:
; "The resulting ECS of MPI-ESM1.2-LR for doubled CO2 is then 2.77 K, only slightly
;  smaller than that estimated using the standard method."
; "With stronger forcing the ECS for each consecutive doubling rises dramatically to 3.6, 4.9, and nearly 10K"
; So DT is [2.77,2.77+3.6,2.77+3.6+4.9,2.77+3.6+4.9+10]
; thier Table 5:
;Effective radiative forcing: 
;F2x 4.10 Wm−2
;F4x 8.85 Wm−2
;F8x 13.50 Wm−2
;F16x 18.60 Wm−2 

mauritsen=[2.77,3.6,4.9,10]
mauritsen_1=fltarr(4)
mauritsen_2=fltarr(4)
mauritsen_3=fltarr(4)
mauritsen_f=[4.10,8.85,13.5,18.6]
for x=0,3 do begin
mauritsen_2(x)=total(mauritsen(0:x))
endfor
mauritsen_1(0)=0
mauritsen_3(0)=mauritsen_f(0)
for x=1,3 do begin
mauritsen_1(x)=mauritsen_2(x-1)
mauritsen_3(x)=mauritsen_f(x)-mauritsen_f(x-1)
endfor

xx=9
data_t(0:data_n(xx)-1,xx)=mauritsen_2
data_t_s(0:data_n(xx)-1,xx)=[0,0,0,0]
data_l(0:data_n(xx)-1,xx)=rf/mauritsen
data_l_s(0:data_n(xx)-1,xx)=[0,0,0,0]

data_t_r(0,0:data_n(xx)-1,xx)=mauritsen_1
data_t_r(1,0:data_n(xx)-1,xx)=mauritsen_2
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=-1*mauritsen_3/mauritsen

; Stolpe
; From text:
; "For the control state we estimate ECSeff as 4.31 °C"
; "With 4.17 °C (4.01-4.35 °C) ECSeff is slightly lower in the simulations branched off from the
;  warm state. In the cold climate state, ECSeff is with 4.92°C (4.66-5.32 °C) highest."
; Estimate baseliens from Figure 2a as 13.7 (also in text), 10, and
; 17.

; "The GMST of CESM1 in its unperturbed base state is 13.7 °C"
; "the difference between the warm and cold CESM1 simulations (7.7
; °C).".  From fig 2a estimate **9.5 for baseline; top = 17.2**
; = [9.5-13.7, 0, 17.2-13.7]

; For the control and the warm climate states we find virtually
; identical CO2 ERFs of + 3.65 (3.393.91) Wm−2 and +
; 3.65 (3.413.87) Wm−2, respectively (the values in brackets
; are the 90% confidence intervals). In the cold climate state, the
; ERF is around 0.36 Wm−2 or ~ 10% lower, 
; + 3.29 (3.153.45) Wm−2.

stolpe=[4.92,4.31,4.17]
stolpe_2=[10,13.7,17]-13.7
xx=10
data_t(0:data_n(xx)-1,xx)=stolpe+stolpe_2
data_t_s(0:data_n(xx)-1,xx)=[0,0,0]
data_l(0:data_n(xx)-1,xx)=rf/stolpe
data_l_s(0:data_n(xx)-1,xx)=[0,0,0]

data_t_r(0,0:data_n(xx)-1,xx)=[9.5,13.7,9.5+7.7]-13.7
data_t_r(1,0:data_n(xx)-1,xx)=data_t_r(0,0:data_n(xx)-1,xx)+stolpe
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=-1*[3.29,3.65,3.65]/stolpe


; von der Heydt (2014)
; cold: Table 1 gives 0.45 to 1.25 as range for S[co2,li] from cold periods
; cold: Table 1 also gives 0.69 as best estimate
; warm: Table 1 gives 0.84 to 1.46 as range for S[co2,li] from warm periods
; warm: Table 1 also gives 0.94 as best estimate, as does Discussion and conclusions
; cold temp is -4.3 to -2.7 (Table 1)
; warm temp is -2.7 to 0.8 (Table 1)
xx=11
data_t(0:data_n(xx)-1,xx)=[0.5*(-2.7+(-4.3)),0.5*(0.8+(-2.7))]
data_t_s(0:data_n(xx)-1,xx)=[0.5*(-2.7-(-4.3)),0.5*(0.8-(-2.7))]
data_l(0:data_n(xx)-1,xx)=-1.0/[0.69,0.94]
data_l_s(0:data_n(xx)-1,xx)=[0.5*(1.0/0.45-1.0/1.25),0.5*(1.0/0.84-1.0/1.46)]


; Royer (2016)
; Section 4.  S[CO2,LI] has a mean of 7.7K.  Table 1 - range is 3.7 to
;                                                      12.2.
; Figure 1a:
; take steps 1-2 to 5-6 as warm estimates
; take steps 7-8 to 11-12 as cold estimates
; temp for cold is about -1.5
; temp for warm is about +0.5
xx=12
data_t(0:data_n(xx)-1,xx)=[-1.5,0.5]
data_t_s(0:data_n(xx)-1,xx)=[1,1]
data_l(0:data_n(xx)-1,xx)=[-1*forcing/mean([3.7,5.0,4.1,5.2]),-1*forcing/mean([7.1,11.3,11.5,8.9,12.2])]
data_l_s(0:data_n(xx)-1,xx)=[-1*forcing/stddev([3.7,5.0,4.1,5.2]),-1*forcing/stddev([7.1,11.3,11.5,8.9,12.2])]


; Stap (2019)
; Section 4.2; 
; cold climates: they infer a S[CO2,LI] of 1.45 with efficacy, and 0.93 without.
; warm climates: they infer a S[CO2,LI] of 2.45 with efficacy, and
; 1.66 without.
; PI is 0, and LGM is about -5.
xx=13
data_t(0:data_n(xx)-1,xx)=[-5,0]
data_t_s(0:data_n(xx)-1,xx)=[1,1]
data_l(0:data_n(xx)-1,xx)=-1/[0.5*(1.45+0.93),0.5*(2.45+1.66)]
data_l_s(0:data_n(xx)-1,xx)=[0.5*(1.0/1.45-1.0/0.93),0.5*(1.0/2.45-1.0/1.66)]


; Snyder (2019)
; Section 4 gives best estimate of 0.84 and 67% range of 0.69 to 1.0
; Section 3 gives 0.53 for glacial climates
; figure 4a; range is 0 to -3.5 for non-glacial and -7 to -3.5 for glacial
xx=14
data_t(0:data_n(xx)-1,xx)=[0.5*(-7-3.5),0.5*(0-3.5)]
data_t_s(0:data_n(xx)-1,xx)=[1,1]
data_l(0:data_n(xx)-1,xx)=[-1.0/0.53,-1.0/0.84]


; Duan (2019)
; values from their Table 1 and SI Table S1.
xx=15
data_t(0:data_n(xx)-1,xx)=[3.05,6.23,8.4,9.89]
data_t_s(0:data_n(xx)-1,xx)=[0,0,0,0]

data_l(0:data_n(xx)-1,xx)=[-0.81,-0.9,-0.95,-0.97]
data_l_s(0:data_n(xx)-1,xx)=[0,0,0,0]

data_t_r(0,0:data_n(xx)-1,xx)=[0,3.05,6.23,8.4]
data_t_r(1,0:data_n(xx)-1,xx)=[3.05,6.23,8.4,9.89]
data_t_r(2,0:data_n(xx)-1,xx)=0.5*(data_t_r(0,0:data_n(xx)-1,xx)+data_t_r(1,0:data_n(xx)-1,xx))
data_l_r(0:data_n(xx)-1,xx)=[-0.81,-0.9,-0.95,-0.97]


; Anagnostou (2020)
; Their Supp info, part 2. 
; Table of ECS and time.  
; Take EECO (as defined by Hollis, 49.14 to 53.26).  Mean ECS gives
; 4.5, +- 1 s.d. gives 3.6 to 5.4  Mean temp gives 28.8
; Take late Eocene (41.2 to 33.9).  Mean ECS gives 3.0, 
;   +- 1s.d. gives 1.9 to 4.1   Mean temp gives 22.2
xx=16
data_t(0:data_n(xx)-1,xx)=[22.2,28.8]-14.0
data_l(0:data_n(xx)-1,xx)=-1*forcing*[1/3.0,1/4.5]



; NOW THE PLOTS



for pp=0,npp-1 do begin

thisLetter = "141B
;"
greekLetter = '!9' + String(thisLetter) + '!X'

A1 = FINDGEN(17) * (!PI*2/16.)  
A2a = [-1,1,1,-1,-1]
A2b = [1,1,-1,-1,1] 
USERSYM, COS(A1), SIN(A1), /FILL  
USERSYM, A2a, A2b, /FILL  


; colours...
loadct,0
tvlct,r_0,g_0,b_0,/get
;loadct,39
;tvlct,r_39,g_39,b_39,/get
col_all=intarr(256,3,2)
col_all(*,0,0)=r_0
col_all(*,1,0)=g_0
col_all(*,2,0)=b_0
;col_all(*,0,1)=r_39
;col_all(*,1,1)=g_39
;col_all(*,2,1)=b_39

; dark_cat.txt from Chris Smith's email 
col_all(0:7,0,1)=[221,33,53,170,8,236,50,128]
col_all(0:7,1,1)=[84,52,165,24,46,156,127,54]
col_all(0:7,2,1)=[46,219,197,24,114,46,81,168]

; light blue
col_all(100,0:2,1)=[230,230,250]
; less-light blue
col_all(101,0:2,1)=[180,180,250]
; red
col_all(250,0:2,1)=[250,0,0]

if (pp eq 0 or pp eq 1) then begin
; ************ + Add new Model
studcols(*)=[0,1,2,3,cprox,cprox,cprox,cprox,4,5,6,cprox,cprox,cprox,cprox,0,cprox]
endif
if (pp eq 2) then begin
; ************ + Add new Model
studcols(*)=[cmod,cmod,cmod,cmod,cprox,cprox,cprox,cprox,cmod,cmod,cmod,cprox,cprox,cprox,cprox,cmod,cprox]
endif

set_plot,'ps'

!P.FONT=0

device,/portrait
my_filename='plots/nonlin_ipcc_fgd_'+pname(pp)

device,filename=my_filename+'.ps',/encapsulate,/color,set_font='Helvetica',xsize=9,ysize=5,/inches
plot,data_t(*,0),data_l(*,0),yrange=[ymin,ymax],xrange=[xmin,xmax],xtitle='Global mean temperature anomaly relative to preindustrial [!Eo!NC]',psym=2,/nodata,/noerase,ystyle=1,xmargin=[7,5],ytitle='Feedback parameter, '+greekLetter+' [Wm!E-2 o!NC!E-1!N]',xcharsize=1.0,ycharsize=1.0,position=[0.2,0.2,0.8,0.8],xstyle=1,title='Temperature-dependence of '+greekLetter+' from ESMs and paleoclimate proxies'


if (do_ass(pp) eq 1) then begin
; if do_assessment then plot assessed range
tvlct,col_all(*,0,1),col_all(*,1,1),col_all(*,2,1)
polyfill,[t_ass(0),t_ass(1),t_ass(1),t_ass(0)],[vl_ass(1),vl_ass(1),vl_ass(0),vl_ass(0)],color=100
tvlct,col_all(*,0,0),col_all(*,1,0),col_all(*,2,0)
axis,yaxis=1,color=0,yrange=[ymin,ymax],ystyle=1
axis,yaxis=0,color=0,yrange=[ymin,ymax],ystyle=1

tvlct,col_all(*,0,1),col_all(*,1,1),col_all(*,2,1)
arrow,23,vl_ass(0),23,vl_ass(1),/data,/solid,color=101,hsize=!D.X_SIZE / 128.
arrow,23,vl_ass(1),23,vl_ass(0),/data,/solid,color=101,hsize=!D.X_SIZE / 128.
xyouts,24,0.5*(vl_ass(0)+vl_ass(1)),'assessed very likely range of '+greekLetter,orientation=90,alignment=0.5,charsize=0.8,color=101

endif

countp=0
countm=0

for s=0,nstudies-1 do begin

if (do_plot(s) eq 1) then begin

tvlct,col_all(*,0,studbar(s)),col_all(*,1,studbar(s)),col_all(*,2,studbar(s))


for d=0,data_n(s)-1 do begin

if (pp eq 0) then begin
if (is_paleo(s) eq 0) then begin
; for 'old' plot models as circles, with lines between.  data_t and data_l
USERSYM, COS(A1), SIN(A1), /FILL  
plots,data_t(d,s),data_l(d,s),psym=8,symsize=1,color=studcols(s)
oplot,data_t(0:data_n(s)-1,s),data_l(0:data_n(s)-1,s),color=studcols(s),thick=l_thick
endif
endif


if (pp eq 1 or pp eq 2) then begin
if (is_paleo(s) eq 1) then begin
; for 'new' or 'final' plot proxies as squares, with lines between.  data_t and data_l
USERSYM, A2a, A2b, /FILL  
plots,data_t(d,s),data_l(d,s),psym=8,symsize=1,color=studcols(s)
oplot,data_t(0:data_n(s)-1,s),data_l(0:data_n(s)-1,s),color=studcols(s),thick=l_thick
if (plot_uncert eq 1) then begin
; plot uncertainties on proxies if plot_uncert
oplot,[data_t(d,s)-data_t_s(d,s),data_t(d,s)+data_t_s(d,s)],[data_l(d,s),data_l(d,s)],color=studcols(s),thick=e_thick
oplot,[data_t(d,s),data_t(d,s)],[data_l(d,s)-data_l_s(d,s),data_l(d,s)+data_l_s(d,s)],color=studcols(s),thick=e_thick
endif
endif
endif


if (pp eq 1 or pp eq 2) then begin
if (is_paleo(s) eq 0) then begin
; for 'new' or 'final' plot models as circles, with lines between.  data_t_r and data_l_r
USERSYM, COS(A1), SIN(A1), /FILL  
if (plot_range eq 1) then begin
; show range if plot_range:
oplot,[data_t_r(0,d,s),data_t_r(1,d,s)],[data_l_r(d,s),data_l_r(d,s)],color=studcols(s),thick=e_thick
endif
plots,data_t_r(2,d,s),data_l_r(d,s),psym=8,symsize=1,color=studcols(s)
oplot,data_t_r(2,0:data_n(s)-1,s),data_l_r(0:data_n(s)-1,s),color=studcols(s),thick=l_thick
endif
endif

endfor







; legend

if (pp eq 0 or pp eq 1) then begin
; for 'old' or 'new' show model names and proxy names
if (is_paleo(s)) then begin
countp=countp+1
xyouts,x1,y1+((countp-1)*inc),studname(s),color=studcols(s),charsize=legcharsize
xyouts,x1n,y1+((countp-1)*inc),refname(s),color=studcols(s),charsize=legcharsizen
endif else begin
countm=countm+1
xyouts,x2,y2+((countm-1)*inc),studname(s),color=studcols(s),charsize=legcharsize
xyouts,x2n,y2+((countm-1)*inc),refname(s),color=studcols(s),charsize=legcharsizen
endelse
endif


endif ; end if do_plot


endfor; end loop over studies


tvlct,col_all(*,0,0),col_all(*,1,0),col_all(*,2,0)

if (pp eq 0 or pp eq 1) then begin
; for 'old' or 'new' show model names and proxy names heading
xyouts,x1,y1+countp*inc,'paleoclimate proxies:',color=0,charsize=legcharsize
xyouts,x2,y2+countm*inc,'ESM simulations:',color=0,charsize=legcharsize
endif


if (pp eq 2) then begin
; if 'final' then show simple legend
tvlct,col_all(*,0,0),col_all(*,1,0),col_all(*,2,0)
xyouts,x2,y2+inc,'paleo proxies',color=cprox,charsize=legcharsize
USERSYM, A2a, A2b, /FILL  
plots,x2-dist2,y2+inc+delt,psym=8,symsize=1,color=cprox
plots,x2-dist1,y2+inc+delt,psym=8,symsize=1,color=cprox
oplot,[x2-dist2,x2-dist1],[y2+inc+delt,y2+inc+delt],color=cprox,thick=l_thick

tvlct,col_all(*,0,1),col_all(*,1,1),col_all(*,2,1)
xyouts,x2,y2,'ESM simulations',color=cmod,charsize=legcharsize
USERSYM, COS(A1), SIN(A1), /FILL  
plots,x2-dist2,y2+delt,psym=8,symsize=1,color=cmod
plots,x2-dist1,y2+delt,psym=8,symsize=1,color=cmod
oplot,[x2-dist2,x2-dist1],[y2+delt,y2+delt],color=cmod,thick=l_thick

endif


if (do_explainer eq 1) then begin
; explainer if do_explainer

USERSYM, COS(A1), SIN(A1), /FILL 

plots,xx1(0),yy1(0),psym=8,symsize=1,color=0
plots,xx1(1),yy1(1),psym=8,symsize=1,color=0
oplot,[xx1(0),xx1(1)],[yy1(0),yy1(1)],color=0,thick=l_thick
xyouts,xx1(1)+xxx,0.5*(yy1(0)+yy1(1)),'state-dependence',charsize=0.5
xyouts,xx1(1)+xxx,0.5*(yy1(0)+yy1(1))-0.05,'of feedbacks',charsize=0.5

plots,xx1(0),yy2(0),psym=8,symsize=1,color=0
plots,xx1(1),yy2(1),psym=8,symsize=1,color=0
oplot,[xx1(0),xx1(1)],[yy2(0),yy2(1)],color=0,thick=l_thick
xyouts,xx1(1)+xxx,0.5*(yy2(0)+yy2(1)),'no state-dependence',charsize=0.5
xyouts,xx1(1)+xxx,0.5*(yy2(0)+yy2(1))-0.05,'of feedbacks',charsize=0.5

plots,xx1(0),yy3(0),psym=8,symsize=1,color=0
plots,xx1(1),yy3(1),psym=8,symsize=1,color=0
oplot,[xx1(0),xx1(1)],[yy3(0),yy3(1)],color=0,thick=l_thick
xyouts,xx1(1)+xxx,0.5*(yy3(0)+yy3(1)),'state-dependence',charsize=0.5
xyouts,xx1(1)+xxx,0.5*(yy3(0)+yy3(1))-0.05,'of feedbacks',charsize=0.5

; box around explainer
;oplot,[xl,xr,xr,xl,xl],[yt,yt,yb,yb,yt]

endif


; do arrow
tvlct,col_all(*,0,0),col_all(*,1,0),col_all(*,2,0)
arrow,arx,ary1,arx,ary2,/data,/solid
xyouts,arnx,arny,'increasing climate sensitivity',orientation=90,alignment=0.5,charsize=0.8

print,'converting files'

device,/close
if (make_eps) then spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum
if (make_pdf) then spawn,'ps2pdf '+my_filename+'.eps '+my_filename+'.pdf',dum
if (make_png) then spawn,'convert -flatten -density 500 '+my_filename+'.eps '+my_filename+'.png' 



endfor

stop

end
 
