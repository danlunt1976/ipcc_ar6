pro pa

;;;;;;;;;;
read_mod=1
read_proxy=1
make_zon_plots=1 ; plot zonal mean ensemble mean [default=0 or 1]
make_map_plots=1 ; plot maps ensemble mean [default=0 or 1;=1 for TS]
make_map_mod_plots=0 ; plot maps of each individual model [default=0]
make_gmt_plots=0 ; plot gmst [default=0 or 1]
rev_lgm=0 ; re-reverse LGM [default=0;=1 for TS]
all_proxies=0 ; plot all proxies [default=0;=1 for TS]
make_nodata=0 ; plot maps without data [default=0;=1 for TS version B]
latlonlabels=0 ; label lats/lons [default=0;=1 for TS]
make_csv_map=1
make_csv_gmt=0
;;;;;;;;;;

;;;;;;;;;;
; becasue IDL default plot sizes get overwritten when using met-idl
; routines, and I can't figure out how to re-set them. 
if (make_gmt_plots eq 1) then begin
make_map_plots=0
endif
;;;;;;;;;;


make_pdf=0
make_png=0

do_checks=0 ; plot extra lines on zonal mean plots [default=0]
do_tcheck=0 ; plot old and new values of historical obs [default=0]
do_mod_leg=0 ; plot model names on model zonal mean lines [default=0]
plot_names_gmt=0 ; plot model names on gmst plot [default=0]
do_dots=1 ; plot circles at centre of assessed obs of GMST [default=1]




;;;;;;;;;;
;;;;;;;;;;

nlim_count=5

;;;;;;;
problem_missing=[-1,-1,-1]
; no missing data

pl_data_sat='salzmann'

;pl_data_sst='dowsett'
;pl_data_sst='pliovar'
pl_data_sst='pliovar_erin_pangaea'

lg_data_sat='bartlein'
;lg_data_sat_add=''
lg_data_sat_add='cleator'

;lg_data_sst='tierney-2019-grid'
lg_data_sst='tierney-2020-grid'
;lg_data_sst='tierney-2020'

eo_data_all='inglis'

do_opp=0 ; =1 to overplot SAT on SST and vice-versa

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; definitions and names

ntime=3

; ** change ntime
timnames=strarr(ntime)
timnames(0:ntime-1)=['pl','lg','eo']
timnameslong=strarr(ntime)
timnameslong(0:ntime-1)=['MPWP','LGM','EECO']

mipnames=strarr(ntime)
mipnames(0:ntime-1)=['PlioMIP','PMIP4','DeepMIP']

; ** change ntime
fact_mod_sign=fltarr(ntime)
fact_mod_sign(*)=[1,-1,1]
name_sign=strarr(ntime)
name_sign(*)=''
if (rev_lgm eq 1) then begin
fact_mod_sign(1)=fact_mod_sign(1)*(-1)
name_sign(1)='_-1'
make_zon_plots=0
make_gmt_plots=0
endif


; ** change ntime
topofile=strarr(ntime)
topovar=strarr(ntime)
topofile(0:ntime-1)=['pl_mask/Plio_enh_topo_v1.0_regrid.nc','lg_mask/peltier_ice4g_orog_21_regrid.nc','eo_mask/herold_etal_eocene_topo_1x1.nc']
topovar(0:ntime-1)=['p4_topo','orog','topo']

; ** change ntime
; ** change nmod
nmod=intarr(ntime)
nmod(0:ntime-1)=[17,9,7]
nmodmax=max(nmod)

; ** change ntime
; ** change nmod
modnames=strarr(ntime,nmodmax)
modnames(0,0:nmod(0)-1)=['CCSM4','CCSM4-UoT','CCSM4-Utrecht','CESM1.2','CESM2.0','COSMOS','EC-Earth3.3','GISS-E2-1-G','HadCM3','HadGEM3','IPSL-CM6A-LR','IPSLCM5A','IPSLCM5A2','MIROC4m','MRI-CGCM2.3','NorESM-L','NorESM1-F']
modnames(1,0:nmod(1)-1)=['MPI-ESM1-2-LR','AWIESM1','AWIESM2','CESM1_2','CESM2_1','INM-CM4-8','IPSLCM5A2','MIROC-ES2L','UofT-CCSM4']
modnames(2,0:nmod(2)-1)=['CESM1.2_CAM5-deepmip_stand_6xCO2','COSMOS-landveg_r2413-deepmip_sens_4xCO2','GFDL_CM2.1-deepmip_stand_6xCO2','GFDL_CM2.1-deepmip_sens_4xCO2','INM-CM4-8-deepmip_stand_6xCO2','NorESM1_F-deepmip_sens_4xCO2','CESM2.1slab_3x']

; ** change ntime
extenszon=strarr(ntime)
extensmap=strarr(ntime)
extenszon(0:ntime-1)=['','','_forzon']
extensmap(0:ntime-1)=['','','_formap']


; ** change ntime
; ** change nmod
modcol=intarr(ntime,nmodmax)
modcol(0,0:nmod(0)-1)=[1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3]
modcol(1,0:nmod(1)-1)=[1,2,3,4,5,6,7,1,2]
modcol(2,0:nmod(2)-1)=[1,2,3,4,5,6,7]

nvar=2

; ** change ntime
varname=strarr(ntime,nvar)
varname(0,0:nvar-1)=['tas','tos']
varname(1,0:nvar-1)=['tas','tos']
varname(2,0:nvar-1)=['tas','tos']

varnamelong=strarr(nvar)
varnamelong(0:nvar-1)=['NearSurfaceTemperature','SST']
varnameshort=strarr(nvar)
varnameshort(0:nvar-1)=['tas','tos']
varnametitle=strarr(nvar)
varnametitle(0:nvar-1)=['SAT','SST']

; ** change ntime
varnamemod=strarr(ntime,nmodmax,nvar)
varnamemod(0,0:nmod(0)-1,0)='tas'
varnamemod(0,0:nmod(0)-1,1)='tos'
varnamemod(1,0:nmod(1)-1,0)='tas'
varnamemod(1,0:nmod(1)-1,1)='tos'
varnamemod(2,0:nmod(2)-1,0)='tas'
varnamemod(2,0:nmod(2)-1,1)='tos'

; ** change ntime and nmod
exist_data=intarr(ntime,nmodmax,nvar)
exist_data(0,0:nmod(0)-1,*)=1 ; all plio exist

exist_data(1,0:nmod(1)-1,*)=1 ; all LGM exist

exist_data(2,0:nmod(2)-1,*)=1 ; all eocene exist


; ** change ntime and nmod
plot_zon=intarr(ntime,nmodmax)
plot_zon(0,0:nmod(0)-1)=1 ; plot all plio zon
plot_zon(1,0:nmod(1)-1)=1 ; plot all LGM zon
plot_zon(2,0:nmod(2)-1)=[1,1,1,1,1,0,0] ; don't plot eocene CESM2 or NorESM zon

nx=360
ny=180

lats=fltarr(ny)
lons=fltarr(nx)
lons=findgen(nx)
lats=-89.5+findgen(ny)
latsedge=fltarr(ny+1)
latsedge=-90+findgen(ny+1)

weight_lat=fltarr(ny)
for j=0,ny-1 do begin
weight_lat(j)=(sin(latsedge(j+1)*2*!pi/360.0)-sin(latsedge(j)*2*!pi/360.0))
endfor
weight_lat(0:ny-1)=weight_lat(0:ny-1)/total(weight_lat(0:ny-1),/NAN)

; ** change ntime
; y-scale for zonal mean plot
my_yrange5=intarr(ntime,nvar,2)
my_yrange5(0,0,*)=[-5,20]
my_yrange5(1,0,*)=[-5,20]
my_yrange5(2,0,*)=[-10,55]
my_yrange5(0,1,*)=[-3,13]
my_yrange5(1,1,*)=[-3,13]
my_yrange5(2,1,*)=[-10,40]


; ** change ntime

temp_min_e=fltarr(ntime,nvar)
temp_max_e=fltarr(ntime,nvar)
nnstep=fltarr(ntime,nvar)
my_ndecs=intarr(ntime,nvar)
my_ncols=20
;;;;;
if (my_ncols eq 21) then begin
; colour for sat map
temp_min_e(*,0)=[-19,-19,-19]
temp_max_e(*,0)=[19,19,19]
nnstep(*,0)=[2,2,2]
my_ndecs(*,0)=[1,1,1]
; colour for sst map
temp_min_e(*,1)=[-4.75,-4.75,-19]
temp_max_e(*,1)=[4.75,4.75,19]
nnstep(*,1)=[0.5,0.5,2]
my_ndecs(*,1)=[2,2,1]
endif

if (my_ncols eq 20) then begin
; colour for sat map
temp_min_e(*,0)=[-18,-18,-18]
temp_max_e(*,0)=[18,18,18]
nnstep(*,0)=[2,2,2]
my_ndecs(*,0)=[1,1,1]
; colour for sst map
temp_min_e(*,1)=[-4.5,-4.5,-18]
temp_max_e(*,1)=[4.5,4.5,18]
nnstep(*,1)=[0.5,0.5,2]
my_ndecs(*,1)=[2,2,1]
endif

legendline=[-45,-35]
legendtext=-30

linestyle_mod=0
linestyle_band=2

name_all=''
if (all_proxies eq 1) then begin
name_all='_allproxies'
endif

;;;;;


;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Now read in the model data...

if (read_mod eq 1) then begin

mod_map=fltarr(nx,ny,nmodmax,ntime,nvar)
modmean_map=fltarr(nx,ny,ntime,nvar)
modaver_map=fltarr(nx,ny,ntime,nvar)

ensmean_map=fltarr(nx,ny,ntime,nvar)
ensmean_mask=fltarr(nx,ny,ntime,nvar)
ensaver_map=fltarr(nx,ny,ntime,nvar)
ensaver_mask=fltarr(nx,ny,ntime,nvar)

ensmean_zon=fltarr(ny,ntime,nvar)
ensmean_zon_check1=fltarr(ny,ntime,nvar)
ensmean_zon_check2=fltarr(ny,ntime,nvar)

ensaver_zon=fltarr(ny,ntime,nvar)
ensaver_zon_check1=fltarr(ny,ntime,nvar)
ensaver_zon_check2=fltarr(ny,ntime,nvar)

mod_zon=fltarr(ny,nmodmax,ntime,nvar)
topo_map=fltarr(nx,ny,ntime)
mod_gmt=fltarr(nmodmax,ntime,nvar)

dummy_zon=fltarr(ny)
dummy_map=fltarr(nx,ny)

for t=0,ntime-1 do begin
for v=0,nvar-1 do begin

for m=0,nmod(t)-1 do begin

if (exist_data(t,m,v) eq 1) then begin

; read individual models zonal mean (mod_zon(j,m,t,v))
print,modnames(t,m)
filenamex=timnames(t)+'_mod/mod_'+modnames(t,m)+'_'+timnames(t)+'-pi'+'_'+varnamelong(v)+'_zonmean.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varnamemod(t,m,v),dummy_zon
; check for missing values
missing_value=-9999.99
aa=ncdf_varinq(id1,varnamemod(t,m,v))
natts=aa.Natts
for x=0,natts-1 do begin
bb=ncdf_attname(id1,varnamemod(t,m,v),x)
;print,bb
if (bb eq 'missing_value') then begin
ncdf_attget,id1,varnamemod(t,m,v),'missing_value',missing_value
;print,'missing is:',missing_value
endif
endfor
i = WHERE(dummy_zon EQ missing_value, count)
IF (count GT 0) THEN dummy_zon[i] = !VALUES.F_NAN

mod_zon(*,m,t,v)=fact_mod_sign(t)*dummy_zon
ncdf_close,id1

; calculate global mean (N.B. not correct for SST as mean of zonal mean)
mod_gmt(m,t,v)=total(mod_zon(*,m,t,v)*weight_lat(*),/nan)*fact_mod_sign(t)

; read individual model maps (mod_map(i,j,m,t,v))
filenamex=timnames(t)+'_mod/mod_'+modnames(t,m)+'_'+varnamelong(v)+'_'+timnames(t)+'-pi.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_map
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
mod_map(*,*,m,t,v)=fact_mod_sign(t)*dummy_map
ncdf_close,id1


endif else begin
mod_zon(*,m,t,v)=!VALUES.F_NAN
mod_gmt(m,t,v)=!VALUES.F_NAN
endelse

endfor ; end m



