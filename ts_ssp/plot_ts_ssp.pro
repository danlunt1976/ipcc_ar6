pro pt

;;;;;;;;;;
make_map_plots=1
latlonlabels=0
testing=1
testing_t=18
;;;;;;;;;;

make_pdf=0
make_png=0

nnew=8
nold=3
nerich2100=4
nerich2300=2
nrecent=1
nhawkins=1
ntime=nnew+nold+nerich2100+nerich2300+nrecent+nhawkins

mytype=intarr(ntime)
mytype(0:nnew-1)=0
mytype(nnew:nnew+nold-1)=1
mytype(nnew+nold:nnew+nold+nerich2100-1)=2
mytype(nnew+nold+nerich2100:nnew+nold+nerich2100+nerich2300-1)=3
mytype(nnew+nold+nerich2100+nerich2300:nnew+nold+nerich2100+nerich2300+nrecent-1)=4
mytype(nnew+nold+nerich2100+nerich2300:nnew+nold+nerich2100+nerich2300+nrecent+nhawkins-1)=5


; ** change ntime
timnames=strarr(ntime)
timnameslong=strarr(ntime)
basenameslong=strarr(ntime)
pernameslong=strarr(ntime)
yearnames=strarr(ntime)
histnames=strarr(ntime)

do_plot=intarr(ntime)
do_plot(0:ntime-1)=1
if (testing eq 1) then begin
do_plot(0:ntime-1)=0
do_plot(testing_t)=1
endif

;;;;;;;;;;;;;;;;;;
; SET UP 0:NNEW = my SSPs
nssp=2
nyear=2
nhist=2
namessp=strarr(nssp)
namessp=['ssp126','ssp585']
namessplong=strarr(nssp)
namessplong=['SSP1-2.6','SSP5-8.5']
nameyear=strarr(nyear)
nameyear=['2100','2300']
nameyearlong=strarr(nyear)
nameyearlong=['2081-2100','2281-2300']
namehist=strarr(nhist)
namehist=['1850','1995']
namehistlong=strarr(nhist)
namehistlong=['1850-1900','1995-2014']

xx=0
for s=0,nssp-1 do begin
for y=0,nyear-1 do begin
for h=0,nhist-1 do begin
timnames(xx)=namessp(s)
timnameslong(xx)=namessplong(s)
basenameslong(xx)=namehistlong(h)
pernameslong(xx)=nameyearlong(y)
yearnames(xx)=nameyear(y)
histnames(xx)=namehist(h)
xx=xx+1
endfor
endfor
endfor
;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;
; SET UP NNEW:NNEW+NOLD = ERICH ORIGINAL SSPs
istart=nnew
istop=nnew+nold-1
timnames(istart:istop)=['ssp126','ssp370','ssp585']
timnameslong(istart:istop)=['SSP1-2.6','SSP3-7.0','SSP5-8.5']
basenameslong(istart:istop)=['1995-2014','1995-2014','1995-2014']
pernameslong(istart:istop)=['2081-2100','2081-2100','2081-2100']
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
; SET UP NNEW+NOLD:NNEW+NOLD+NERICH2100 = ERICH NEW 2100 SSPs
istart=nnew+nold
istop=nnew+nold+nerich2100-1
timnames(istart:istop)=['ssp126','ssp245','ssp370','ssp585']
timnameslong(istart:istop)=['SSP1-2.6','SSP2-4.5','SSP3-7.0','SSP5-8.5']
basenameslong(istart:istop)=['1850-1900','1850-1900','1850-1900','1850-1900']
pernameslong(istart:istop)=['2081-2100','2081-2100','2081-2100','2081-2100']
yearnames(istart:istop)=['2100','2100','2100','2100']
histnames(istart:istop)=['1850','1850','1850','1850']
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
; SET UP NNEW+NOLD+NERICH2100:NNEW+NOLD+NERICH2100+NERIC2300 = ERICH
; NEW 2300 SSPs
istart=nnew+nold+nerich2100
istop=nnew+nold+nerich2100+nerich2300-1
timnames(istart:istop)=['ssp126','ssp585']
timnameslong(istart:istop)=['SSP1-2.6','SSP5-8.5']
basenameslong(istart:istop)=['1850-1900','1850-1900']
pernameslong(istart:istop)=['2280-2299','2280-2299']
yearnames(istart:istop)=['2300','2300']
histnames(istart:istop)=['1850','1850']
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
; SET UP
; NNEW+NOLD+NERICH2100+NERICH2300:NNEW+NOLD+NERICH2100+NERIC2300+NRECENT = 1995 vs. 1850
istart=nnew+nold+nerich2100+nerich2300
istop=nnew+nold+nerich2100+nerich2300+nrecent-1
timnames(istart:istop)=['historical']
timnameslong(istart:istop)=['RECENT']
basenameslong(istart:istop)=['1850-1900']
pernameslong(istart:istop)=['1995-2014']
yearnames(istart:istop)=['1995']
histnames(istart:istop)=['1850']
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
; SET UP
; NNEW+NOLD+NERICH2100+NERICH2300:NNEW+NOLD+NERICH2100+NERIC2300+NRECENT+NHAWKINS = 2020 vs. 1850
istart=nnew+nold+nerich2100+nerich2300+nrecent
istop=nnew+nold+nerich2100+nerich2300+nrecent+nhawkins-1
timnames(istart:istop)=['historical']
timnameslong(istart:istop)=['RECENT']
basenameslong(istart:istop)=['1850-1900']
pernameslong(istart:istop)=['2020']
yearnames(istart:istop)=['2020']
histnames(istart:istop)=['1850']
;;;;;;;;;;;;;;;;;;

