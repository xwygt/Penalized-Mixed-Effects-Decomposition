%% 2.1 introduce real data
clc;clear;close all;
load('ZZ.mat') % Raman Spectra
load('XY.mat') % meansurement point coordinates
% load('XYZ.mat')
ZZn = ZZ(:,200:711);
% figure
% plot(ZZn')
j1=1;j2=1;
for i=1:2926
    if ZZn(i,250)>205
        i_mark1(j1)=i;
        j1=j1+1;
    end
    if (ZZn(i,305)>720)||(ZZn(i,315)>720)||(ZZn(i,316)>720)||(ZZn(i,402)>800)
        i_mark2(j2)=i;
        j2=j2+1;
    end   
end
xypick=[];
for i=[1:10]
    temp=(133*i-133+40):(133*i-133+49);
   xypick=[xypick,temp];
%    figure(i)
%    plot(ZZn(temp,:)')
end

figure
% plot(XY(:,1),XY(:,2),'.'),hold on % rectangle
% % plot(XY(i_mark1,1),XY(i_mark1,2),'ro'),hold on 
% plot(XY(i_mark2,1),XY(i_mark2,2),'b*'),hold on 
 plot(XY(xypick,1),XY(xypick,2),'xb'),set(gca,'FontSize',14),hold on 
 xlabel('X axis coordinate(um)'), ylabel('Y axis coordinate(um)')
 xy_OC=[173,174,446,447,1245];
  plot(XY(xy_OC,1),XY(xy_OC,2),'or','MarkerEdgeColor','r','MarkerFaceColor','r') 
 axis([-90,45,41,56])
% figure(24)
% plot(ZZn(i_mark2,:)'),hold on 
% plot(XY(i_mark2,1),XY(i_mark2,2),'b*')

rawRaman_SWNT = [XY(xypick,:),fliplr(ZZn(xypick,:))];
