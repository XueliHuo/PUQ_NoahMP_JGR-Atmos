%% Spatial maps
%% Longtitude and Latitude Information
%lon=97.4375+0.125/2:0.125:104.3125-0.125/2;
lat=39.4375+0.125/2:0.125:43.8125-0.125/2;
mod_lon=ncread('/Users/xuelihuo/Documents/HengHydro/Modify_Figures_in_Review_Heng/HengHydro_location/veg_soil.nc','lon');
lon=mod_lon(165:219);
%% Default
basedir = '/Users/xuelihuo/Documents/HengHydro/Reviewerscomment/DataScriptsJGR/default838803/';
defFLH=ncread([basedir,'Noah.monthlymean.838803.nc'],'FLH');
defGPP=ncread([basedir,'Noah.monthlymean.838803.nc'],'GPP');
defFLHmean=nanmean(defFLH,3);
defGPPmean=nanmean(defGPP,3);
defFLHmean(defFLHmean==min(defFLHmean,[],'all'))=nan;
defGPPmean(defGPPmean==min(defGPPmean,[],'all'))=nan;

%% Interact optimal
basedir = '/Users/xuelihuo/Documents/HengHydro/Reviewerscomment/DataScriptsJGR/sample1062/';
interactFLH=ncread([basedir,'Noah.monthlymean.838803.nc'],'FLH');
interactGPP=ncread([basedir,'Noah.monthlymean.838803.nc'],'GPP');
interactFLHmean=nanmean(interactFLH,3);
interactGPPmean=nanmean(interactGPP,3);
interactFLHmean(interactFLHmean==min(interactFLHmean,[],'all'))=nan;
interactGPPmean(interactGPPmean==min(interactGPPmean,[],'all'))=nan;

%% Noninteract Optimal
numpareto=7;
noninteractFLH=ones(size(defFLH,1),size(defFLH,2),numpareto);
noninteractGPP=ones(size(defGPP,1),size(defGPP,2),numpareto);
noninteractsampleindex=["802";"818";"817";"814";"811";"819";"803"];

for i=1:numpareto
    prebasedir = '/Users/xuelihuo/Documents/HengHydro/Reviewerscomment/DataScriptsJGR/';
    filename=strcat(prebasedir,'sample',noninteractsampleindex(i),'/Noah.monthlymean.838803.nc');
    tempFLH=ncread(filename,'FLH');
    tempGPP=ncread(filename,'GPP');
    noninteractFLH(:,:,i)=nanmean(tempFLH,3);
    noninteractGPP(:,:,i)=nanmean(tempGPP,3);
end

%%
noninteractFLHmean=nanmean(noninteractFLH,3);
noninteractGPPmean=nanmean(noninteractGPP,3);
noninteractFLHmean(noninteractFLHmean==min(noninteractFLHmean,[],'all'))=nan;
noninteractGPPmean(noninteractGPPmean==min(noninteractGPPmean,[],'all'))=nan;

%% Default
%% FLH
figure()
vartoplot=defFLHmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(c) Original: FLH')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[20 44.5])

%% GPP
dayconvert=3600*24;
defGPPmean=defGPPmean*dayconvert;
figure()
vartoplot=defGPPmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(c) Original: GPP')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[0.52 2.36])

%% Interact Optimal
%% FLH
figure()
vartoplot=interactFLHmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(b) Optimal: FLH')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[20 44.5])

%% GPP
dayconvert=3600*24;
interactGPPmean=interactGPPmean*dayconvert;
figure()
vartoplot=interactGPPmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(b) Optimal: GPP')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[0.52 2.36])

%% Noninteract Optimal
%% FLH
figure()
vartoplot=noninteractFLHmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(a) Default: FLH')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[20 44.5])

%% GPP
dayconvert=3600*24;
noninteractGPPmean=noninteractGPPmean*dayconvert;
figure()
vartoplot=noninteractGPPmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(a) Default: GPP')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[0.52 2.36])

%% Observation
basedir = '/Users/xuelihuo/Documents/HengHydro/Reviewerscomment/DataScriptsJGR/validata/';
obswholeFLH=ncread([basedir,'Jung_LE_NA_0125_2.nc'],'LE');%MJ/m2/day
obswholeGPP=ncread([basedir,'Jung_GPP_NA_0125_2.nc'],'GPP');%Kg/m2/s

obsFLH=ones(size(defFLH,1),size(defFLH,2),size(defFLH,3));
obsGPP=ones(size(defGPP,1),size(defGPP,2),size(defGPP,3));

obsFLH(:,:,1:12)=obswholeFLH(:,:,13:24);%1983
obsFLH(:,:,13:24)=obswholeFLH(:,:,73:84);%1988
obsFLH(:,:,25:36)=obswholeFLH(:,:,253:264);%2003

obsGPP(:,:,1:12)=obswholeGPP(:,:,13:24);%1983
obsGPP(:,:,13:24)=obswholeGPP(:,:,73:84);%1988
obsGPP(:,:,25:36)=obswholeGPP(:,:,253:264);%2003


obsFLHmean=nanmean(obsFLH,3);
obsGPPmean=nanmean(obsGPP,3);
obsFLHmean(obsFLHmean==min(obsFLHmean,[],'all'))=nan;
obsGPPmean(obsGPPmean==min(obsGPPmean,[],'all'))=nan;

obsFLHmean(isnan(defFLHmean))=nan;
obsGPPmean(isnan(defGPPmean))=nan;

obsFLHmean=obsFLHmean*1e6/3600/24;% convert from MJ/m2/day to W/m2
obsGPPmean=obsGPPmean*1e3;% convert from kg/m2/s to g/m2/s


%% Noninteract Optimal
%% FLH
figure()
vartoplot=obsFLHmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(d) Obs: FLH')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[20 44.5])

%% GPP
dayconvert=3600*24;
obsGPPmean=obsGPPmean*dayconvert;
figure()
vartoplot=obsGPPmean(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(d) Obs: GPP')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[0.52 2.36])

%% FLH [10 45]
nanmin(defFLHmean,[],'all')%21.6117
nanmin(interactFLHmean,[],'all')%24.5303
nanmin(noninteractFLHmean,[],'all')%20.0142
nanmin(obsFLHmean,[],'all')% 25.0965

nanmax(defFLHmean,[],'all')%41.8656
nanmax(interactFLHmean,[],'all')%42.8672
nanmax(noninteractFLHmean,[],'all')%43.9031
nanmax(obsFLHmean,[],'all')% 44.5441

%% GPP [0.2 2.8]
nanmin(defGPPmean,[],'all')%0.6888
nanmin(interactGPPmean,[],'all')%1.0001
nanmin(noninteractGPPmean,[],'all')%0.9138
nanmin(obsGPPmean,[],'all')%0.5231

nanmax(defGPPmean,[],'all')% 1.7189
nanmax(interactGPPmean,[],'all')% 2.0858
nanmax(noninteractGPPmean,[],'all')%2.3303
nanmax(obsGPPmean,[],'all')%2.3625