; read ensemble mean zonal mean ensmean_zon(j,j,v)
filenamex=timnames(t)+'_mod/ensmean_'+timnames(t)+'-pi'+'_'+varnamelong(v)+'_zonmean'+extenszon(t)+'.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_zon
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
i = WHERE(dummy_zon EQ missing_value, count)
IF (count GT 0) THEN dummy_zon[i] = !VALUES.F_NAN
ensmean_zon(*,t,v)=fact_mod_sign(t)*dummy_zon
ncdf_close,id1

; read ensemble aver zonal mean ensaver_zon(j,j,v)
filenamex=timnames(t)+'_mod/ensavg_'+timnames(t)+'-pi'+'_'+varnamelong(v)+'_zonmean'+extenszon(t)+'.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_zon
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
i = WHERE(dummy_zon EQ missing_value, count)
IF (count GT 0) THEN dummy_zon[i] = !VALUES.F_NAN
ensaver_zon(*,t,v)=fact_mod_sign(t)*dummy_zon
ncdf_close,id1

; read ensemble mean map
filenamex=timnames(t)+'_mod/ensmean_'+timnames(t)+'-pi'+'_'+varnamelong(v)+extensmap(t)+'.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_map
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
ensmean_map(*,*,t,v)=fact_mod_sign(t)*dummy_map
ensmean_mask(*,*,t,v)=1.0-finite(dummy_map)
ncdf_close,id1

; read ensemble aver map
filenamex=timnames(t)+'_mod/ensavg_'+timnames(t)+'-pi'+'_'+varnamelong(v)+extensmap(t)+'.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_map
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
ensaver_map(*,*,t,v)=fact_mod_sign(t)*dummy_map
ensaver_mask(*,*,t,v)=1.0-finite(dummy_map)
ncdf_close,id1

endfor

filenamex=topofile(t)
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,topovar(t),dummy_map
topo_map(*,*,t)=dummy_map
ncdf_close,id1

endfor


; now produce some checks:

print,'making checks'

for v=0,nvar-1 do begin
for t=0,ntime-1 do begin
; calculate zonal means from models
for y=0,ny-1 do begin
ensmean_zon_check1(y,t,v)=mean(mod_zon(y,where(plot_zon(t,0:nmod(t)-1) eq 1),t,v),/NAN)
ensmean_zon_check2(y,t,v)=mean(ensmean_map(0:nx-1,y,t,v),/NAN)
ensaver_zon_check1(y,t,v)=mean(mod_zon(y,where(plot_zon(t,0:nmod(t)-1) eq 1),t,v),/NAN) ; [same as ensmean_zon_check1 - correct?]
ensaver_zon_check2(y,t,v)=mean(ensaver_map(0:nx-1,y,t,v),/NAN) 
endfor
endfor
endfor

ensmean_mean=fltarr(ntime,nvar)
for v=0,nvar-1 do begin
for t=0,ntime-1 do begin
ensmean_mean(t,v)=total(ensmean_zon(*,t,v)*weight_lat(*),/nan)*fact_mod_sign(t)
endfor
endfor

for v=0,nvar-1 do begin
for t=0,ntime-1 do begin
for y=0,ny-1 do begin
for x=0,nx-1 do begin
; calculate mean map from models
modmean_map(x,y,t,v)=mean(mod_map(x,y,where(plot_zon(t,0:nmod(t)-1) eq 1),t,v),/NAN)
modaver_map(x,y,t,v)=mean(mod_map(x,y,where(plot_zon(t,0:nmod(t)-1) eq 1),t,v))
endfor
endfor
endfor
endfor




endif ; end read_mod

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Now read in the proxy data...

if (read_proxy eq 1) then begin

ndatamax=1000
ndata=intarr(ntime,nvar)

missing_err=2.0

if (eo_data_all eq 'inglis') then begin
ndata(2,0)=47
ndata(2,1)=19
ndataing=intarr(nvar)
ndataing(0)=80
ndataing(1)=27
endif

if (pl_data_sat eq 'salzmann') then begin
ndata(0,0)=8
endif

if (pl_data_sst eq 'dowsett') then begin
ndata(0,1)=37
endif
if (pl_data_sst eq 'pliovar') then begin
ndata(0,1)=23
endif
if (pl_data_sst eq 'pliovar_erin_pangaea') then begin
ndata(0,1)=32
endif

if (lg_data_sat eq 'bartlein') then begin
ndata(1,0)=98
endif

if (lg_data_sst eq 'tierney-2019-grid') then begin
ndata(1,1)=200
endif
if (lg_data_sst eq 'tierney-2020-grid') then begin
ndata(1,1)=227
endif
if (lg_data_sst eq 'tierney-2020') then begin
ndata(1,1)=512
endif



lons_d=fltarr(ndatamax,ntime,nvar)
lats_d=fltarr(ndatamax,ntime,nvar)
temps_d=fltarr(ndatamax,ntime,nvar)
errs_d=fltarr(2,ndatamax,ntime,nvar)

temps_m_aver=fltarr(ndatamax,ntime,nvar)
temps_m_mean=fltarr(ndatamax,ntime,nvar)

lons_m_aver=fltarr(ndatamax,ntime,nvar)
lons_m_mean=fltarr(ndatamax,ntime,nvar)
lats_m_aver=fltarr(ndatamax,ntime,nvar)
lats_m_mean=fltarr(ndatamax,ntime,nvar)

;;;;;;
; Eocene

if (eo_data_all eq 'inglis') then begin

nrows_d=209
all_lons=fltarr(nrows_d)
all_lats=fltarr(nrows_d)
all_temps=fltarr(nrows_d)
all_times=strarr(nrows_d)
all_vars=fltarr(nrows_d)
all_vars_tmp=strarr(nrows_d)
all_v2=fltarr(nrows_d)
all_upper=fltarr(nrows_d)
all_lower=fltarr(nrows_d)

row_temp=strarr(1)
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/eo_data/Hollis_2019_DeepMIP_compilation_Inglis.csv'
;print,'STARTING READ'

readf,2,row_temp
for i=0,nrows_d-1 do begin
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
all_lons(i)=data_row(7) ; mantle
all_lats(i)=data_row(6) ; mantle
all_temps(i)=data_row(11)
all_times(i)=data_row(1)
all_vars_tmp(i)=data_row(2)
all_v2(i)=data_row(20) ; needed for for most recent Hollis file
all_upper(i)=data_row(17)
all_lower(i)=data_row(16)
endfor
close,2

all_vars=0*(all_vars_tmp eq 'lat')+1*(all_vars_tmp eq 'sst')
this_index=(all_times eq 'eeco')
; no-frosty:
this_index=this_index*(all_v2 eq 1)

this_index_sst=this_index*(all_vars eq 1)
this_index_sat=this_index*(all_vars eq 0)

ncolumns_sst=total(this_index_sst)
ncolumns_sat=total(this_index_sat)

if (ncolumns_sat ne ndataing(0)) then begin
print,'unepxected N',ncolumns_sat,ndataing(0)
stop
endif
if (ncolumns_sst ne ndataing(1)) then begin
print,'unepxected N',ncolumns_sst,ndataing(1)
stop
endif

my_deepmip_err=5.0

lons_d_ing=fltarr(ndatamax,nvar)
lats_d_ing=fltarr(ndatamax,nvar)
temps_d_ing=fltarr(ndatamax,nvar)
errs_d_ing=fltarr(2,ndatamax,nvar)

lons_d_ing(0:ndataing(0)-1,0)=all_lons(where(this_index_sat))
lons_d_ing(0:ndataing(1)-1,1)=all_lons(where(this_index_sst))
lats_d_ing(0:ndataing(0)-1,0)=all_lats(where(this_index_sat))
lats_d_ing(0:ndataing(1)-1,1)=all_lats(where(this_index_sst))

temps_d_ing(0:ndataing(0)-1,0)=all_temps(where(this_index_sat))+273.15 ; degrees K
temps_d_ing(0:ndataing(1)-1,1)=all_temps(where(this_index_sst))

this_upper=all_upper(where(this_index_sat)) ; degrees C
this_upper=(this_upper+273.15)*(this_upper ne -999.9) + (this_upper eq -999.9)*(temps_d_ing(0:ndataing(0)-1,0)+my_deepmip_err) ; degrees K
this_lower=all_lower(where(this_index_sat)) ; degrees C
this_lower=(this_lower+273.15)*(this_lower ne -999.9) + (this_lower eq -999.9)*(temps_d_ing(0:ndataing(0)-1,0)-my_deepmip_err) ; degrees K
errs_d_ing(0,0:ndataing(0)-1,0)=this_upper-temps_d_ing(0:ndataing(0)-1,0);+273.15 ; delta plus
errs_d_ing(1,0:ndataing(0)-1,0)=temps_d_ing(0:ndataing(0)-1,0)-this_lower;-273.15  ; delta minus

this_upper=all_upper(where(this_index_sst))
this_upper=this_upper*(this_upper ne -999.9) + (this_upper eq -999.9)*(temps_d_ing(0:ndataing(1)-1,1)+my_deepmip_err)
this_lower=all_lower(where(this_index_sst))
this_lower=this_lower*(this_lower ne -999.9) + (this_lower eq -999.9)*(temps_d_ing(0:ndataing(1)-1,1)-my_deepmip_err)
errs_d_ing(0,0:ndataing(1)-1,1)=this_upper-temps_d_ing(0:ndataing(1)-1,1)  ; delta plus
errs_d_ing(1,0:ndataing(1)-1,1)=temps_d_ing(0:ndataing(1)-1,1)-this_lower  ; delta minus


; check for duplicates
; errs_d, lons_d, lats_d, temps_d

t=2

for v=0,1 do begin
xx=0
for d=0,ndataing(v)-1 do begin

matching=(lons_d_ing(d,v) eq lons_d_ing(0:ndataing(v)-1,v) and lats_d_ing(d,v) eq lats_d_ing(0:ndataing(v)-1,v))
count_dd=total(matching)
match_dd=where(matching eq 1)
if (count_dd ne 1) then begin

if (temps_d_ing(d,v) ne 1e30) then begin

new_temp=mean(temps_d_ing(match_dd,v))
;print,t,v,d,count_dd,lons_d_ing(d,v),lats_d_ing(d,v),temps_d_ing(d,v),new_temp
new_errs_0=mean(errs_d_ing(0,match_dd,v))
new_errs_1=mean(errs_d_ing(1,match_dd,v))

lons_d(xx,t,v)=lons_d_ing(d,v)
lats_d(xx,t,v)=lats_d_ing(d,v)
temps_d(xx,t,v)=new_temp
errs_d(0,xx,t,v)=new_errs_0
errs_d(1,xx,t,v)=new_errs_1

temps_d_ing(match_dd,v)=1e30

xx=xx+1

endif

endif else begin

lons_d(xx,t,v)=lons_d_ing(d,v)
lats_d(xx,t,v)=lats_d_ing(d,v)
temps_d(xx,t,v)=temps_d_ing(d,v)
errs_d(0,xx,t,v)=errs_d_ing(0,d,v)
errs_d(1,xx,t,v)=errs_d_ing(1,d,v)

xx=xx+1

endelse

endfor

print,'ndata is: ',t,v,xx
if (xx ne ndata(t,v)) then begin
print,'unepxected N',xx,ndata(t,v)
stop
endif

endfor




; now find the preind temperatures at these sites.

filenamencp='eo_data/air.2m_ann_tmp_remapbil_zonmean_enlarge.nc'
varname='air'
print,filenamencp
id1=ncdf_open(filenamencp)
ncdf_varget,id1,varname,dummy_ncp
ncdf_varget,id1,'longitude',lons_ncp
ncdf_varget,id1,'latitude',lats_ncp
missing_value=-9999.99
aa=ncdf_varinq(id1,varname)
natts=aa.Natts
for x=0,natts-1 do begin
bb=ncdf_attname(id1,varname,x)
;print,bb
if (bb eq 'missing_value') then begin
ncdf_attget,id1,varname,'missing_value',missing_value
;print,'mising is:',missing_value
endif
if (bb eq '_FillValue') then begin
ncdf_attget,id1,varname,'_FillValue',missing_value1
;print,'mising1 is:',missing_value1
endif
endfor
ncdf_close,id1
ncp_tmp=dummy_ncp
i = WHERE(dummy_ncp EQ missing_value, count)
IF (count GT 0) THEN ncp_tmp[i] = !VALUES.F_NAN
i = WHERE(dummy_ncp EQ missing_value1, count)
IF (count GT 0) THEN ncp_tmp[i] = !VALUES.F_NAN