nvar=1
; ** change ntime
varname=strarr(ntime,nvar)
varname(0:ntime-1,0)=['tas']

varnametitle=strarr(nvar)
varnametitle(0:nvar-1)=['SAT']

nx=360
ny=180
lons=fltarr(nx,ntime)
lats=fltarr(ny,ntime)

; ** change ntime

temp_min_e=fltarr(ntime,nvar)
temp_max_e=fltarr(ntime,nvar)
nnstep=fltarr(ntime,nvar)
my_ndecs=intarr(ntime,nvar)
my_ncols=20

; colour for sat map
temp_min_e(*,*)=-18
temp_max_e(*,*)=18
nnstep(*,*)=2
my_ndecs(*,*)=1

legendline=[-45,-35]
legendtext=-30

linestyle_mod=0
linestyle_band=2

;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Now read in the model data...

ensmean_map=fltarr(nx,ny,ntime,nvar)

dummy_map=fltarr(nx,ny)

for t=0,ntime-1 do begin
for v=0,nvar-1 do begin

if (mytype(t) eq 0 or mytype(t) eq 1 or mytype(t) eq 4 or mytype(t) eq 5) then begin

; read ensemble mean map
if (mytype(t) eq 0 or mytype(t) eq 4) then begin
filenamex='ssp_mod/CMIP6/ensmean_tas_'+timnames(t)+'_'+yearnames(t)+'-'+'historical_'+histnames(t)+'_regrid.nc'
endif
if (mytype(t) eq 1) then begin
filenamex='ssp_mod/tas_annual_longterm_'+timnames(t)+'.nc'
endif
if (mytype(t) eq 5) then begin
filenamex='ssp_mod/Hawkins/for_dan_TS_BK_regrid.nc'
endif

print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_map
ncdf_varget,id1,'lon',dummy_lons
ncdf_varget,id1,'lat',dummy_lats
lons(0:nx-1,t)=dummy_lons(*)
lats(0:ny-1,t)=dummy_lats(*)
; check for missing values
missing_value=-9999.99
aa=ncdf_varinq(id1,varname(t,v))
natts=aa.Natts
for x=0,natts-1 do begin
bb=ncdf_attname(id1,varname(t,v),x)
;print,bb
if (bb eq 'missing_value') then begin
ncdf_attget,id1,varname(t,v),'missing_value',missing_value
;print,'missing is:',missing_value
endif
endfor
i = WHERE(dummy_map EQ missing_value, count)
IF (count GT 0) THEN dummy_map[i] = !VALUES.F_NAN
ensmean_map(*,*,t,v)=dummy_map
ncdf_close,id1

