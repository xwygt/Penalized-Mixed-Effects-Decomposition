%% 1.6 Show the results of Simulation
load('result_v1.mat') % load results
close all; clc;
LME_Fix_re=reshape(LME_Fix,512,[]);
LME_ran_re=LME_ran(1:512,:);
LME_Residual=reshape(residuals(lme_matrix1),512,[]);
SSD_residual=Y-a-Yhat;
SSD_a=a;
SSD_smooth=Yhat;
PMD_Fix = mu;
PMD_Normal = yhattotal;
PMD_Defect = atotal;
PMD_Fix_rep=repmat(PMD_Fix,1,10);
%

[linestyles,MarkerEdgeColors,Markers]=generate_line_styles(ny);

figure(1), subplot(121),mesh(Y),set(gca,'FontSize',14)
    x1=xlabel('Raman Spectrum Index');
    x2=ylabel('Raman Shift Index');
    x3=zlabel('Raman Intensity(a.u.)');
    set(x1,'Rotation',33)
    set(x2,'Rotation',-42)
        subplot(122),plot(Y(:,[3,6,10]),'-b'),set(gca,'FontSize',14)
        xlabel('Raman Shift Index'),ylabel('Raman Intensity(a.u.)'),hold on,
        plot(Y(:,[1:2,4:5,7:9]),'-.'),set(gca,'FontSize',14)
%% show result: PMD model