; Now locate nearest temperature for data points
for d=0,ndataing(0)-1 do begin
find_lonlat,nx,ny,lons_ncp,lats_ncp,lons_d(d,2,0),lats_d(d,2,0),ncp_tmp,xindex,yindex
;print,'adjusting for preind: ',d
;print,temps_d(d,2,0)
;print,lons_d(d,2,0),lats_d(d,2,0)
;print,lons_ncp(xindex),lats_ncp(yindex)
;print,ncp_tmp(xindex,yindex)
temps_d(d,2,0)=temps_d(d,2,0)-ncp_tmp(xindex,yindex)
;print,temps_d(d,2,0)
endfor


filenamehad='eo_data/HadISST_sst_ycdo_remapbil_zonmean_enlarge.nc'
varname='sst'
print,filenamehad
id1=ncdf_open(filenamehad)
ncdf_varget,id1,varname,dummy_had
ncdf_varget,id1,'longitude',lons_had
ncdf_varget,id1,'latitude',lats_had
missing_value=-9999.99
aa=ncdf_varinq(id1,varname)
natts=aa.Natts
for x=0,natts-1 do begin
bb=ncdf_attname(id1,varname,x)
;print,bb
if (bb eq 'missing_value') then begin
ncdf_attget,id1,varname,'missing_value',missing_value
;print,'mising is:',missing_value
endif
if (bb eq '_FillValue') then begin
ncdf_attget,id1,varname,'_FillValue',missing_value1
;print,'mising1 is:',missing_value1
endif
endfor
ncdf_close,id1
had_tmp=dummy_had
i = WHERE(dummy_had EQ missing_value, count)
IF (count GT 0) THEN had_tmp[i] = !VALUES.F_NAN
i = WHERE(dummy_had EQ missing_value1, count)
IF (count GT 0) THEN had_tmp[i] = !VALUES.F_NAN


; Now locate nearest temperature for data points
for d=0,ndata(2,1)-1 do begin
find_lonlat,nx,ny,lons_had,lats_had,lons_d(d,2,1),lats_d(d,2,1),had_tmp,xindex,yindex
;print,'adjusting for preind: ',d
;print,temps_d(d,2,1)
;print,lons_d(d,2,1),lats_d(d,2,1)
;print,lons_had(xindex),lats_had(yindex)
;print,had_tmp(xindex,yindex)
temps_d(d,2,1)=temps_d(d,2,1)-had_tmp(xindex,yindex)
;print,temps_d(d,2,1)
endfor

endif ; end inglis


;;;;;

if (pl_data_sst eq 'dowsett') then begin
; PLIOCENE:
row_temp=''
row_head=''
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/sod/pl_data/cs_mp_sst_data_30k_plusNOAA_djl.csv'
readf,2,row_head
;print,row_head
for i=0,ndata(0,1)-1 do begin
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
;print,'We are: ',i
;print,data_row
;print,size(data_row)
lons_d(i,0,1)=data_row(2)
lats_d(i,0,1)=data_row(1)

; This is for HadISST:
;temps_d(i,0,1)=data_row(12)
; This is for NOAAERSST5:
temps_d(i,0,1)=data_row(14)

if (data_row(5) ne 999) then begin
errs_d(0,i,0,1)=data_row(5)
errs_d(1,i,0,1)=data_row(5)
endif else begin
errs_d(0,i,0,1)=missing_err
errs_d(1,i,0,1)=missing_err
endelse
endfor
close,2
endif


if (pl_data_sst eq 'pliovar') then begin

; PLIOCENE:
row_temp=''
row_head=''
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/sod/pl_data/PlioVAR-KM5c_T_only_-_for_DanIPCC_djl.csv'
readf,2,row_head
;print,row_head
xx=0
for i=0,32 do begin
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
;print,'We are: ',i
;print,data_row
;print,size(data_row)

if (data_row(19) ne '') then begin

lons_d(xx,0,1)=data_row(1)
lats_d(xx,0,1)=data_row(2)

; This is for alkenone Bayesian:
temps_d(xx,0,1)=data_row(19)

errs_d(0,xx,0,1)=data_row(5)
errs_d(1,xx,0,1)=data_row(5)

xx=xx+1

endif

endfor
close,2

if (xx ne ndata(0,1)) then begin
print,'unexpcted N',xx,ndata(0,1)-1
stop
endif


endif

if (pl_data_sst eq 'pliovar_erin_pangaea') then begin

names_d=strarr(100)

; PLIOCENE:
row_temp=''
row_head=strarr(98)
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/pl_data/PlioVAR-KM5c_T_jess.tab'
readf,2,row_head
;print,row_head

xx=0
for i=0,31 do begin
;print,'We are i: ',i
readf,2,row_temp
data_row=strsplit(row_temp,string(9B),/extract,/preserve_null)
;print,data_row
ss=size(data_row)
if (ss(1) ne 20) then begin
print,'wrong row-length'
stop
endif


if (data_row(13) ne '' or data_row(15) ne '') then begin

names_d(xx)=data_row(1)

lons_d(xx,0,1)=data_row(3)
lats_d(xx,0,1)=data_row(2)

if (data_row(13) ne '' and data_row(15) eq '') then begin
temps_d(xx,0,1)=data_row(13)
endif
if (data_row(15) ne '' and data_row(13) eq '') then begin
temps_d(xx,0,1)=data_row(15)
endif
if (data_row(13) ne '' and data_row(15) ne '') then begin
temps_d(xx,0,1)=( (1.0*data_row(13)) + (1.0*data_row(15)) ) /2.0
print,'duplication!'
print,names_d(xx)
print,data_row(13)
print,data_row(15)
print,temps_d(xx,0,1)
endif

;errs_d(0,xx,0,1)=missing_err
;errs_d(1,xx,0,1)=missing_err

xx=xx+1

;print,'We are xx: ',xx

endif

endfor
close,2

if (xx ne ndata(0,1)) then begin
print,'unexpected N',xx,ndata(0,1)
stop
endif


; Now read in Jess's uncertainties

; for old or new data (change in site 609)
jess_file='new'
;jess_file='orig'

; first mg/ca
n_j1=12
row_temp=strarr(1)
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/pl_data/PlioVar_mgca_'+jess_file+'_unix_erin.csv'
print,'STARTING READ Jess'
print,'mg/ca'
; file created by manually removing ^M symbols (dos2unix didn't
; work...), and then changing names of sites to match those in
; Pangaea: odp131 -> u1313 ; odp603 -> dsdp603 ; remove odp590 ; added
; comment on 603

names_j1=strarr(n_j1)
lats_j1=fltarr(n_j1)
lons_j1=fltarr(n_j1)
temps_j1=fltarr(n_j1)
err_j1=fltarr(n_j1)

readf,2,row_temp
;print,'header: '+row_temp
for i=0,n_j1-1 do begin
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
;print,data_row
names_j1(i)=data_row(0)
print,names_j1(i)
lats_j1(i)=data_row(1)
lons_j1(i)=data_row(2)
temps_j1(i)=data_row(8)
err_j1(i)=data_row(9)
endfor
close,2

print,'matching mg/ca:'
for i=0,n_j1-1 do begin
print,names_j1(i)
jj=strmatch(names_d,names_j1(i),/FOLD_CASE)
;print,jj
;print,where(jj eq 1)
if (total(jj) ne 1) then begin
print,'Mg/Ca: too many or no names matching: ',total(where(jj eq 1))
stop
endif
if (abs(lats_j1(i)-lats_d(where(jj eq 1),0,1)) gt 0.05) then begin
print,'Mg/Ca: lons not matching ',lats_j1(i),lats_d(where(jj eq 1),0,1)
stop
endif
if (abs(lons_j1(i)-lons_d(where(jj eq 1),0,1)) gt 0.05) then begin
print,'Mg/Ca: lons not matching ',lons_j1(i),lons_d(where(jj eq 1),0,1)
stop
endif
print,names_d(where(jj eq 1)),temps_j1(i),temps_d(where(jj eq 1),0,1),lats_j1(i),lats_d(where(jj eq 1),0,1),lons_j1(i),lons_d(where(jj eq 1),0,1)
endfor
print,'end matching mg/ca'

; now uk37
n_j2=23
row_temp=strarr(1)
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/pl_data/PlioVar_uk_new_unix.csv'
print,'STARTING READ Jess'
print,'uk37'

names_j2=strarr(n_j2)
lats_j2=fltarr(n_j2)
lons_j2=fltarr(n_j2)
temps_j2=fltarr(n_j2)
err_j2=fltarr(n_j2)

readf,2,row_temp
;print,'header: '+row_temp
for i=0,n_j2-1 do begin
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
;print,data_row
names_j2(i)=data_row(0)
print,names_j2(i)
lats_j2(i)=data_row(1)
lons_j2(i)=data_row(2)
temps_j2(i)=data_row(9)
err_j2(i)=data_row(10)
endfor
close,2

print,'matching uk37:'
for i=0,n_j2-1 do begin
print,names_j2(i)
jj=strmatch(names_d,names_j2(i),/FOLD_CASE)
;print,jj
;print,where(jj eq 1)
if (total(jj) ne 1) then begin
print,'uk37: too many or no names matching: ',total(where(jj eq 1))
stop
endif
if (abs(lats_j2(i)-lats_d(where(jj eq 1),0,1)) gt 0.05) then begin
print,'uk37: lons not matching ',lats_j2(i),lats_d(where(jj eq 1),0,1)
stop
endif
if (abs(lons_j2(i)-lons_d(where(jj eq 1),0,1)) gt 0.05) then begin
print,'uk37: lons not matching ',lons_j2(i),lons_d(where(jj eq 1),0,1)
stop
endif
print,names_d(where(jj eq 1)),temps_j2(i),temps_d(where(jj eq 1),0,1),lats_j2(i),lats_d(where(jj eq 1),0,1),lons_j2(i),lons_d(where(jj eq 1),0,1)
endfor
print,'end matching uk37'

; now reverse-match

names_j=[names_j1,names_j2]
lats_j=[lats_j1,lats_j2]
lons_j=[lons_j1,lons_j2]
temps_j=[temps_j1,temps_j2]
err_j=[err_j1,err_j2]

print,'reverse-matching'

for d=0,ndata(0,1)-1 do begin
print,names_d(d)
jj=strmatch(names_j,names_d(d),/FOLD_CASE)
print,jj
if (total(jj) ne 1 and total(jj) ne 2) then begin
print,'incorrect number of sites in matching'
stop
endif
print,names_j(where(jj eq 1))

if (total(jj) eq 1) then begin
print,temps_j(where(jj eq 1))
print,temps_d(d,0,1)
errs_d(0,d,0,1)=err_j(where(jj eq 1))
errs_d(1,d,0,1)=errs_d(0,d,0,1)
if (lats_j(where(jj eq 1))-lats_d(d,0,1) gt 0.05) then begin
print,'lats dont match'
stop
endif
if (temps_j(where(jj eq 1))-temps_d(d,0,1) gt 0.3) then begin
print,'temps dont match',names_d(d),temps_j(where(jj eq 1)),temps_d(d,0,1)
stop
endif

endif

if (total(jj) eq 2) then begin
print,temps_j(where(jj eq 1))
print,mean(temps_j(where(jj eq 1)))
print,temps_d(d,0,1)
ee=err_j(where(jj eq 1))
ee1=ee*ee
ee2=total(ee1)
ee3=sqrt(ee2)
errs_d(0,d,0,1)=ee3/2.0
errs_d(1,d,0,1)=errs_d(0,d,0,1)
if (mean(lats_j(where(jj eq 1)))-lats_d(d,0,1) gt 0.05) then begin
print,'lats dont match',lats_j(where(jj eq 1)),lats_d(d,0,1)
stop
endif
if (mean(temps_j(where(jj eq 1)))-temps_d(d,0,1) gt 0.3) then begin
print,'temps dont match',temps_j(where(jj eq 1)),temps_d(d,0,1)
print,names_d(d),mean(temps_j(where(jj eq 1))),temps_d(d,0,1)
if (names_d(d) ne 'DSDP609') then begin
stop
endif
endif

endif


endfor


for d=0,ndata(0,1)-1 do begin
print,names_d(d),temps_d(d,0,1),errs_d(0,d,0,1),errs_d(1,d,0,1)
endfor

endif


if (pl_data_sat eq 'salzmann') then begin

; PLIOCENE:
row_temp=''
row_head=strarr(3)
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/pl_data/ShortData_for_IPCC_NatClim_djl_Tab.txt'
readf,2,row_head
;print,row_head

