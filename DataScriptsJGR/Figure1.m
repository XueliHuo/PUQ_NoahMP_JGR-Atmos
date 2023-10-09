%% Figure 1
clear all;
load('aiprecipitationRegional.mat');
%
ai_yr_ave_mean=mean(ai_yr_ave)*ones(30,1);
prcp_yr_ave_mean=mean(prcp_yr_ave)*ones(30,1);

%
figure();
Xticks=[1,6,11,16,21,26,30];
XTickLabels=[1982,1987,1992,1997,2002,2007,2011];
sz=80;

subplot(2,1,1);
barx=[1.5 6.5 21.5];
bary=[720 720 720];
plot(1:30,prcp_yr_ave,'blue','LineWidth',2,'LineStyle','-');hold on;
plot(1:30,prcp_yr_ave_mean,'black','LineWidth',2,'LineStyle','--');hold on;
scatter([1:2 6:7 21:22],prcp_yr_ave([1:2 6:7 21:22]),sz,'o','MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);hold on;

b1=bar(barx,bary,0.5,'FaceColor',[0 .9 .9]);
b1.FaceAlpha = 0.1;

hold on;
set(gca,'XLim',[0,31],'YLim',[230,800],'FontName', 'Times New Roman',...
'FontSize',20,...
'XTick',Xticks, ...
'XTickLabel',num2str(XTickLabels'));
box off;
ylabel('(mm)','FontName', 'Times New Roman', 'FontSize',20);
xlabel('Year','FontName', 'Times New Roman', 'FontSize',20);
title('Annual precipitation','Fontsize',20);
text(0.5,860,'(a)','FontName', 'Times New Roman','Fontsize',22,'FontWeight','bold');

subplot(2,1,2);
barx=[1.5 6.5 21.5];
bary=[0.72 0.72 0.72];
plot(1:30,ai_yr_ave,'red','LineWidth',2,'LineStyle','-');hold on;
plot(1:30,ai_yr_ave_mean,'black','LineWidth',2,'LineStyle','--');
scatter([1:2 6:7 21:22],ai_yr_ave([1:2 6:7 21:22]),sz,'o','MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);hold on;

b1=bar(barx,bary,0.5,'FaceColor',[0 .9 .9]);
b1.FaceAlpha = 0.1;
set(gca,'XLim',[0,31],'YLim',[0.2,0.8],'FontName','Times New Roman',...
'FontSize',20,...
'XTick',Xticks, ...
'XTickLabel',num2str(XTickLabels'));
box off;
xlabel('Year','FontName', 'Times New Roman', 'FontSize',20);
title('Annual humidity index','Fontsize',20);
text(0.5,0.87,'(b)','FontName', 'Times New Roman','Fontsize',22,'FontWeight','bold');