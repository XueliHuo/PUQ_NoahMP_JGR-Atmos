%% Spatial maps
%% Read in longitude and latitude information
basedir = '/Users/xuelihuo/Documents/HengHydro/Reviewerscomment/DataScriptsJGR/';
deflh=ncread([basedir,'localini800paretomean.nc'],'objfuncflh');
defgpp=ncread([basedir,'localini800paretomean.nc'],'objfuncgpp');

optlh=ncread([basedir,'localinterini1000best.nc'],'objfuncflh');
optgpp=ncread([basedir,'localinterini1000best.nc'],'objfuncgpp');

%lon=97.4375+0.125/2:0.125:104.3125-0.125/2;
lat=39.4375+0.125/2:0.125:43.8125-0.125/2;
mod_lon=ncread('/Users/xuelihuo/Documents/HengHydro/Modify_Figures_in_Review_Heng/HengHydro_location/veg_soil.nc','lon');
lon=mod_lon(165:219);
%%
deflh(deflh==min(deflh,[],'all'))=nan;
defgpp(defgpp==min(defgpp,[],'all'))=nan;
optlh(optlh==min(optlh,[],'all'))=nan;
optgpp(optgpp==min(optgpp,[],'all'))=nan;


%% FLH
figure()
vartoplot=deflh(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(a) Default: RMSE of FLH')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[8.9 27])

figure()
vartoplot=optlh(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(b) Optimal: RMSE of FLH')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[8.9 27])

figure()
vartoplot=(optlh(165:219,115:149)'-deflh(165:219,115:149)')./deflh(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
c=centered_colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(c) FLH: Normalized RMSE Difference')
%set(gcf,'Position',[2068 220 941 641]);


%% GPP
figure()
vartoplot=defgpp(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(a) Default: RMSE of GPP')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[0.6 2.4])

figure()
vartoplot=optgpp(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(b) Optimal: RMSE of GPP')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[0.6 2.4])

%% Default
basedir = '/Users/xuelihuo/Documents/HengHydro/Reviewerscomment/DataScriptsJGR/';
orilh=ncread([basedir,'defaultrmseinfo838803.nc'],'objfuncflh');
origpp=ncread([basedir,'defaultrmseinfo838803.nc'],'objfuncgpp');

lon=97.4375+0.125/2:0.125:104.3125-0.125/2;
lat=39.4375+0.125/2:0.125:43.8125-0.125/2;
%%
orilh(orilh==min(orilh,[],'all'))=nan;
origpp(origpp==min(origpp,[],'all'))=nan;


%% FLH
figure()
vartoplot=orilh(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(c) Original: RMSE of FLH')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[8.9 27])

%% GPP
figure()
vartoplot=origpp(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
colormap jet
c=colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(c) Original: RMSE of GPP')
%set(gcf,'Position',[2068 220 941 641]);
set(gca,'Clim',[0.6 2.4])

%% Difference between Optimal and Default
% FLH
figure()
vartoplot=optlh(165:219,115:149)'-orilh(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
c=centered_colorbar;
c.Label.String = '(W m^-^2)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(d) FLH: Opt-Ori')

nanmean(vartoplot(:))%-1.6685
dx=0.5;
nx = -6:dx:4.5;
figure
h=histogram(vartoplot(:),nx)
h.FaceColor=[0.9 0.3 0];
set(gca,'FontName', 'Times New Roman',...
'FontSize',25);
ylabel('Number of grids','FontName', 'Times New Roman', 'FontSize',25);
xlabel('FLH (W m^-^2)','FontName','Times New Roman','Fontsize',25);
title('(e) FLH: Opt-Ori','FontName','Times New Roman','Fontsize',25,'FontWeight','bold');
text(0,55,'mean=-1.6685','FontName','Times New Roman','Fontsize',26);

sum(vartoplot(:)<0)/sum(~isnan(vartoplot(:)))%0.8172
sum(vartoplot(:)>=0)/sum(~isnan(vartoplot(:)))%0.1828

% GPP
figure()
vartoplot=optgpp(165:219,115:149)'-origpp(165:219,115:149)';
h1 = imagesc(lon,lat,vartoplot);
set(h1,'AlphaData',~isnan(vartoplot))
set(gca,'YDir','normal','FontName','Times New Roman','FontSize',20)
c=centered_colorbar;
c.Label.String = '(gC m^-^2 day^-^1)';
c.Location = 'eastoutside';
c.FontSize = 19;
c.FontWeight = 'bold';
title('(d) GPP: Opt-Ori')

nanmean(vartoplot(:))%-0.0559
dx=0.05;
nx = -0.6:dx:0.4;
figure
h=histogram(vartoplot(:),nx)
set(gca,'FontName', 'Times New Roman',...
'FontSize',25);
ylabel('Number of grids','FontName', 'Times New Roman', 'FontSize',25);
xlabel('GPP (gC m^-^2 day^-^1)','FontName','Times New Roman','Fontsize',25);
title('(e) GPP: Opt-Ori','FontName','Times New Roman','Fontsize',25,'FontWeight','bold');
text(-0.6,55,'mean=-0.0559','FontName','Times New Roman','Fontsize',26);

sum(vartoplot(:)<0)/sum(~isnan(vartoplot(:)))%0.5666
sum(vartoplot(:)>=0)/sum(~isnan(vartoplot(:)))%0.4334