xx=0
for i=0,9 do begin
;print,'We are i: ',i
readf,2,row_temp
data_row=strsplit(row_temp,string(9B),/extract,/preserve_null)
;print,data_row
;print,size(data_row)

if (data_row(7) ne 'n/a') then begin

lons_d(xx,0,0)=data_row(3)
lats_d(xx,0,0)=data_row(2)
temps_d(xx,0,0)=data_row(7)
if (data_row(8) ne 'n/a') then begin
errs_d(0,xx,0,0)=data_row(8)
errs_d(1,xx,0,0)=data_row(9)
endif else begin
errs_d(0,xx,0,0)=missing_err
errs_d(1,xx,0,0)=missing_err
endelse


xx=xx+1

;print,'We are xx: ',xx

endif

endfor
close,2

if (xx ne ndata(0,0)) then begin
print,'unexpected N',xx,ndata(0,0)
stop
endif

; now find the preind temperatures at these sites.

filenamecru='/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/pl_data/cru_ts4.04.1901.1930.tmp.dat_annmean.nc'
varname='tmp'
print,filenamecru
id1=ncdf_open(filenamecru)
ncdf_varget,id1,varname,dummy_cru
ncdf_varget,id1,'longitude',lons_cru
ncdf_varget,id1,'latitude',lats_cru

scale_factor=1.0
add_offset=0.0
missing_value=-9999.99
aa=ncdf_varinq(id1,varname)
natts=aa.Natts
for x=0,natts-1 do begin
bb=ncdf_attname(id1,varname,x)
;print,bb
if (bb eq 'scale_factor') then begin
ncdf_attget,id1,varname,'scale_factor',scale_factor
endif
if (bb eq 'add_offset') then begin
ncdf_attget,id1,varname,'add_offset',add_offset
endif
if (bb eq 'missing_value') then begin
ncdf_attget,id1,varname,'missing_value',missing_value
;print,'mising is:',missing_value
endif
if (bb eq '_FillValue') then begin
ncdf_attget,id1,varname,'_FillValue',missing_value1
;print,'mising1 is:',missing_value1
endif
endfor

ncdf_close,id1

cru_tmp=dummy_cru*scale_factor+add_offset

i = WHERE(dummy_cru EQ missing_value, count)
IF (count GT 0) THEN cru_tmp[i] = !VALUES.F_NAN
i = WHERE(dummy_cru EQ missing_value1, count)
IF (count GT 0) THEN cru_tmp[i] = !VALUES.F_NAN

; Now locate nearest temperature for data points


for d=0,ndata(0,0)-1 do begin
find_lonlat,nx,ny,lons_cru,lats_cru,lons_d(d,0,0),lats_d(d,0,0),cru_tmp,xindex,yindex

;print,'adjusting for preind: ',d
;print,temps_d(d,0,0)
;print,lons_d(d,0,0),lats_d(d,0,0)
;print,lons_cru(xindex),lats_cru(yindex)
;print,cru_tmp(xindex,yindex)

temps_d(d,0,0)=temps_d(d,0,0)-cru_tmp(xindex,yindex)

;print,temps_d(d,0,0)


endfor


endif ; end Salzmann

;;;;;



;;;;;
; LGM:

if (lg_data_sst eq 'tierney-2019-grid') then begin

nxd=72
nyd=36
filenamex='/home/bridge/ggdjl/ipcc_ar6/patterns/sod/lg_data/LGM_5x5_deltaSST.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,'deltaSST',dummy_sst
ncdf_varget,id1,'std',dummy_std
ncdf_varget,id1,'lon',dummy_lons
ncdf_varget,id1,'lat',dummy_lats
ncdf_close,id1

my_count=0
for x=0,nxd-1 do begin
for y=0,nyd-1 do begin
if (finite(dummy_sst(x,y))) then begin

lons_d(my_count,1,1)=dummy_lons(x)
lats_d(my_count,1,1)=dummy_lats(y)
temps_d(my_count,1,1)=fact_mod_sign(1)*dummy_sst(x,y)
errs_d(0,my_count,1,1)=dummy_std(x,y)
errs_d(1,my_count,1,1)=dummy_std(x,y)

my_count=my_count+1

endif
endfor
endfor

if (my_count ne ndata(1,1)) then begin
print,'unexpected number of LGM sst points...'
print,my_count,ndata(1,1)
stop
endif

endif ; end tierney-2019-grid


if (lg_data_sst eq 'tierney-2020-grid') then begin

nxd=72
nyd=36
filenamex='/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/lg_data/Tierney2020_ProxyData_5x5_deltaSST.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,'deltaSST',dummy_sst
ncdf_varget,id1,'std',dummy_std
ncdf_varget,id1,'lon',dummy_lons
ncdf_varget,id1,'lat',dummy_lats
ncdf_close,id1

my_count=0
for x=0,nxd-1 do begin
for y=0,nyd-1 do begin
if (finite(dummy_sst(x,y))) then begin
lons_d(my_count,1,1)=dummy_lons(x)
lats_d(my_count,1,1)=dummy_lats(y)
temps_d(my_count,1,1)=fact_mod_sign(1)*dummy_sst(x,y)
errs_d(0,my_count,1,1)=dummy_std(x,y)
errs_d(1,my_count,1,1)=dummy_std(x,y)

my_count=my_count+1

endif
endfor
endfor

if (my_count ne ndata(1,1)) then begin
print,'unexpected number of LGM sst points...'
print,my_count,ndata(1,1)
stop
endif

endif ; end tierney-2020-grid


if (lg_data_sst eq 'tierney-2020') then begin

row_temp=''
row_head=strarr(1)
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/lg_data/Tierney2020_ProxyDataPaired.csv'
readf,2,row_head
;print,row_head

xx=0
for i=0,511 do begin
;print,'We are i: ',i
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
;print,data_row
;print,size(data_row)

if (data_row(3) ne '') then begin

lons_d(xx,1,1)=data_row(1)
lats_d(xx,1,1)=data_row(0)

temps_d(xx,1,1)=fact_mod_sign(1)*data_row(3)
errs_d(0,xx,1,1)=1.0*data_row(3)-1.0*data_row(2)
errs_d(1,xx,1,1)=1.0*data_row(4)-1.0*data_row(3)

xx=xx+1

;print,'We are xx: ',xx

endif

endfor
close,2

if (xx ne ndata(1,1)) then begin
print,'unexpected N',xx,ndata(1,1)
stop
endif

endif ; end tierney-2020





if (lg_data_sat eq 'bartlein') then begin

nxd=180
nyd=90
filenamex='/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/lg_data/bartlein_mat_delta_21ka_ALL_grid_2x2.nc'
varname='mat_anm_mean'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname,dummy_sat
ncdf_varget,id1,'mat_se_mean',dummy_std
ncdf_varget,id1,'lon',dummy_lons
ncdf_varget,id1,'lat',dummy_lats

aa=ncdf_varinq(id1,varname)
natts=aa.Natts
for x=0,natts-1 do begin
bb=ncdf_attname(id1,varname,x)
if (bb eq '_FillValue') then begin
ncdf_attget,id1,varname,'_FillValue',missing_value
endif
endfor

ncdf_close,id1

i = WHERE(dummy_sat EQ missing_value, count)
IF (count GT 0) THEN dummy_sat[i] = !VALUES.F_NAN


my_count=0
for x=0,nxd-1 do begin
for y=0,nyd-1 do begin
if (finite(dummy_sat(x,y))) then begin
;print,x,y,my_count,dummy_sat(x,y)
lons_d(my_count,1,0)=dummy_lons(x)
lats_d(my_count,1,0)=dummy_lats(y)
temps_d(my_count,1,0)=fact_mod_sign(1)*dummy_sat(x,y)
errs_d(0,my_count,1,0)=dummy_std(x,y)
errs_d(1,my_count,1,0)=dummy_std(x,y)

my_count=my_count+1

endif
endfor
endfor

if (my_count ne ndata(1,0)) then begin
print,'unexpected number of LGM sat points...'
print,my_count,ndata(1,0)
stop
endif


if (lg_data_sat_add eq 'cleator') then begin

print,'lon:'
print,dummy_lons
print,'lat:'
print,dummy_lats

temps_d_cleat=fltarr(ndata(1,0))
errs_d_cleat=fltarr(ndata(1,0))

row_head=strarr(22)
row_temp=''
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/lg_data/cleator_LGM_reconstruction.csv'
print,'STARTING READ CLEATOR'
nrows_d=2566

cleat_lons=fltarr(nrows_d)
cleat_lats=fltarr(nrows_d)
cleat_temps=fltarr(nrows_d)
cleat_sd=fltarr(nrows_d)

readf,2,row_head
for i=0,nrows_d-1 do begin
print,i
readf,2,row_temp
print,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
if (data_row(4) ne '  nan') then begin
cleat_lons(i)=data_row(1)
cleat_lats(i)=data_row(0)
cleat_temps(i)=fact_mod_sign(1)*data_row(4)
cleat_sd(i)=data_row(10)
endif else begin
cleat_lons(i)=-1e30
cleat_lats(i)=-1e30
cleat_temps(i)=-1e30
cleat_sd(i)=-1e30
endelse
endfor
close,2

distc=fltarr(nrows_d)

for d=0,ndata(1,0)-1 do begin

disty=abs(cleat_lats-lats_d(d,1,0))
distx1=abs(cleat_lons-lons_d(d,1,0))
distx2=abs(cleat_lons-lons_d(d,1,0)-360)
distx3=abs(cleat_lons-lons_d(d,1,0)+360)

for i=0,nrows_d-1 do begin
distc(i)=3*disty(i)+min([distx1(i),distx2(i),distx3(i)])
endfor

mindist=min(distc)
iindex=!c

print,lons_d(d,1,0),lats_d(d,1,0),cleat_lons(iindex),cleat_lats(iindex),mindist

if (mindist gt 6) then begin

temps_d_cleat(d)=temps_d(d,1,0)
errs_d_cleat(d)=errs_d(0,d,1,0)

endif else begin

temps_d_cleat(d)=cleat_temps(iindex)
errs_d_cleat(d)=cleat_sd(iindex)

endelse

endfor


loadct,0
set_plot,'ps'
!P.FONT=0

my_filename='bart_cleat_tas'
print,my_filename
device,filename=my_filename+'.ps',/encapsulate,set_font='Helvetica'
plot,temps_d(0:ndata(1,0)-1,1,0),temps_d_cleat,xrange=[-20,20],yrange=[-20,20],color=0,ytitle='Cleator',xtitle='Bartlein',psym=1
device,/close
spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum

my_filename='bart_cleat_std'
print,my_filename
device,filename=my_filename+'.ps',/encapsulate,set_font='Helvetica'
plot,errs_d(0,0:ndata(1,0)-1,1,0),errs_d_cleat,xrange=[-1,8],yrange=[-1,8],color=0,ytitle='Cleator',xtitle='Bartlein',psym=1
device,/close
spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum


temps_d(0:ndata(1,0)-1,1,0)=temps_d_cleat(0:ndata(1,0)-1)
errs_d(0,0:ndata(1,0)-1,1,0)=errs_d_cleat(0:ndata(1,0)-1)
errs_d(1,0:ndata(1,0)-1,1,0)=errs_d_cleat(0:ndata(1,0)-1)


endif ; end cleator

endif ; end bartlein

;;;;;



;;;;;





endif ; end read_proxy



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; calculate model temps at sites of proxies
for t=0,ntime-1 do begin
for v=0,nvar-1 do begin
for dd=0,ndata(t,v)-1 do begin

find_lonlat,nx,ny,lons,lats,lons_d(dd,t,v),lats_d(dd,t,v),ensmean_map(*,*,t,v),xindex,yindex
temps_m_mean(dd,t,v)=ensmean_map(xindex,yindex,t,v)
lons_m_mean(dd,t,v)=lons(xindex)
lats_m_mean(dd,t,v)=lats(yindex)

find_lonlat,nx,ny,lons,lats,lons_d(dd,t,v),lats_d(dd,t,v),ensaver_map(*,*,t,v),xindex,yindex
temps_m_aver(dd,t,v)=ensaver_map(xindex,yindex,t,v)
lons_m_aver(dd,t,v)=lons(xindex)
lats_m_aver(dd,t,v)=lats(yindex)

print,'CHECK:    **'
print
print,lons_d(dd,t,v),lats_d(dd,t,v)
print,lons_m_mean(dd,t,v),lats_m_mean(dd,t,v)
print,lons_m_aver(dd,t,v),lats_m_aver(dd,t,v)


endfor
endfor
endfor

