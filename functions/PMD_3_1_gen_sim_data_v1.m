%% 1.1 Generate simulation dataset based on idealcurve
clear;clc;close all;
load('idealcurve2.mat')
num_p = 10; % number of points =10;
num_x = 512; % number of Raman Shift;
xtemp = 1:20; ytemp = 0.2-0.001*(xtemp-10).^2;
% figure, plot(xtemp,ytemp)
ran_temp3 = [zeros(93,1);ytemp';zeros(num_x-93-20,1)];
ran_temp6 = [zeros(236,1);3*ytemp';zeros(num_x-236-20,1)];
ran_temp10 = [zeros(388,1);0.4*ytemp';zeros(num_x-388-20,1)];
raneff_temp = [zeros(num_x,2),ran_temp3,zeros(num_x,2),ran_temp6,zeros(num_x,3),ran_temp10];
fixeff = repmat(idealcurve2,1,num_p);
raneff = fixeff.*raneff_temp;
fixraneff = fixeff + raneff;

% figure, subplot(211),mesh(fixraneff)
%         subplot(212),plot(fixraneff)
% figure, plot(raneff)
MU=zeros(512,1);
for i = 1:num_p
SIGMA=diag(fixraneff(:,i).*1+42);
noise(:,i)=mvnrnd(MU,SIGMA,1)';
end
ramany = fixraneff + noise; 


figure
plot(ramany(:,[3,6,10]),'-b'),xlim([0,550]);
        set(gca,'FontSize',16,'FontName','Times New Roman')
        xlabel('Raman Shift Index'),ylabel('Raman Intensity(a.u.)'),hold on,
        plot(ramany(:,[1:2,4:5,7:9]),'-.'),set(gca,'FontSize',14)


figure, subplot(121),mesh(ramany),set(gca,'FontSize',14)
    x1=xlabel('Raman Spectrum Index');
    x2=ylabel('Raman Shift Index');
    ylim([0,550]);
    x3=zlabel('Raman Intensity(a.u.)');
    set(x1,'Rotation',33)
    set(x2,'Rotation',-42)
        subplot(122),plot(ramany(:,[3,6,10]),'-b'),xlim([0,550]);
        set(gca,'FontSize',14)
        xlabel('Raman Shift Index'),ylabel('Raman Intensity(a.u.)'),hold on,
        plot(ramany(:,[1:2,4:5,7:9]),'-.'),set(gca,'FontSize',14)
clc;

mx = repmat(sort(rand(num_p,1)),1,num_x); my = repmat(rand(num_p,1),1,num_x);
% figure, plot(mx,my,'*'), title('Measurement points')
ramanx = repmat(linspace(0,1,num_x)',1,num_p);
S = table; % Create table
S.measurex = reshape(mx',num_p*num_x,[]);  % similated measurement coordinate x
S.measurey = reshape(my',num_p*num_x,[]);  % similated measurement coordinate y
S.ramanx = reshape(ramanx,num_p*num_x,[]); % similated Raman shift
S.ramany = reshape(ramany,num_p*num_x,[]); % similated Raman intensity
% clearvars -except S num_x num_p SIGMA raneff noise
% S = [S.measurex,S.measurey,S.ramanx,S.ramany]