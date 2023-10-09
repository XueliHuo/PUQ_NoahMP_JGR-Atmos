; This is to plot the spatial average of annual value of Jung's variables
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl" 


begin 
     ncfile=addfile("/glade/u/home/huoxl/HengHydro_location/veg_soil.nc","r")
     ;lon=(/ncfile->lon(165:220)/)
     ;lat=(/ncfile->lat(115:150)/)
	 lon=(/ncfile->lon/)
     lat=(/ncfile->lat(0:191)/)
;     print(lon)
;     print(lat)
	 plon = dimsizes(lon)
     plat = dimsizes(lat)

;     aifile=addfile("/glade/u/home/huoxl/HengHydro_location/allcdfbexpexpandsample121_best.nc","r")
     ;aifile=addfile("/glade/u/home/huoxl/HengHydro_location/veg7rmseinfo_niupara.nc","r")
     aifile=addfile("/glade/u/home/huoxl/HengHydro_location/defaultrmseinfo838803.nc","r")
     ;aifile=addfile("/glade/u/home/huoxl/HengHydro_location/localini800paretomean.nc","r")
;     aifile=addfile("/glade/u/home/huoxl/HengHydro_location/allrmseorirangesample440_best.nc","r")
     ;Aridity_annual_clim=aifile->objfuncgpp(115:150,165:220)
     Aridity_annual_clim=aifile->objfuncflh(0:191,:)
;     printVarSummary(Aridity_annual_clim)
	 Aridity_annual_clim@long_name= ""
	 Aridity_annual_clim@units=""

   ncfile_river=addfile("/glade/u/home/huoxl/HengHydro_location/rivermask_hu2_v6_new.nc","r")
   ;rivermask=ncfile_river->landmask(115:150,165:220)
   rivermask=ncfile_river->landmask(0:191,:)
;   printVarSummary(rivermask)
   rivermask(0,0)=19
   rivermask@long_name=""  ;do not show center string
   rivermask@units=""
   
;----open workstation----
   wks = gsn_open_wks("ps","SandyResearchArea_Niupara")       


    ;cmap = (/"(/1.00,1.00,1.00/)","(/0.00,0.00,0.00/)",\
    ;       "red4","red3","red2","orange","yellow2","wheat","wheat3","wheat4",\
    ;      "lightskyblue","deepskyblue","purple","purple3","blue","blue3","navyblue"/)
;--below cmap is based on inversed "BlueDarkRed18" but has only 14 colors--
;  cmap =	 (/"(/1.00,1.00,1.00/)","(/0.00,0.00,0.00/)",\
;              "(/0.14,0.00,0.85/)","(/0.09,0.11,0.97/)",\
;			  "(/0.16,0.34,1.00/)","(/0.24,0.53,1.00/)","(/0.34,0.69,1.00/)",\
;			  "(/0.46,0.83,1.00/)","(/0.60,0.92,1.00/)","(/0.74,0.98,1.00/)",\
;			  "(/0.92,1.00,1.00/)","(/1.00,1.00,0.92/)","(/1.00,0.95,0.74/)",\
;			  "(/1.00,0.84,0.60/)","(/1.00,0.67,0.46/)","(/1.00,0.47,0.34/)",\
;			  "(/1.00,0.24,0.24/)","(/0.97,0.15,0.21/)",\
;              "(/0.85,0.08,0.18/)","(/0.65,0.0,0.13/)"/)
  cmap =	 (/"(/1.00,1.00,1.00/)","(/0.00,0.00,0.00/)",\
              "(/0.00,0.00,0.51/)","(/0.00,0.00,0.68/)",\
			  "(/0.00,0.00,0.87/)","(/0.00,0.03,1.00/)","(/0.00,0.19,1.00/)",\
              "(/0.00,0.44,1.00/)","(/0.00,0.69,1.00/)","(/0.00,0.80,1.00/)",\
			  "(/0.02,1.00,0.97/)","(/1.00,0.98,0.00/)","(/1.00,0.91,0.00/)",\
			  "(/1.00,0.73,0.00/)","(/1.00,0.67,0.00/)","(/1.00,0.45,0.00/)",\
			  "(/1.00,0.17,0.00/)","(/0.92,0.00,0.00/)",\
              "(/0.73,0.00,0.00/)","(/0.53,0.00,0.00/)"/)
    gsn_define_colormap(wks,cmap)
  
   res=True
   gsres = True   ; resource lists.
   
;---ScalarField--
   res@sfXCStartV = min(lon)
   res@sfXCEndV   = max(lon)
   res@sfYCStartV = min(lat)
   res@sfYCEndV   = max(lat)
   
;--XB and YL Font,size and tickmark--
   res@tmXBLabelFont=21
   res@tmYLLabelFont=21
   res@tmXBLabelFontHeightF   = 0.007
   res@tmYLLabelFontHeightF   = 0.007 
   res@tmXBMinorOn=False  ; do not show the minor ticks
   res@tmYLMinorOn=False  ; do not show the minor ticks
   res@tmXTOn    = False  ;do not show tickmark in X top
   res@tmYROn    = False  ;do not show tickmark in Y right