print,'CHECK ON LATS/LONS'
for t=0,ntime-1 do begin
for v=0,nvar-1 do begin
print,timnameslong(t),varnametitle(v)
for dd=0,ndata(t,v)-1 do begin
my_lons=lons_d(dd,t,v)
if (my_lons lt 0) then my_lons=my_lons+360
thresh=5.0
flag_lon=''
flag_lat=''
if ( abs(my_lons-lons_m_mean(dd,t,v) gt thresh)  or abs(my_lons-lons_m_aver(dd,t,v) gt thresh) ) then flag_lon='   XXX'
if ( abs(lats_d(dd,t,v)-lats_m_mean(dd,t,v) gt thresh)  or abs(lats_d(dd,t,v)-lats_m_aver(dd,t,v) gt thresh) ) then flag_lat='   XXX'

;print,dd,'lons',my_lons,lons_m_mean(dd,t,v),lons_m_aver(dd,t,v),flag_lon
;print,dd,'lats',lats_d(dd,t,v),lats_m_mean(dd,t,v),lats_m_aver(dd,t,v),flag_lat

endfor
endfor
endfor



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Calculate some metrics....

;bandlim(nbands,0)= start points
;bandlim(nbands,1)= end points

bandtype='3-bnd'

if (bandtype eq '10eq') then begin
nbands=18
bandlim=fltarr(nbands,2)
bandlim(*,0)=findgen(nbands)*10.0-90.0
bandlim(*,1)=findgen(nbands)*10.0-90.0+10
endif
if (bandtype eq '20eq') then begin
nbands=9
bandlim=fltarr(nbands,2)
bandlim(*,0)=findgen(nbands)*20.0-90.0
bandlim(*,1)=findgen(nbands)*20.0-90.0+20
endif
if (bandtype eq '30eq') then begin
nbands=6
bandlim=fltarr(nbands,2)
bandlim(*,0)=findgen(nbands)*30.0-90.0
bandlim(*,1)=findgen(nbands)*30.0-90.0+30
endif
if (bandtype eq '3-bnd') then begin
nbands=3
bandlim=fltarr(nbands,2)
bandlim(*,0)=[-90,-30,30]
bandlim(*,1)=[-30,30,90]
band_label=strarr(nbands)
band_label=['-90 to -30','EQ','30 to 90']
endif
if (bandtype eq '5-bnd') then begin
nbands=5
bandlim=fltarr(nbands,2)
bandlim(*,0)=[-90,-60,-30,30,60]
bandlim(*,1)=[-60,-30,30,60,90]
endif



band_data=fltarr(nbands,ntime,nvar)
band_data(*,*,*)=!Values.F_NAN
band_model_mean=fltarr(nbands,ntime,nvar)
band_model_mean(*,*,*)=!Values.F_NAN
band_model_aver=fltarr(nbands,ntime,nvar)
band_model_aver(*,*,*)=!Values.F_NAN


for t=0,ntime-1 do begin
for v=0,nvar-1 do begin

for b=0,nbands-1 do begin

ii = where(lats_d(0:ndata(t,v)-1,t,v) gt bandlim(b,0) and lats_d(0:ndata(t,v)-1,t,v) le bandlim(b,1),count)

if (count ge nlim_count) then begin
band_data(b,t,v)=mean(temps_d(ii,t,v))
band_model_mean(b,t,v)=mean(temps_m_mean(ii,t,v))
band_model_aver(b,t,v)=mean(temps_m_aver(ii,t,v))
endif



print,timnameslong(t),varnametitle(v),'Band = ',b
print,'Data: ',band_data(b,t,v)
print,temps_d(ii,t,v)
print,'Models Mean: ',band_model_mean(b,t,v)
print,'Models Aver: ',band_model_aver(b,t,v)

endfor

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

if (make_zon_plots eq 1) then begin

; make zonal mean plot

; nstarty is where the labels start; nscaley is how many sapces there
;   are for names in the whole plot

dxxx=0.06 ; distance between lines in main legend
nstarty1=0.93
nstarty2=nstarty1-1.0*dxxx
nstarty=nstarty1-2.0*dxxx
nstarty3=nstarty1-3.0*dxxx
nstarty4=nstarty1-4.0*dxxx
nscaley=60.0 ; distance between lines in indiviudal model legend - big number = less gap
my_thick1=0.1
my_thick2=6 ; merid: thickness of ensemble mean
my_thick3=8 ; merid: thickness of band mean
my_charsize=0.8
my_charsize1=1.3 ; charsize for main legend
my_charsize2=1.3 ; charsize for amplification
my_errslen=0.5
my_proxampy=0.05
my_modampy=0.1
my_shampx=-85
my_nhampx=85

for t=0,ntime-1 do begin
for v=0,nvar-1 do begin

; filename
my_filename=timnames(t)+'_temp_lat_corr_tuned_data_ipcc_'+varnameshort(v)+name_sign(t)
print,my_filename
device,filename=my_filename+'.ps',/encapsulate,/color,set_font='Helvetica'

if (fact_mod_sign(t) eq 1) then begin
thistitle=varnametitle(v)+' ('+timnameslong(t)+' - preindustrial)'
endif
if (fact_mod_sign(t) eq -1) then begin
thistitle=varnametitle(v)+' (preindustrial - '+timnameslong(t)+')'
endif

tvlct,r_39,g_39,b_39

; axes etc:
plot,lats(*),ensmean_zon(*,t,0),color=0,psym=8,yrange=my_yrange5(t,v,*),xrange=[-90,90],ystyle=1,xstyle=1,title=thistitle,xtitle='latitude',ytitle='temperature anomaly [!Eo!NC]',/nodata,xcharsize=1,ycharsize=1,charsize=1.25,xticks=6,xtickname=['90S','60S','30S','EQ','30N','60N','90N']


tvlct,r_0,g_0,b_0
my_proxycol=180

; plot proxies
for dd=0,ndata(t,v)-1 do begin
plots,lats_d(dd,t,v),temps_d(dd,t,v),color=my_proxycol,psym=8,symsize=0.8,NOCLIP = 0
endfor
for dd=0,ndata(t,v)-1 do begin
oplot,[lats_d(dd,t,v),lats_d(dd,t,v)],[temps_d(dd,t,v)-errs_d(0,dd,t,v),temps_d(dd,t,v)+errs_d(1,dd,t,v)],color=my_proxycol
oplot,[lats_d(dd,t,v)-my_errslen,lats_d(dd,t,v)+my_errslen],[temps_d(dd,t,v)+errs_d(1,dd,t,v),temps_d(dd,t,v)+errs_d(1,dd,t,v)],color=my_proxycol
oplot,[lats_d(dd,t,v)-my_errslen,lats_d(dd,t,v)+my_errslen],[temps_d(dd,t,v)-errs_d(0,dd,t,v),temps_d(dd,t,v)-errs_d(0,dd,t,v)],color=my_proxycol
endfor

tvlct,r_39,g_39,b_39

; spectrum.cat 8 lines
tvlct,127,68,170,1
tvlct,48,79,191,2
tvlct,54,156,232,3
tvlct,36,147,126,4
tvlct,236,209,81,5
tvlct,237,128,55,6
tvlct,204,64,74,7

tvlct,250,0,0,250 ; red
tvlct,250,0,0,251 ; red
tvlct,250,180,180,252 ; light-red
tvlct,0,250,0,253 ; green
tvlct,0,0,250,254 ; blue

indmodcol=252
ensmeancol=251
;indmodcol=6
;ensmeancol=7


; plot zero line
oplot,[-90,90],[0,0],thick=0.2,color=0



; plot the model lines and legend
dxx=(my_yrange5[t,v,1]-my_yrange5[t,v,0])/nscaley
xx=0
for m=0,nmod(t)-1 do begin

if (total([t,m,v] ne problem_missing) ne 0) then begin

if (do_mod_leg eq 0) then begin 
; model lines:
if (plot_zon(t,m) eq 1) then begin
oplot,lats(*),mod_zon(*,m,t,v),color=indmodcol,thick=my_thick1,linestyle=linestyle_mod
endif
; legend:
if (xx eq 0) then begin 
oplot,legendline,[my_yrange5(t,v,1)*nstarty1-dxx*xx,my_yrange5(t,v,1)*nstarty1-dxx*xx],color=indmodcol,thick=my_thick1,linestyle=linestyle_mod
xyouts,legendtext,my_yrange5(t,v,1)*nstarty1-dxx*xx,mipnames(t)+' models zonal mean (N='+strtrim(fix(total(plot_zon(t,0:nmod(t)-1) eq 1)),2)+')',color=indmodcol,charsize=my_charsize1
endif
endif

if (do_mod_leg eq 1) then begin
if (plot_zon(t,m) eq 1) then begin 
; model lines:
oplot,lats(*),mod_zon(*,m,t,v),color=modcol(t,m),thick=my_thick1
; legend:
oplot,legendline,[my_yrange5(t,v,1)*nstarty-dxx*xx,my_yrange5(t,v,1)*nstarty-dxx*xx],color=modcol(t,m),thick=my_thick1
xyouts,legendtext,my_yrange5(t,v,1)*nstarty-dxx*xx,modnames(t,m),color=modcol(t,m),charsize=my_charsize
endif
endif

xx=xx+1
endif
endfor

; plot the ensemble mean and legend 
; legend:
if (do_mod_leg eq 1) then begin 
oplot,legendline,[my_yrange5(t,v,1)*nstarty1,my_yrange5(t,v,1)*nstarty1],color=0,thick=my_thick2,linestyle=linestyle_mod
xyouts,legendtext,my_yrange5(t,v,1)*nstarty1,'Model ensemble mean '+varnametitle(v),color=0,charsize=my_charsize1
if (do_opp eq 1) then begin
oplot,legendline,[my_yrange5(t,v,1)*nstarty2,my_yrange5(t,v,1)*nstarty2],color=0,thick=my_thick2,linestyle=linestyle_mod
xyouts,legendtext,my_yrange5(t,v,1)*nstarty2,'Model ensemble mean '+varnametitle(1-v),color=0,charsize=my_charsize1
endif
endif

; legend ensemble mean:
if (do_mod_leg eq 0) then begin 
oplot,legendline,[my_yrange5(t,v,1)*nstarty2,my_yrange5(t,v,1)*nstarty2],color=ensmeancol,thick=my_thick2,linestyle=linestyle_mod
xyouts,legendtext,my_yrange5(t,v,1)*nstarty2,mipnames(t)+' ensemble zonal mean',color=ensmeancol,charsize=my_charsize1
oplot,legendline,[my_yrange5(t,v,1)*nstarty,my_yrange5(t,v,1)*nstarty],color=ensmeancol,thick=my_thick2,linestyle=linestyle_band
xyouts,legendtext,my_yrange5(t,v,1)*nstarty,mipnames(t)+' ensemble site mean',color=ensmeancol,charsize=my_charsize1
endif

; plot model ensemble mean:
oplot,lats(*),ensaver_zon(*,t,v),color=ensmeancol,thick=my_thick2,linestyle=linestyle_mod
if (do_opp eq 1) then begin
oplot,lats(*),ensaver_zon(*,t,1-v),color=0,thick=my_thick2,linestyle=linestyle_mod
endif
if (do_checks eq 1) then begin
oplot,lats(*),ensaver_zon_check1(*,t,v),color=0,thick=my_thick2,linestyle=1
oplot,lats(*),ensaver_zon_check2(*,t,v),color=253,thick=my_thick2,linestyle=2
oplot,lats(*),ensmean_zon_check1(*,t,v),color=254,thick=my_thick2,linestyle=3
endif


; plot model band
for b=0,nbands-1 do begin

if (finite(band_model_mean(b,t,v))) then begin
plots,[bandlim(b,0),bandlim(b,1)],[band_model_mean(b,t,v),band_model_mean(b,t,v)],thick=my_thick3,color=ensmeancol,NOCLIP = 0,linestyle=linestyle_band
endif

if (do_checks eq 1) then begin
if (finite(band_model_aver(b,t,v))) then begin
plots,[bandlim(b,0),bandlim(b,1)],[band_model_aver(b,t,v),band_model_aver(b,t,v)],thick=my_thick3,color=252,NOCLIP = 0,linestyle=linestyle_band
endif
endif

endfor