endif

if (mytype(t) eq 2 or mytype(t) eq 3) then begin

; read ensemble mean map
if (mytype(t) eq 2) then begin
filenamex='ssp_mod/tas_annual_longterm_4SSPs.nc'
fileoffset=nold+nnew
endif
if (mytype(t) eq 3) then begin
filenamex='ssp_mod/tas_annual_2300_ssp126_ssp585.nc'
fileoffset=nold+nnew+nerich2100
endif

print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_map
ncdf_varget,id1,'lon',dummy_lons
ncdf_varget,id1,'lat',dummy_lats
lons(0:nx-1,t)=dummy_lons(*)
lats(0:ny-1,t)=dummy_lats(*)
; check for missing values
missing_value=-9999.99
aa=ncdf_varinq(id1,varname(t,v))
natts=aa.Natts
for x=0,natts-1 do begin
bb=ncdf_attname(id1,varname(t,v),x)
;print,bb
if (bb eq 'missing_value') then begin
ncdf_attget,id1,varname(t,v),'missing_value',missing_value
;print,'missing is:',missing_value
endif
endfor
i = WHERE(dummy_map EQ missing_value, count)
IF (count GT 0) THEN dummy_map[i] = !VALUES.F_NAN

ensmean_map(*,*,t,v)=dummy_map(*,*,t-fileoffset)
ncdf_close,id1

endif

endfor
endfor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Global means...

latsedge=fltarr(ny+1)
weight_lat=fltarr(nx,ny)
mod_gmt=fltarr(ntime,nvar)

for t=0,ntime-1 do begin
for v=0,nvar-1 do begin
latsedge(0)=-90
for j=1,ny-1 do begin
latsedge(j)=0.5*(lats(j-1)+lats(j))
endfor
latsedge(ny)=90
for j=0,ny-1 do begin
weight_lat(*,j)=(sin(latsedge(j+1)*2*!pi/360.0)-sin(latsedge(j)*2*!pi/360.0))
endfor
mytot=1.0/total(weight_lat(0:nx-1,0:ny-1),/NAN)
for i=0,nx-1 do begin
weight_lat(i,0:ny-1)=weight_lat(i,0:ny-1)*mytot
endfor
mod_gmt(t,v)=total(ensmean_map(*,*,t,v)*weight_lat(*,*),/nan)
endfor
endfor




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Now the plots...

; set up plots
loadct,0
tvlct,r_0,g_0,b_0,/get
loadct,39
tvlct,r_39,g_39,b_39,/get
set_plot,'ps'
!P.FONT=0

Aaa = FINDGEN(17) * (!PI*2/16.)  
USERSYM, COS(Aaa), SIN(Aaa), /FILL 



if (make_map_plots) then begin

; make map plot

for t=0,ntime-1 do begin

if (do_plot(t) eq 1) then begin

for v=0,nvar-1 do begin

mapname='ensmean'

my_tcharsize=190

my_arr=ensmean_map(*,*,t,v)

map_charsize=230

; filename
if (mytype(t) eq 0 or mytype(t) eq 4 or mytype(t) eq 5) then begin
my_filename=timnames(t)+'_'+yearnames(t)+'-'+'historical_'+histnames(t)+'_modeldata_cont_'+varname(v)+'_ipcc_czt_nodata_ensmean'
endif
if (mytype(t) eq 1) then begin
my_filename=timnames(t)+'_modeldata_cont_'+varname(v)+'_ipcc_czt_nodata_ensmean'
endif
if (mytype(t) eq 2 or mytype(t) eq 3) then begin
my_filename=timnames(t)+'_erich_'+yearnames(t)+'-'+'historical_'+histnames(t)+'_modeldata_cont_'+varname(v)+'_ipcc_czt_nodata_ensmean'
endif