;---map projection and size--- 
   res@mpProjection = "CylindricalEquidistant"; default is CylindricalEquidistant
   res@mpCenterLonF = (lon(0)+lon(plon-1))/2.
   res@mpCenterLatF = 0.
   res@mpLimitMode = "LatLon"    ; Limit the map view.   
   res@mpMinLonF   = min(lon)
   res@mpMaxLonF   = max(lon)
   res@mpMinLatF   = min(lat)
   res@mpMaxLatF   = max(lat)
   
;----map perim---  
   res@mpPerimOn   = True        ; Turn on map perimeter to draw the line around the edge (rectangle) of map
   res@mpPerimDrawOrder = "PostDraw"
  
;----map fill and mask---  
   res@mpDataBaseVersion = "Ncarg4_1" 
   res@mpDataSetName = "Earth..2"
   res@mpFillOn              = True         ; Turn on map fill.
   res@mpFillAreaSpecifiers  = (/"Water","Land : North America : Canada","Land : North America : Mexico"/)  ; Donot fill water
   res@mpSpecifiedFillColors = (/0,0,0/) ; 0 donot fill the water/Canada/Mexico
   res@cnFillDrawOrder       = "Predraw"       ; Draw contours first.
   res@mpAreaMaskingOn       = True
   res@mpMaskAreaSpecifiers  = "Land"
   
;----map outline---
   res@mpOutlineBoundarySets = "Geophysical"
   res@mpOutlineDrawOrder    = "PostDraw"
   res@mpNationalLineThicknessF = 1.  ;this is default
   res@mpUSStateLineThicknessF  = 0.01
   
   
;---contours info-----
   res@cnInfoLabelOn = False
   res@cnLinesOn = False
   res@cnLineLabelsOn = False
   res@cnMonoLevelFlag =  False
   res@cnLevelFlags = "NoLine"
   res@cnFillOn       = True
   ;res@cnLabelBarEndStyle ="IncludeOuterBoxes" ;default is "IncludeOuter" Boxes to show the outer of max and min for first and last box
   res@cnLevelSelectionMode = "ManualLevels"
   res@cnMinLevelValF       = 8 ;For flhcdfoptimized:10 gppcdfoptimized:0.5
   res@cnMaxLevelValF       = 26 ;For flhcdfoptimized:25 gppcdfoptimized:2.0
   res@cnLevelSpacingF      = 2  ;For flhcdfoptimized:5 gppcdfoptimized:0.5
   
;----label bar----
   
   ;res@lbLabelBarOn        = False  ;we are adding a common labelbar, so we turn off the lb first to avoid 2 lbs.
   ;res@pmLabelBarDisplayMode = "Always"
   res@pmLabelBarWidthF = 0.04           ;default is 0.15
   res@pmLabelBarHeightF =0.2           ; default is 0.6
   res@pmLabelBarOrthogonalPosF = 0.02 ;position of lb default is 0.02
   res@pmLabelBarParallelPosF   = 0.5   ;position of lb default is 0.5
   res@lbAutoManage = False
   res@lbPerimOn             = False
   res@lbLabelFont = 21
   res@lbLabelFontHeightF = 0.006  ;default=0.02
   res@lbOrientation      = "Vertical"
   res@lbTitleOn        = True                  ; turn on title
   res@lbTitleString    = "RMSE of FLH (W/m~S~2~N~)"
   res@lbTitleFont = 21
   res@lbTitleFontHeightF= 0.007                 ; make title smaller
   ;res@lbBoxCount=11; the number of box in labelbar, the default is 16. Note for Jung's NA it should be 11
;----legend--

;----text--
   res@txFuncCode="~" ;The default is ":", we now use "~"
;----gsn---
   ;res@gsnScale = True      ; Force X/Y axes labels to be the same size.
   res@gsnFrame = False      ; Don't advance frame.
   res@gsnDraw  = False      ; don't draw since we will use gsn_Panel
   res@gsnStringFont=21
   res@gsnStringFontHeightF = 0.012
;   res@gsnLeftString="(f)"  ; don't show the left string
;   res@gsnCenterString="Research Area"  ; don't show the left string
   res@gsnRightString="" ; don't show the right string
 
;----plot size---  
   res@vpWidthF  = 0.5
   res@vpHeightF = 0.3
 
 ;----res2 for rivermask--
   res2   = True
   res2@sfXCStartV = min(lon)
   res2@sfXCEndV   = max(lon)
   res2@sfYCStartV = min(lat)
   res2@sfYCEndV   = max(lat)
   res2@cnLinesOn = True
   res2@cnLineThicknessF=0.8 ;default is 1.0
   res2@cnInfoLabelOn = False
   ;res2@cnLineColor ="gray20" ;use default col
   res2@cnLineLabelsOn = False
   res2@cnMonoLevelFlag =  False
   res2@cnLevelFlags = "NoLine"
   res2@cnConstFLabelPerimOn=False
   res2@cnFillOn       = False
   res2@cnLevelSelectionMode = "ExplicitLevels" 
   res2@cnLevels       = (/0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19/)
   res2@gsnFrame = False ; Don't advance frame.
   
   plot_0 = gsn_csm_contour_map_overlay(wks,Aridity_annual_clim,rivermask,res,res2) 
   draw(plot_0)
   frame(wks) 
; To delete white space from the plot
   delete(wks)
   fname = "SandyResearchArea_Niupara"
   cmd = "convert -alpha off -background white -density 600 -trim "+fname+".ps "+fname+".png"
   system(cmd)
end 
   
   