if (bandtype eq '3-bnd') then begin
if (finite(band_model_mean(0,t,v)) and finite(band_model_mean(1,t,v))) then begin
xyouts,my_shampx,my_yrange5(t,v,0)+my_proxampy*(my_yrange5(t,v,1)-my_yrange5(t,v,0)),'SH proxy amp: '+strtrim(string(band_data(0,t,v)-band_data(1,t,v),format='(F4.1)'),2)+' !Eo!NC',color=0,charsize=my_charsize2
xyouts,my_shampx,my_yrange5(t,v,0)+my_modampy*(my_yrange5(t,v,1)-my_yrange5(t,v,0)),'SH model amp: '+strtrim(string(band_model_aver(0,t,v)-band_model_aver(1,t,v),format='(F4.1)'),2)+' !Eo!NC',color=ensmeancol,charsize=my_charsize2
endif
if (finite(band_model_mean(2,t,v)) and finite(band_model_mean(1,t,v))) then begin
xyouts,my_nhampx,my_yrange5(t,v,0)+my_proxampy*(my_yrange5(t,v,1)-my_yrange5(t,v,0)),'NH proxy amp: '+strtrim(string(band_data(2,t,v)-band_data(1,t,v),format='(F4.1)'),2)+' !Eo!NC',alignment=1,color=0,charsize=my_charsize2
xyouts,my_nhampx,my_yrange5(t,v,0)+my_modampy*(my_yrange5(t,v,1)-my_yrange5(t,v,0)),'NH model amp: '+strtrim(string(band_model_aver(2,t,v)-band_model_aver(1,t,v),format='(F4.1)'),2)+' !Eo!NC',alignment=1,color=ensmeancol,charsize=my_charsize2
endif
endif

; DATA:

tvlct,r_0,g_0,b_0
my_proxycol=180

if (do_mod_leg eq 0) then begin
; plot proxy legend
xyouts,legendtext,my_yrange5(t,v,1)*nstarty3,timnameslong(t)+' proxy sites (N='+strtrim(fix(ndata(t,v)),2)+')',color=my_proxycol,charsize=my_charsize1
plots,mean(legendline),my_yrange5(t,v,1)*nstarty3,color=my_proxycol,psym=8,symsize=0.8,NOCLIP = 0
oplot,[mean(legendline),mean(legendline)],[my_yrange5(t,v,1)*(nstarty3+0.03),my_yrange5(t,v,1)*(nstarty3-0.03)],color=my_proxycol
oplot,[mean(legendline)-my_errslen,mean(legendline)+my_errslen],[my_yrange5(t,v,1)*(nstarty3+0.03),my_yrange5(t,v,1)*(nstarty3+0.03)],color=my_proxycol
oplot,[mean(legendline)-my_errslen,mean(legendline)+my_errslen],[my_yrange5(t,v,1)*(nstarty3-0.03),my_yrange5(t,v,1)*(nstarty3-0.03)],color=my_proxycol
oplot,legendline,[my_yrange5(t,v,1)*nstarty4,my_yrange5(t,v,1)*nstarty4],color=0,thick=my_thick3,linestyle=linestyle_band
xyouts,legendtext,my_yrange5(t,v,1)*nstarty4,timnameslong(t)+' proxy sites mean',color=0,charsize=my_charsize1
endif

; plot proxy band
for b=0,nbands-1 do begin
if (finite(band_data(b,t,v))) then begin
plots,[bandlim(b,0),bandlim(b,1)],[band_data(b,t,v),band_data(b,t,v)],thick=my_thick3,color=0,NOCLIP = 0,linestyle=linestyle_band
endif



endfor

device,/close
spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum

endfor
endfor

endif ; end make_zon_plots


if (make_map_plots) then begin

; make map plot


if (make_nodata eq 1) then begin
np=2
pname=strarr(np)
pname(*)=['data','nodata']
endif else begin
np=1
pname=strarr(np)
pname(*)=['data']
endelse



for p=0,np-1 do begin
for t=0,ntime-1 do begin
for v=0,nvar-1 do begin

if (make_map_mod_plots eq 1) then begin
nmap=nmod(t)+2
mapname=strarr(nmap)
mapnamelong=strarr(nmap)
mapname(0:nmod(t)-1)=modnames(t,0:nmod(t)-1)
mapnamelong(0:nmod(t)-1)=modnames(t,0:nmod(t)-1)
mapname(0:nmod(t)+1)=[mapname(0:nmod(t)-1),'ensmean','mapmean']
mapnamelong(0:nmod(t)+1)=[mapname(0:nmod(t)-1),'','mapmean']
endif else begin
nmap=1
mapname=['ensmean']
mapnamelong=['']
endelse

for map=0,nmap-1 do begin

my_tcharsize=190

if (make_map_mod_plots eq 1) then begin

if (map le nmod(t)-1) then begin
my_tcharsize=100
my_arr=mod_map(*,*,map,t,v)
endif
if (map eq nmod(t)) then begin
my_arr=ensmean_map(*,*,t,v)
;my_arr=ensaver_map(*,*,t,v)
endif
if (map eq nmod(t)+1) then begin
my_arr=modmean_map(*,*,t,v)
;my_arr=modaver_map(*,*,t,v)
endif

endif else begin

my_arr=ensmean_map(*,*,t,v)
;my_arr=ensaver_map(*,*,t,v)

endelse

map_charsize=230

; filename
my_filename=timnames(t)+'_modeldata_cont_'+varnameshort(v)+'_ipcc_czt_'+pname(p)+'_'+mapname(map)+name_sign(t)+name_all
print,my_filename
psopen,file=my_filename+'.ps',tcharsize=my_tcharsize,charsize=map_charsize
nncols=2.0+(temp_max_e(t,v)-temp_min_e(t,v))/nnstep(t,v)
if (nncols ne my_ncols) then begin
print,'wrong number of colours specified',nncols,my_ncols
stop
endif
CS, SCALE=22,ncols=nncols

if (my_ncols eq 21) then begin
; from the IPCC plot guide, this is Temperature, divergent,
; temp_dv_desc.txt; temp_div_21
tvlct,5,48,97,2
tvlct,20,72,121,3
tvlct,36,97,146,4
tvlct,51,122,170,5
tvlct,67,147,195,6
tvlct,97,163,203,7
tvlct,127,181,212,8
tvlct,158,198,222,9
tvlct,188,214,230,10
tvlct,218,232,240,11
tvlct,248,248,248,12
tvlct,243,223,220,13
tvlct,237,197,191,14
tvlct,231,172,163,15
tvlct,225,146,134,16
tvlct,219,121,105,17
tvlct,214,96,76,18
tvlct,186,72,65,19
tvlct,158,48,54,20
tvlct,130,24,42,21
tvlct,103,0,31,22
endif

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

if (fact_mod_sign(t) eq 1) then begin
thistitle=strtrim(varnametitle(v)+' ('+timnameslong(t)+' - preindustrial) '+mapnamelong(map),2)
endif
if (fact_mod_sign(t) eq -1) then begin
thistitle=strtrim(varnametitle(v)+' (preindustrial - '+timnameslong(t)+') '+mapnamelong(map),2)
endif

if (all_proxies eq 1) then begin
thistitle=thistitle+': '+string(ensmean_mean(t,v),format='(F4.1)')+' !Eo!NC'
endif

CON, F=my_arr,x=lons(*),y=lats(*),TITLE=thistitle, CB_TITLE='temperature anomaly [!Eo!NC]',/nomap,/NOLINES,/block,CB_NTH=2
CON, F=my_arr,x=lons(*),y=lats(*),/nomap,/NOLINES,/nocolbar

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



; Land-sea mask
LEVS,MANUAL=['0','100000']
CON,F=topo_map(*,*,t),x=lons,y=lats,/nomap,/nocolbar,/NOFILL,/NOAXES,TITLE='',/NOLINELABELS

if (p eq 0) then begin
; Data:
for d=0,ndata(t,v)-1 do begin
my_dat=temps_d(d,t,v)
colind=fix((my_dat-temp_min_e(t,v))/nnstep(t,v))+3
colind=max([colind,2])
colind=min([colind,nncols+1])
USERSYM, COS(Aaa), SIN(Aaa), /FILL,color=colind
plots,lons_d(d,t,v),lats_d(d,t,v),psym=8,symsize=2
usersym,cos(aaa),sin(aaa),color=1
plots,lons_d(d,t,v),lats_d(d,t,v),psym=8,symsize=2.2,thick=8
usersym,cos(aaa),sin(aaa),color=0
plots,lons_d(d,t,v),lats_d(d,t,v),psym=8,symsize=2,thick=8
endfor

if (all_proxies eq 1) then begin
for d=0,ndata(t,1-v)-1 do begin
my_dat=temps_d(d,t,1-v)
colind=fix((my_dat-temp_min_e(t,1-v))/nnstep(t,1-v))+3
colind=max([colind,2])
colind=min([colind,nncols+1])
sss=1.0*sqrt(!pi/4.0)
USERSYM, [-1*sss,sss,sss,-1*sss,-1*sss], [sss,sss,-1*sss,-1*sss,sss], /FILL,color=colind
plots,lons_d(d,t,1-v),lats_d(d,t,1-v),psym=8,symsize=2
usersym,[-1*sss,sss,sss,-1*sss,-1*sss], [sss,sss,-1*sss,-1*sss,sss],color=1
plots,lons_d(d,t,1-v),lats_d(d,t,1-v),psym=8,symsize=2.2,thick=8
usersym,[-1*sss,sss,sss,-1*sss,-1*sss], [sss,sss,-1*sss,-1*sss,sss],color=0
plots,lons_d(d,t,1-v),lats_d(d,t,1-v),psym=8,symsize=2,thick=8
endfor
endif

endif


psclose,/noview
spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum
if (make_pdf eq 1) then begin
spawn,'ps2pdf -dEPSCrop -dAutoRotatePages=/None '+my_filename+'.eps '+my_filename+'.pdf',dum
endif


endfor ; end map
endfor ; end v
endfor ; end t
endfor ; end p




if (make_csv_map eq 1) then begin

ipcc_max=10000
ipcc_p=strarr(ipcc_max) ; period
ipcc_s=strarr(ipcc_max) ; SAT or SST
ipcc_lo=fltarr(ipcc_max) ; low error bar
ipcc_me=fltarr(ipcc_max) ; mean temp
ipcc_up=fltarr(ipcc_max) ; up error bar
ipcc_lon=fltarr(ipcc_max)
ipcc_lat=fltarr(ipcc_max)
ipcc_mm=fltarr(ipcc_max) ; model mean
ipcc_ma=fltarr(ipcc_max) ; model aver

x=0

for t=0,ntime-1 do begin
for v=0,nvar-1 do begin
for d=0,ndata(t,v)-1 do begin

ipcc_p(x)=timnameslong(t)
ipcc_s(x)=varnametitle(v)
ipcc_lo(x)=errs_d(0,d,t,v)
ipcc_me(x)=temps_d(d,t,v)
ipcc_up(x)=errs_d(1,d,t,v)
ipcc_lon(x)=lons_d(d,t,v)
ipcc_lat(x)=lats_d(d,t,v)
ipcc_mm(x)=temps_m_mean(d,t,v)
ipcc_ma(x)=temps_m_aver(d,t,v)

x=x+1

endfor
endfor
endfor


ipcc_nx=x

ipcc_allheader=['This data file provides the observational data behind Figure 7.13','It was produced by Dan Lunt, using script plot_all_fgd.pro']
ipcc_colheader=['Time Period','SST or SAT','longitude [degrees]','latitude [degrees]','lower error bar [degreesC]','mean temperature [degreesC]','upper error bar [degreesC]']

write_csv,'Figure7_13_obs.csv',ipcc_p(0:ipcc_nx-1),ipcc_s(0:ipcc_nx-1),ipcc_lon(0:ipcc_nx-1),ipcc_lat(0:ipcc_nx-1),ipcc_lo(0:ipcc_nx-1),ipcc_me(0:ipcc_nx-1),ipcc_up(0:ipcc_nx-1),header=ipcc_colheader,table_header=ipcc_allheader

; for model sites:
ipcc_allheader=['This data file provides the observational data behind Figure 7.13','It was produced by Dan Lunt, using script plot_all_fgd.pro']
ipcc_colheader=['Time Period','SST or SAT','longitude [degrees]','latitude [degrees]','mean temperature [degreesC]','model mean','model aver']

write_csv,'Figure7_13_obs_mod.csv',ipcc_p(0:ipcc_nx-1),ipcc_s(0:ipcc_nx-1),ipcc_lon(0:ipcc_nx-1),ipcc_lat(0:ipcc_nx-1),ipcc_me(0:ipcc_nx-1),ipcc_mm(0:ipcc_nx-1),ipcc_ma(0:ipcc_nx-1),header=ipcc_colheader,table_header=ipcc_allheader

