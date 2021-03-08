pro pt

;;;;;;;;;;
read_mod=1
make_map_plots=1
;;;;;;;;;;

make_pdf=0
make_png=0

ntime=3

; ** change ntime
timnames=strarr(ntime)
timnames(0:ntime-1)=['ssp126','ssp370','ssp585']
timnameslong=strarr(ntime)
timnameslong(0:ntime-1)=['SSP1-2.6','SSP3-7.0','SSP5-8.5']
basenameslong=strarr(ntime)
basenameslong(0:ntime-1)=['1995-2014','1995-2014','1995-2014']
pernameslong=strarr(ntime)
pernameslong(0:ntime-1)=['2081-2100','2081-2100','2081-2100']

nvar=1
; ** change ntime
varname=strarr(ntime,nvar)
varname(0:ntime-1,0)=['tas']

varnametitle=strarr(nvar)
varnametitle(0:nvar-1)=['SAT']

nx=360
ny=180

; ** change ntime

temp_min_e=fltarr(ntime,nvar)
temp_max_e=fltarr(ntime,nvar)
nnstep=fltarr(ntime,nvar)
my_ndecs=intarr(ntime,nvar)
my_ncols=20

; colour for sat map
temp_min_e(*,0)=[-18,-18,-18]
temp_max_e(*,0)=[18,18,18]
nnstep(*,0)=[2,2,2]
my_ndecs(*,0)=[1,1,1]

legendline=[-45,-35]
legendtext=-30

linestyle_mod=0
linestyle_band=2

;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Now read in the model data...

if (read_mod eq 1) then begin

ensmean_map=fltarr(nx,ny,ntime,nvar)

dummy_map=fltarr(nx,ny)

for t=0,ntime-1 do begin
for v=0,nvar-1 do begin

; read ensemble mean map
filenamex='ssp_mod/tas_annual_longterm_'+timnames(t)+'.nc'
print,filenamex
id1=ncdf_open(filenamex)
ncdf_varget,id1,varname(t,v),dummy_map
if (v eq 0 and t eq 0) then begin
ncdf_varget,id1,'lon',lons
ncdf_varget,id1,'lat',lats
endif
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

endfor
endfor

endif ; end read_mod


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
for v=0,nvar-1 do begin

mapname='ensmean'

my_tcharsize=190

my_arr=ensmean_map(*,*,t,v)

map_charsize=230

; filename
my_filename=timnames(t)+'_modeldata_cont_'+varname(v)+'_ipcc_czt_nodata_ensmean'
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

thistitle=strtrim(varnametitle(v)+' ('+timnameslong(t)+': '+pernameslong(t)+' - '+basenameslong(t)+')',2)

CON, F=my_arr,x=lons(*),y=lats(*),TITLE=thistitle, CB_TITLE='temperature anomaly [!Eo!NC]',/NOLINES,/block,CB_NTH=2

nglon=5
grids_lon=fltarr(nglon)
grids_lon(*)=[60,30,0,-30,-60]
grids_lon_label=strarr(nglon)
grids_lon_label=['60N','30N','EQ','30S','60S']
grids_lat_offset=[-5,-5,-5,-5,-5]
for g=0,nglon-1 do begin
plots,[0,180],[grids_lon(g),grids_lon(g)],color=1,linestyle=1,thick=0.1
plots,[-180,-0.001],[grids_lon(g),grids_lon(g)],color=1,linestyle=1,thick=0.1
xyouts,-175,grids_lon(g)+grids_lat_offset(g),grids_lon_label(g),color=1,charsize=0.8
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
xyouts,grids_lat(g)+grids_lat_offset(g),-85,grids_lat_label(g),color=1,charsize=0.8
endfor



; Land-sea mask
;LEVS,MANUAL=['0','100000']
;CON,F=topo_map(*,*,t),x=lons,y=lats,/nomap,/nocolbar,/NOFILL,/NOAXES,TITLE='',/NOLINELABELS

psclose,/noview
spawn,'ps2epsi '+my_filename+'.ps '+my_filename+'.eps ; \rm '+my_filename+'.ps',dum
if (make_pdf eq 1) then begin
spawn,'ps2pdf -dEPSCrop -dAutoRotatePages=/None '+my_filename+'.eps '+my_filename+'.pdf',dum
endif


endfor ; end v
endfor ; end t

endif ; end make map plots



end