figure(2),hold on
subplot(141),
    for i=1:ny
        plot(PMD_Fix_rep(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end
       xlabel('(g)','FontSize',14),  axis([0,550,0,1800])
%        title('PMD:Fixed Effects','fontweight','normal') 
subplot(142),
   for i=1:ny    
   plot(PMD_Normal(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on
   end         
               xlabel('(h)','FontSize',14);  axis([0,550,-40,40])
%                title('PMD:Normal Random Effects','fontweight','normal')
subplot(143),
   for i=1:ny    
   plot(PMD_Defect(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on
   end          
               xlabel('(i)','FontSize',14);  axis([0,550,-40,80])
%                title('PMD:Defective Random Effects','fontweight','normal')
subplot(144),
   for i=1:ny    
   plot(e(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on
   end        
               xlabel('(j)','FontSize',14);    axis([0,550,-150,150])
%                title('PMD:Noise','fontweight','normal')  

%% show result: Linear Mixed Effects Model based on Spline

figure(3),subplot(131),
    for i=1:ny
        plot(LME_Fix_re(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end
                       title('Fixed Effects','fontweight','normal') 
       subplot(132),%plot(LME_ran(1:512,:)),set(gca,'FontSize',14),
     for i=1:ny
        plot(LME_ran_re(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end   
                       title('Random Effects','fontweight','normal')
       subplot(133),%plot(reshape(residuals(lme_matrix1),512,[])),set(gca,'FontSize',14),
    for i=1:ny
        plot(LME_Residual(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end
                       title('Noise','fontweight','normal')                    
                    
%% show result: SSD by Hao  


% figure(4),subplot(131),plot(Yhat),set(gca,'FontSize',14),         
%                        title('Smooth Part','fontweight','normal') 
%        subplot(132),plot(a),set(gca,'FontSize',14),
%                        title('Sparse Part','fontweight','normal')
%        subplot(133),plot(Y-a-Yhat),set(gca,'FontSize',14),
%                        title('Noise','fontweight','normal')
figure(8),subplot(231),
    for i=1:ny
        plot(LME_Fix_re(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end
    set(gca,'FontSize',16),axis([0,550,0,1800]);
       xlabel('(a)','FontSize',16); title('LMM:Fixed Effects','fontweight','normal') 

       subplot(232),%plot(LME_ran(1:512,:)),
     for i=1:ny
        plot(LME_ran_re(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end   
       set(gca,'FontSize',16),axis([0,550,-40,80])
        xlabel('(b)','FontSize',16);title('LMM:Random Effects','fontweight','normal')
       subplot(233),%plot(reshape(residuals(lme_matrix1),512,[])),
    for i=1:ny
        plot(LME_Residual(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end
      set(gca,'FontSize',16),axis([0,550,-150,150])
      xlabel('(c)','FontSize',16),title('LMM:Noise','fontweight','normal') 
       subplot(234),%plot(Yhat),
     for i=1:ny
        plot(Yhat(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end      
       set(gca,'FontSize',16),axis([0,550,0,1800])      
       xlabel('(d)','FontSize',16);title('SSD:Smooth Part','fontweight','normal') 
                       
       subplot(235),%plot(a),
     for i=1:ny
        plot(a(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end       
       set(gca,'FontSize',16), axis([0,550,-150,250])    
        xlabel('(e)','FontSize',16); title('SSD:Sparse Part','fontweight','normal')
                      
       subplot(236),%plot(Y-a-Yhat),
    for i=1:ny
        plot(SSD_residual(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end  
       set(gca,'FontSize',16),axis([0,550,-150,150])
       xlabel('(f)','FontSize',16);title('SSD:Noise','fontweight','normal') 
                             
 
MSE = [mean(mean(abs(noise))),mean(mean(abs(e))),mean(abs(residuals(lme_matrix1))),mean(mean(abs(Y-a-Yhat)))]

%% show result: Detection rate DR/ false alarm rate FAR/ detected peak intensity difference DPID
% detected defect zone/true defect zone ; false detections)/(all detections)
% detected intensity difference = average ()
DPID_LMM = mean([abs((max(raneff(:,3))-max(LME_ran(90:120,3)))/max(raneff(:,3))),...
     abs((max(raneff(:,6))-max(LME_ran(230:260,6)))/max(raneff(:,6))),...
    abs((max(raneff(:,10))-max(LME_ran(380:420,10)))/max(raneff(:,10)))]) %LMM
DPID_SSD = mean([abs((max(raneff(:,3))-max(a(90:120,3)))/max(raneff(:,3))),...
    abs((max(raneff(:,6))-max(a(230:260,6)))/max(raneff(:,6))),...
    abs((max(raneff(:,10))-max(a(380:420,10)))/max(raneff(:,10)))])
DPID_PMD = mean([abs((max(raneff(:,3))-max(PMD_Defect(90:120,3)))/max(raneff(:,3))),...
    abs((max(raneff(:,6))-max(PMD_Defect(230:260,6)))/max(raneff(:,6))),...
    abs((max(raneff(:,10))-max(PMD_Defect(380:420,10)))/max(raneff(:,10)))])

DR_LMM = nnz([LME_ran_re(94:113,3),LME_ran_re(237:256,6),LME_ran_re(389:408,10)])/...
    nnz([raneff(94:113,3),raneff(237:256,6),raneff(389:408,10)])
DR_SSD = nnz([SSD_a(94:113,3),SSD_a(237:256,6),SSD_a(389:408,10)])/...
    nnz([raneff(94:113,3),raneff(237:256,6),raneff(389:408,10)])
DR_PMD = nnz([PMD_Defect(94:113,3),PMD_Defect(237:256,6),PMD_Defect(389:408,10)])/...
    nnz([raneff(94:113,3),raneff(237:256,6),raneff(389:408,10)])

threshold = 0.1;
LME_ran_re_thr = LME_ran_re;
LME_ran_re_thr(abs(LME_ran_re_thr)<threshold)=0;
SSD_a_thr = SSD_a;
SSD_a_thr(abs(SSD_a_thr)<threshold)=0;
PMD_Defect_thr = PMD_Defect;
PMD_Defect_thr(abs(PMD_Defect_thr)<threshold)=0;

FAR_LMM = (nnz([LME_ran_re_thr(:,[1:2,4:5,7:9])])+nnz(LME_ran_re_thr([1:93,114:512],3))+...
    nnz(LME_ran_re_thr([1:236,257:512],6))+nnz(LME_ran_re_thr([1:388,409:512],10)))/...
    (5120-60-(nnz([raneff(:,[1:2,4:5,7:9])])+nnz(raneff([1:93,114:512],3))+...
    nnz(raneff([1:236,257:512],6))+nnz(raneff([1:388,409:512],10))))
FAR_SSD = (nnz([SSD_a_thr(:,[1:2,4:5,7:9])])+nnz(SSD_a_thr([1:93,114:512],3))+...
    nnz(SSD_a_thr([1:236,257:512],6))+nnz(SSD_a_thr([1:388,409:512],10)))/...
    (5120-60-(nnz([raneff(:,[1:2,4:5,7:9])])+nnz(raneff([1:93,114:512],3))+...
    nnz(raneff([1:236,257:512],6))+nnz(raneff([1:388,409:512],10))))
FAR_PMD = (nnz([PMD_Defect_thr(:,[1:2,4:5,7:9])])+nnz(PMD_Defect_thr([1:93,114:512],3))+...
    nnz(PMD_Defect_thr([1:236,257:512],6))+nnz(PMD_Defect_thr([1:388,409:512],10)))/...
    (5120-60-(nnz([raneff(:,[1:2,4:5,7:9])])+nnz(raneff([1:93,114:512],3))+...
    nnz(raneff([1:236,257:512],6))+nnz(raneff([1:388,409:512],10))))


%% show result: SSD by Hao  


% figure(4),subplot(131),plot(Yhat),set(gca,'FontSize',14),         
%                        title('Smooth Part','fontweight','normal') 
%        subplot(132),plot(a),set(gca,'FontSize',14),
%                        title('Sparse Part','fontweight','normal')
%        subplot(133),plot(Y-a-Yhat),set(gca,'FontSize',14),
%                        title('Noise','fontweight','normal')
figure(9),subplot(251),
    for i=1:ny
        plot(LME_Fix_re(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end
    set(gca,'FontSize',16),axis([0,550,0,1800]);
       xlabel('(a)','FontSize',16); title('LMM: Fixed Effects','fontweight','normal') 

       subplot(252),%plot(LME_ran(1:512,:)),
     for i=1:ny
        plot(LME_ran_re(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end   
       set(gca,'FontSize',16),axis([0,550,-40,80])
        xlabel('(b)','FontSize',16);title('LMM: Random Effects','fontweight','normal')
       subplot(253),%plot(reshape(residuals(lme_matrix1),512,[])),
    for i=1:ny
        plot(LME_Residual(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end
      set(gca,'FontSize',16),axis([0,550,-150,150])
      xlabel('(c)','FontSize',16),title('LMM: Noise','fontweight','normal') 
       subplot(254),%plot(Yhat),
     for i=1:ny
        plot(Yhat(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end      
       set(gca,'FontSize',16),axis([0,550,0,1800])      
       xlabel('(d)','FontSize',16);title('SSD: Smooth Part','fontweight','normal') 
                       
       subplot(255),%plot(a),
     for i=1:ny
        plot(a(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end       
       set(gca,'FontSize',16), axis([0,550,-150,250])    
        xlabel('(e)','FontSize',16); title('SSD: Sparse Part','fontweight','normal')
                      
       subplot(256),%plot(Y-a-Yhat),
    for i=1:ny
        plot(SSD_residual(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end  
       set(gca,'FontSize',16),axis([0,550,-150,150])
       xlabel('(f)','FontSize',16);title('SSD: Noise','fontweight','normal') 
                             
       subplot(257),
    for i=1:ny
        plot(PMD_Fix_rep(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on                  
    end
       xlabel('(g)','FontSize',16),  axis([0,550,0,1800])
       title('PMD: Fixed Effects','fontweight','normal') 
%        title('PMD:Fixed Effects','fontweight','normal') 
       subplot(258),
   for i=1:ny    
   plot(PMD_Normal(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on
   end         
      xlabel('(h)','FontSize',16);  axis([0,550,-40,40])
             title('PMD: Normal Effects','fontweight','normal') 
%                title('PMD:Normal Random Effects','fontweight','normal')
       subplot(259),
   for i=1:ny    
   plot(PMD_Defect(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on
   end          
               xlabel('(i)','FontSize',16);  axis([0,550,-40,80])
                      title('PMD: Defective Effects','fontweight','normal') 
%                title('PMD:Defective Random Effects','fontweight','normal')
       subplot(2,5,10),
   for i=1:ny    
   plot(e(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',16,'FontWeight','bold'),hold on
   end        
               xlabel('(j)','FontSize',16);    axis([0,550,-150,150]) 
       title('PMD: Noise','fontweight','normal') 