endif ; end make csv


endif ; end make map plots



if (make_gmt_plots eq 1) then begin

ntimeh=ntime+2

timnameslongh=strarr(ntimeh)
timnameslongh(0:2)=timnameslong(*)
timnameslongh(3:4)=['Historical','post 1975']

nmodh=intarr(ntimeh)
nmodh(0:2)=nmod(*)
nmodh(3:4)=42
nmodmaxh=max(nmodh)

modh_gmt=fltarr(nmodmaxh,ntimeh,nvar)
modh_gmt(0:nmodmax-1,0:2,0:1)=mod_gmt(*,*,*)

modh_gmt_flex=fltarr(nmodmaxh,ntimeh,nvar)
modh_gmt_flex(0:nmodmax-1,0:2,0:1)=mod_gmt(*,*,*)

modnamesh=strarr(ntimeh,nmodmaxh)
modnamesh(0:2,0:nmodmax-1)=modnames(*,*)
modnamesh(3,0:nmodh(3)-1)=['ACCESS-CM2','ACCESS-ESM1-5','AWI-CM-1-1-MR','BCC-CSM2-MR','BCC-ESM1','CAMS-CSM1-0','CAS-ESM2-0','CESM2','CESM2-FV2','CESM2-WACCM','CESM2-WACCM-FV2','CMCC-CM2-SR5','CNRM-CM6-1','CNRM-CM6-1-HR','CNRM-ESM2-1','CanESM5','E3SM-1-0','EC-Earth3-Veg','FGOALS-f3-L','FGOALS-g3','GISS-E2-1-G','GISS-E2-1-H','HadGEM3-GC31-LL','HadGEM3-GC31-MM','INM-CM4-8','INM-CM5-0','IPSL-CM6A-LR','KACE-1-0-G','MCM-UA-1-0','MIROC-ES2L','MIROC6','MPI-ESM-1-2-HAM','MPI-ESM1-2-HR','MPI-ESM1-2-LR','MRI-ESM2-0','NESM3','NorCPM1','NorESM2-LM','NorESM2-MM','SAM0-UNICON','TaiESM1','UKESM1-0-LL']
modnamesh(4,0:nmodh(4)-1)=modnamesh(3,0:nmodh(3)-1)


ecsh=fltarr(ntimeh,nmodmaxh)

existh=intarr(ntimeh,nmodmaxh)
existh(*,*)=1
existh(3,where(modnamesh(3,0:nmodh(3)-1) eq 'MIROC-ES2L'))=0
existh(4,*)=existh(3,*)

; First of all, read in Thorsten's deltas:

hname=strarr(ntimeh)
hname(*)=['x','x','x','longterm','post1975']

for h=3,4 do begin
for m=0,nmodh(h)-1 do begin
print,h,m
if (existh(h,m) eq 1) then begin
print,modnamesh(h,m)
filenamex='hi_mod/Historical_warming_vs_ECS/CMIP6_means/dtas_historical_'+hname(h)+'_'+modnamesh(h,m)+'.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,'tas',dummy
ncdf_close,id1

modh_gmt(m,h,0)=dummy
endif else begin
print,'No file'
endelse

endfor
endfor

; Now read in Thorsten's absolutes:
h=3
for m=0,nmodh(h)-1 do begin
print,m
if (existh(h,m) eq 1) then begin
print,modnamesh(h,m)
filenamex='hi_mod/Historical_warming_vs_ECS/CMIP6_means/tas_'+modnamesh(h,m)+'_historical.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,'tas',dummy
ncdf_close,id1

; 0 -> 1850 ; 165 -> 2015
; Thorsten's email says he used:
; historical:  1850-1900 vs. 2000-2014
; post-1975:   1975-1985 vs. 2005-2014
;def_hi=[1850,1900,2000,2014]
;def_pn=[1975,1985,2005,2014]
; But now we use:
def_hi=[1850,1900,2005,2014]
def_pn=[1975,1984,2005,2014]
bb=1850
modh_gmt_flex(m,3,0)=mean(dummy(def_hi(2)-bb:def_hi(3)-bb))-mean(dummy(def_hi(0)-bb:def_hi(1)-bb))
modh_gmt_flex(m,4,0)=mean(dummy(def_pn(2)-bb:def_pn(3)-bb))-mean(dummy(def_pn(0)-bb:def_pn(1)-bb))

endif else begin
print,'No file'
endelse

endfor

; Now read in observed temperatures from Peter Thorne's spreadsheet

do_blend=0
if (do_blend eq 1) then begin
read_hi=19 ; blended
endif else begin
read_hi=15 ; Cowton+Way
endelse
nrows_d=171
hi_year=intarr(nrows_d)
hi_temp=fltarr(nrows_d)
row_head=strarr(2)
row_temp=strarr(1)
close,2
openr,2,'/home/bridge/ggdjl/ipcc_ar6/patterns/fgd/hi_data/AR6_FGD_assessment_time_series-GMST_and_GSAT_ipcc.csv'
print,'STARTING READ THISTORICAL'
readf,2,row_head
for i=0,nrows_d-1 do begin
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
hi_year(i)=data_row(0)
hi_temp(i)=data_row(read_hi)
endfor
close,2

print,'blended years:'
print,hi_year
print,'blended temps:'
print,hi_temp


; Now read in Thorsten's ECS:

row_temp=strarr(1)
close,2
openr,2,'hi_mod/Historical_warming_vs_ECS/ecs_for_faq.csv'
print,'STARTING READ'
ecs=0.0
name_t=''

nrows_t=70

readf,2,row_temp
for i=0,nrows_t-1 do begin
readf,2,row_temp
data_row=strsplit(row_temp,',',/extract,/preserve_null)
name_t=data_row(1)
ecs=data_row(2)

ecsh(3,where(modnamesh(3,0:nmodh(3)-1) eq name_t))=ecs
ecsh(4,where(modnamesh(4,0:nmodh(4)-1) eq name_t))=ecs

endfor
close,2


 ; for gmt plot:
high_ecs=intarr(ntimeh,nmodmaxh)
high_ecs=0
high_ecs=high_ecs+(modnamesh eq 'CESM2.0' or modnamesh eq 'CESM2_1' or modnamesh eq 'HadGEM3' or modnamesh eq 'CESM2.1slab_3x')
high_ecs=high_ecs-(modnamesh eq 'INM-CM4-8' or modnamesh eq 'INM-CM4-8-deepmip_stand_6xCO2')
high_ecs(3,0:nmodh(3)-1)=ecsh(3,0:nmodh(3)-1) ge 5.0
high_ecs(3,0:nmodh(3)-1)=high_ecs(3,0:nmodh(3)-1)-(ecsh(3,0:nmodh(3)-1) le 2.0)
high_ecs(4,0:nmodh(4)-1)=high_ecs(3,0:nmodh(3)-1)


;timnameslongh: ['Pliocene','LGM','Eocene','Historical','post 1975']
ass_vlik=fltarr(ntimeh,2)
ass_c=fltarr(ntimeh)
ass_s=fltarr(ntimeh)

ass_vlik(0:2,0)=[2.5,-7,10]
ass_vlik(0:2,1)=[4.0,-5,18]
ass_c(0:2)=0.5*(ass_vlik(0:2,0)+ass_vlik(0:2,1))


; These numbers come from Thorsten's email.
ass_ct=ass_c
ass_ct(3:4)=[0.86335,0.53187]
ass_c(3:4)=[mean( hi_temp( where(hi_year ge def_hi(2) and hi_year le def_hi(3))))- $
            mean( hi_temp( where(hi_year ge def_hi(0) and hi_year le def_hi(1)))), $
            mean( hi_temp( where(hi_year ge def_pn(2) and hi_year le def_pn(3))))- $
            mean( hi_temp( where(hi_year ge def_pn(0) and hi_year le def_pn(1))))]

ass_s(3:4)=[0.2,0.15]
ass_vlik(3:4,0)=ass_c(3:4)-ass_s(3:4)
ass_vlik(3:4,1)=ass_c(3:4)+ass_s(3:4)

my_xpos=[1,2,3,4,5]
my_xposp=my_xpos-0.25
my_xposm=my_xpos+0.15
my_delt=0.2
my_del2=0.1

ylim_gmt=fltarr(2)
ylim_gmt(*)=[-12,25]

ylim_gmt_3=fltarr(ntimeh,2)
ylim_gmt_3(0,*)=[0,6]
ylim_gmt_3(1,*)=[-12,0]
ylim_gmt_3(2,*)=[0,25]
ylim_gmt_3(3,*)=[0,1.5]
ylim_gmt_3(4,*)=[0,1.5]

obs_thick=5


tvlct,r_39,g_39,b_39

;;;;;;;;;;;;;;;;;;;;;;

ngmt=5
gmtname=strarr(ngmt)
gmtname(*)=['a','b','c','d','e'] ; e is the current "best"
my_siz=fltarr(ngmt)
my_siz(*)=[0.5,2,2,2,2]
my_xsize=fltarr(ngmt)
my_xsize(*)=[10,24,24,30,30]

nplot=intarr(ngmt)
nplot(*)=[3,4,4,5,5]
nmaxplot=max(nplot)
ord_gmt=intarr(ngmt,nmaxplot)
ord_gmt(0,*)=[0,1,2,-1,-1]
ord_gmt(1,*)=[0,1,2,3,-1]
ord_gmt(2,*)=[0,1,2,-1,3]
ord_gmt(3,*)=[0,1,2,3,4]
ord_gmt(4,*)=[3,2,4,0,1]


for g=0,ngmt-1 do begin

if (g eq 0) then begin
!X.MARGIN=[10,3]
!P.MULTI = 0
endif
if (g eq 1 or g eq 2) then begin
!X.MARGIN=[10,3]*0.8
!P.MULTI = [0, 4, 1]
endif
if (g eq 3 or g eq 4) then begin
!X.MARGIN=[10,0]*0.8
!P.MULTI = [0, 5, 1]
endif


my_filename='gmt_ecs_all_new_'+gmtname(g)
print,my_filename
device,filename=my_filename+'.ps',/encapsulate,/color,set_font='Helvetica',xsize=my_xsize(g),ysize=20


if (g eq 0) then begin
; axes etc:
plot,[0,0],[0,0],xrange=[0.5,3.5],yrange=ylim_gmt,color=0,ytitle='temperature anomaly [!Eo!NC]',/nodata,xcharsize=1,ycharsize=1,charsize=1.25,xstyle=1,ystyle=1,xticks=2,xtickv=my_xpos,xtickname=timnameslong
endif


for xx=0,nplot(g)-1 do begin

t=where(ord_gmt(g,*) eq xx)
t=t(0)

; axes and legend etc:
if (g gt 0) then begin
if (xx eq 0) then this_title='temperature anomaly [!Eo!NC]'
if (xx gt 0) then this_title=''
plot,[0,0],[0,0],xrange=[0.5+xx,1.5+xx],yrange=ylim_gmt_3(t,*),color=0,ytitle=this_title,/nodata,xcharsize=1,ycharsize=1,charsize=2.5,xstyle=1,ystyle=1,xticks=1,xtickname=['',''],XTickformat='(A1)',title=timnameslongh(t)

; plot legend:
if (xx eq 0) then begin
tvlct,r_39,g_39,b_39
tvlct,250,0,0,250 ; red
tvlct,0,0,250,254 ; blue
;box:
oplot,[0.53,1.45,1.45,0.53,0.53],[0.02,0.02,0.35,0.35,0.02],color=0,thick=0.5


startx=0.7
delx=0.1
; circles:
USERSYM, COS(Aaa), SIN(Aaa), /FILL
if (do_dots eq 1) then begin
plots,startx,0.25+0.04,psym=8,symsize=my_siz(g),color=0
endif
oplot,[startx,startx],[0.25+0.04+0.04,0.25+0.04-0.04],thick=obs_thick
oplot,[startx-my_del2,startx+my_del2],[0.25+0.04-0.04,0.25+0.04-0.04],thick=obs_thick
oplot,[startx-my_del2,startx+my_del2],[0.25+0.04+0.04,0.25+0.04+0.04],thick=obs_thick

plots,startx,0.25-0.05*3,psym=8,symsize=my_siz(g),color=250
plots,startx,0.25-0.05*4,psym=8,symsize=my_siz(g),color=254

xyouts,startx+delx,0.24+0.04,'observations',size=0.9
xyouts,startx,0.24-0.05*1,'ESMs:',size=0.9
xyouts,startx+delx,0.24-0.05*3,'ECS>5.0',size=0.9
xyouts,startx+delx,0.24-0.05*4,'ECS<2.0',size=0.9