print,my_filename
psopen,file=my_filename+'.ps',tcharsize=my_tcharsize,charsize=map_charsize
nncols=2.0+(temp_max_e(t,v)-temp_min_e(t,v))/nnstep(t,v)
if (nncols ne my_ncols) then begin
print,'wrong number of colours specified',nncols,my_ncols
stop
endif
CS, SCALE=22,ncols=nncols

if (my_ncols eq 20) then begin
; from the IPCC plot guide, this is Temperature, divergent,
; temp_div_desc.txt; temp_div_20
tvlct,5,48,97,2
tvlct,21,74,122,3
tvlct,37,100,148,4
tvlct,53,126,174,5
tvlct,73,150,196,6
tvlct,105,168,206,7
tvlct,137,186,215,8
tvlct,169,204,225,9
tvlct,201,222,234,10
tvlct,233,240,244,11
tvlct,245,235,233,12
tvlct,239,208,203,13
tvlct,233,181,173,14
tvlct,227,155,143,15
tvlct,221,128,113,16
tvlct,215,101,83,17
tvlct,190,75,67,18
tvlct,161,50,55,19
tvlct,132,25,43,20
tvlct,103,0,31,21
endif

map,/robinson
LEVS, MIN=temp_min_e(t,v), MAX=temp_max_e(t,v), STEP=nnstep(t,v), ndecs=my_ndecs(t,v)

thistitle=strtrim(varnametitle(v)+' ('+timnameslong(t)+': '+pernameslong(t)+' - '+basenameslong(t)+'): '+string(mod_gmt(t,v),format='(F4.1)')+' !Eo!NC',2)

CON, F=my_arr,x=lons(*,t),y=lats(*,t),TITLE=thistitle, CB_TITLE='temperature anomaly [!Eo!NC]',/NOLINES,/block,CB_NTH=2
CON, F=my_arr,x=lons(*,t),y=lats(*,t),/NOLINES,/nocolbar

nglon=5
grids_lon=fltarr(nglon)
grids_lon(*)=[60,30,0,-30,-60]
grids_lon_label=strarr(nglon)
grids_lon_label=['60N','30N','EQ','30S','60S']
grids_lat_offset=[-5,-5,-5,-5,-5]
for g=0,nglon-1 do begin
plots,[0,180],[grids_lon(g),grids_lon(g)],color=1,linestyle=1,thick=0.1
plots,[-180,-0.001],[grids_lon(g),grids_lon(g)],color=1,linestyle=1,thick=0.1
if (latlonlabels eq 1) then begin
xyouts,-175,grids_lon(g)+grids_lat_offset(g),grids_lon_label(g),color=1,charsize=0.8
endif
endfor

nglat=3
grids_lat=fltarr(nglat)
grids_lat(*)=[-90,0,90]
grids_lat_label=strarr(nglat)
grids_lat_label=['90W','0','90E']
grids_lat_offset=[-30,-10,-20]
for g=0,nglat-1 do begin
inc=5
ninc=180.0/inc
for i=0,ninc-1 do begin
plots,[grids_lat(g),grids_lat(g)],[90-inc*i,90-inc*(i+1)],color=1,linestyle=1,thick=0.1
endfor
if (latlonlabels eq 1) then begin
xyouts,grids_lat(g)+grids_lat_offset(g),-85,grids_lat_label(g),color=1,charsize=0.8
endif
endfor

psclose,/noview
spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum
if (make_pdf eq 1) then begin
spawn,'ps2pdf -dEPSCrop -dAutoRotatePages=/None '+my_filename+'.eps '+my_filename+'.pdf',dum
endif


endfor ; end v

endif ; end do_plot

endfor ; end t

endif ; end make map plots


stop

end