tvlct,r_0,g_0,b_0
plots,startx,0.25-0.05*2,psym=8,symsize=my_siz(g),color=200
xyouts,startx+delx,0.24-0.05*2,'2.0<ECS<5.0',size=0.9

endif

endif



; plot likely range
tvlct,r_0,g_0,b_0
oplot,[my_xposp(xx),my_xposp(xx)],[ass_vlik(t,0),ass_vlik(t,1)],thick=obs_thick
oplot,[my_xposp(xx)-my_del2,my_xposp(xx)+my_del2],[ass_vlik(t,0),ass_vlik(t,0)],thick=obs_thick
oplot,[my_xposp(xx)-my_del2,my_xposp(xx)+my_del2],[ass_vlik(t,1),ass_vlik(t,1)],thick=obs_thick
USERSYM, COS(Aaa), SIN(Aaa), /FILL
if (do_dots eq 1) then begin
plots,my_xposp(xx),ass_c(t),psym=8,symsize=my_siz(g)
if (do_tcheck eq 1) then begin
plots,my_xposp(xx),ass_ct(t),psym=8,symsize=my_siz(g)/2.0,color=50 ; plot check to see original Thorsten data
endif
endif

for p=0,1 do begin

for m=0,nmodh(t)-1 do begin

if (existh(t,m) eq 1) then begin

if (high_ecs(t,m) eq 0) then begin
tvlct,r_0,g_0,b_0
my_sym=8
my_col=200
my_thick=0.5
my_delt=0
endif
if (high_ecs(t,m) eq 1) then begin
tvlct,r_39,g_39,b_39
tvlct,250,0,0,250 ; red
my_sym=8
my_col=250
my_thick=0.5
my_delt=0.18
endif
if (high_ecs(t,m) eq -1) then begin
tvlct,r_39,g_39,b_39
tvlct,0,0,250,254 ; blue
my_sym=8
my_col=254
my_thick=0.5
my_delt=-0.18
endif


if (p eq 0) then begin
USERSYM, COS(Aaa), SIN(Aaa), /FILL
plots,my_xposm(xx)+my_delt,modh_gmt_flex(m,t,0),psym=my_sym,symsize=my_siz(g),color=my_col,NOCLIP = 0
endif

if (p eq 1) then begin
USERSYM, COS(Aaa), SIN(Aaa)
;plots,my_xposm(xx)+my_delt,modh_gmt(m,t,0),psym=my_sym,symsize=my_siz(g),color=0,thick=my_thick,NOCLIP=
;0 ; for extra blak circle around model points
if (do_tcheck eq 1) then begin
plots,my_xposm(xx)+my_delt,modh_gmt(m,t,0),psym=my_sym,symsize=my_siz(g)/2.0,color=0,NOCLIP = 0 ; plot thorsten's original model output
endif

if (plot_names_gmt eq 1) then begin
xyouts,my_xposm(xx)+0.1+my_delt,modh_gmt_flex(m,t,0),modnamesh(t,m),size=0.5
endif
endif


endif ; end if existh
endfor ; end for m
endfor ; end for p

endfor ; end for xx

device,/close
spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum
if (make_pdf eq 1) then begin
spawn,'ps2pdf -dEPSCrop -dAutoRotatePages=/None '+my_filename+'.eps '+my_filename+'.pdf',dum
endif
if (make_png eq 1) then begin
spawn,'convert -flatten -density 2000 '+my_filename+'.eps '+my_filename+'.png'
endif

!X.MARGIN=[10,3]
!P.Multi = 0

endfor ; end for g

endif ; end if make_gmt


if (make_csv_gmt eq 1) then begin

;;;;;;;;;;;;

ipcc_max=1000
ipcc_t=fltarr(ipcc_max) ; temperature
ipcc_e=fltarr(ipcc_max) ; ecs (High[1], Low[-1], or Middle[0])
ipcc_n=strarr(ipcc_max) ; model name
ipcc_p=strarr(ipcc_max) ; period

x=0
for xx=0,nplot(4)-1 do begin

t=where(ord_gmt(4,*) eq xx)
t=t(0)

for m=0,nmodh(t)-1 do begin
if (existh(t,m) eq 1) then begin

ipcc_e(x)=high_ecs(t,m)
ipcc_t(x)=modh_gmt_flex(m,t,0)
ipcc_n(x)=modnamesh(t,m)
ipcc_p(x)=timnameslongh(t)

x=x+1

endif
endfor

endfor
ipcc_nx=x

ipcc_allheader=['This data file provides the modelling data behind Figure 7.19','It was produced by Dan Lunt, using script plot_all_fgd.pro']
ipcc_colheader=['Time Period','Model Name','Temperature Anomaly [degrees C]','Model ECS (High[1], Low[-1], or Middle[0]']

write_csv,'Figure7_19_mod.csv',ipcc_p(0:ipcc_nx-1),ipcc_n(0:ipcc_nx-1),ipcc_t(0:ipcc_nx-1),ipcc_e(0:ipcc_nx-1),header=ipcc_colheader,table_header=ipcc_allheader


;;;;;;;;;;;;

ipcc_max=ntimeh
ipcc_p=strarr(ipcc_max) ; period
ipcc_mi=fltarr(ipcc_max) ; min temp
ipcc_me=fltarr(ipcc_max) ; mean temp
ipcc_ma=fltarr(ipcc_max) ; max temp

x=0
for xx=0,nplot(4)-1 do begin

t=where(ord_gmt(4,*) eq xx)
t=t(0)

ipcc_p(x)=timnameslongh(t)
ipcc_mi(x)=ass_vlik(t,0)
ipcc_me(x)=ass_c(t)
ipcc_ma(x)=ass_vlik(t,1)

x=x+1

endfor

ipcc_nx=x

ipcc_allheader=['This data file provides the observational data behind Figure 7.19','It was produced by Dan Lunt, using script plot_all_fgd.pro']
ipcc_colheader=['Time Period','min temperature [degreesC]','mean temperature [degreesC]','max temperature [degreesC]']

write_csv,'Figure7_19_obs.csv',ipcc_p(0:ipcc_nx-1),ipcc_mi(0:ipcc_nx-1),ipcc_me(0:ipcc_nx-1),ipcc_ma(0:ipcc_nx-1),header=ipcc_colheader,table_header=ipcc_allheader


;;;;;;;;;;;;


endif



close,1
openw,1,'temp_sat_models.txt'
printf,1,'SAT'
printf,1,'!!!!!!'
for t=0,ntime-1 do begin
printf,1,timnameslong(t)
for m=0,nmod(t)-1 do begin
printf,1,modnames(t,m),mod_gmt(m,t,0)
endfor
printf,1,'ensemble mean: ',mean(mod_gmt(0:nmod(t)-1,t,0))
printf,1,'ensemble std: ',stddev(mod_gmt(0:nmod(t)-1,t,0))
printf,1,'!!!!!!'
endfor


close,1
openw,1,'temp_sstzonmean_models.txt'
printf,1,'SST zonmean'
printf,1,'!!!!!!'
for t=0,ntime-1 do begin
printf,1,timnameslong(t)
for m=0,nmod(t)-1 do begin
printf,1,modnames(t,m),mod_gmt(m,t,1)
endfor
printf,1,'ensemble mean: ',mean(mod_gmt(0:nmod(t)-1,t,1))
printf,1,'ensemble std: ',stddev(mod_gmt(0:nmod(t)-1,t,1))
printf,1,'!!!!!!'
endfor
close,1




stop

end




pro find_lonlat,nx,ny,lons_m,lats_m,loni,lati,modvar,xindex,yindex


; Find the nearest gridpoint for each data point (but only if no land)
distx=fltarr(nx)
distx1=abs(loni-lons_m(0:nx-1))
distx2=abs(loni-lons_m(0:nx-1)-360)
distx3=abs(loni-lons_m(0:nx-1)+360)
for i=0,nx-1 do begin
distx(i)=min([distx1(i),distx2(i),distx3(i)])
endfor

mindistx=min(distx)

xindex=!c

disty=abs(lati-lats_m(0:ny-1))
mindisty=min(disty)
yindex=!c

; now expand out if necessary

if (finite(modvar(xindex,yindex)) ne 1) then begin

sorted=0
sorted2=0
;print,'*************'

this_xindex=-1
this_yindex=-1

for zz=1,8 do begin ; this was 4
; i expanded out to 5 as needed for using "aver"
; i expanded out to 8 as needed for using IPSL LGM

; start at corners and work in.  Do lats first so preference to zonal

; first do 4 corners:
xp0=xindex+zz
xp0=xp0 mod nx
xm0=xindex-zz
xm0 = xm0 + (xm0 lt 0)*nx
yp0=yindex+zz
if (yp0 gt ny-1) then yp0=ny-1
ym0=yindex-zz
if (ym0 lt 0) then ym0=0

if (finite(modvar(xm0,yp0)) and sorted2 eq 0) then begin
;print,zz,'xm0 yp0 is here',xm0,yp0
sorted=1
this_xindex=xm0
this_yindex=yp0
endif

if (finite(modvar(xp0,yp0)) and sorted2 eq 0) then begin
;print,zz,'xp0 yp0 is here',xp0,yp0
sorted=1
this_xindex=xp0
this_yindex=yp0
endif

if (finite(modvar(xm0,ym0)) and sorted2 eq 0) then begin
;print,zz,'xm0 ym0 is here',xm0,ym0
sorted=1
this_xindex=xm0
this_yindex=ym0
endif

if (finite(modvar(xp0,ym0)) and sorted2 eq 0) then begin
;print,zz,'xp0 ym0 is here',xp0,yp0
sorted=1
this_xindex=xp0
this_yindex=ym0
endif

;print,'zz AFTER corners and sorted:',zz,sorted,sorted2

; now come in along the edges

;print,'xindex, yindex: ',xindex(d,m),yindex(d,m)

for xxx=0,zz-1 do begin

xp1=xindex+zz-xxx-1
xp1=xp1 mod nx

xm1=xindex-zz+xxx+1
xm1 = xm1 + (xm1 lt 0)*nx

yp1=yindex+zz-xxx-1
if (yp1 gt ny-1) then yp1=ny-1

ym1=yindex-zz+xxx+1
if (ym1 lt 0) then ym1=0


if (finite(modvar(xm1,yp0)) and sorted2 eq 0) then begin
;print,zz, xxx,' xm1 yp0 is here',xm1,yp0
sorted=1
this_xindex=xm1
this_yindex=yp0
endif

if (finite(modvar(xp1,yp0)) and sorted2 eq 0) then begin
;print,zz, xxx,' xp1 yp0 is here',xp1,yp0
sorted=1
this_xindex=xp1
this_yindex=yp0
endif

if (finite(modvar(xm1,ym0)) and sorted2 eq 0) then begin
;print,zz, xxx,' xm1 ym0 is here',xm1,ym0
sorted=1
this_xindex=xm1
this_yindex=ym0
endif

if (finite(modvar(xp1,ym0)) and sorted2 eq 0) then begin
;print,zz, xxx,' xp1 ym0 is here',xp1,ym0
sorted=1
this_xindex=xp1
this_yindex=ym0
endif

; ---

if (finite(modvar(xm0,yp1)) and sorted2 eq 0) then begin
;print,zz, xxx,' xm0 yp1 is here',xm0,yp1
sorted=1
this_xindex=xm0
this_yindex=yp1
endif

if (finite(modvar(xp0,yp1)) and sorted2 eq 0) then begin
;print,zz, xxx,' xp0 yp1 is here',xp0,yp1
sorted=1
this_xindex=xp0
this_yindex=yp1
endif

if (finite(modvar(xm0,ym1)) and sorted2 eq 0) then begin
;print,zz, xxx,' xm0 ym1 is here',xm0,ym1
sorted=1
this_xindex=xm0
this_yindex=ym1
endif

if (finite(modvar(xp0,ym1)) and sorted2 eq 0) then begin
;print,zz, xxx,' xp0 ym1 is here',xp0,ym1
sorted=1
this_xindex=xp0
this_yindex=ym1
endif

endfor ; end xxx loop

if (sorted eq 1) then sorted2=1

endfor ; end zz loop

if (sorted2 eq 1) then begin
xindex=this_xindex
yindex=this_yindex
endif

if (sorted2 eq 0) then begin
print,'not sorted - we have a missing value that cant be resolved'
stop
endif


endif ; end if missing



end


