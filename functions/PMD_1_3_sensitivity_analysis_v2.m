%% 1.1 Sensitivity Analysis
    weight1=0.5.*ones(512,1); 
    Bound_U1=sqrt(diag(SIGMA)).*weight1;
    weight2=0.9.*ones(512,1); 
    Bound_U2=sqrt(diag(SIGMA)).*weight2;
    weight3=1.3.*ones(512,1); 
    Bound_U3=sqrt(diag(SIGMA)).*weight3;
    weight4=1.7.*ones(512,1); 
    Bound_U4=sqrt(diag(SIGMA)).*weight4;
    weight5=2.0.*ones(512,1); 
    Bound_U5=sqrt(diag(SIGMA)).*weight5;    
    
    PMD_Fix = median(Y,2);
    Y_rmu = Y-repmat(median(Y,2),1,num_p);

    tic
    [PMD_Fix,PMD_Normal,atotal1] = RMEM_yc6(Y,W,Wa,0.15,Bound_U1,SIGMA); 
    [PMD_Fix,PMD_Normal,atotal2] = RMEM_yc6(Y,W,Wa,0.15,Bound_U2,SIGMA);   
    [PMD_Fix,PMD_Normal,atotal3] = RMEM_yc6(Y,W,Wa,0.15,Bound_U3,SIGMA);  
    [PMD_Fix,PMD_Normal,atotal4] = RMEM_yc6(Y,W,Wa,0.15,Bound_U4,SIGMA); 
    [PMD_Fix,PMD_Normal,atotal5] = RMEM_yc6(Y,W,Wa,0.15,Bound_U5,SIGMA);   

%     e = Y-repmat(mu,1,size(Y,2))-yhattotal-atotal1;
    toc %% Elapsed time is 0.947074 seconds.
%% 1.2 show results
    figure,subplot(231),
           plot(xx,raneff(:,3),'--b',xx,raneff(:,6),'-k',xx,raneff(:,10),'-.r'),
           hold on,axis([0, 530, -20 ,140]);
           legend('3rd profile','6th profile','10th profile')
           xlabel('(a)','FontSize',14)
           set(gca,'FontSize',14),title('Real Defects','fontweight','normal')      
       subplot(232),
        plot(xx,atotal1(:,3),'--b',xx,atotal1(:,6),'-k',xx,atotal1(:,10),'-.r'),
        hold on,axis([0, 530, -20 ,140]);
        plot(xx,atotal1(:,[1:2,4:5,7:9])'),xlabel('(b)','FontSize',14)
            set(gca,'FontSize',14),title('Detected Defects (w=0.5)','fontweight','normal')
       subplot(233),
        plot(xx,atotal2(:,3),'--b',xx,atotal2(:,6),'-k',xx,atotal2(:,10),'-.r'),
        hold on,axis([0, 530, -20 ,140]);
        plot(xx,atotal2(:,[1:2,4:5,7:9])'), xlabel('(c)','FontSize',14)
            set(gca,'FontSize',14),title('Detected Defects (w=0.9)','fontweight','normal')
       subplot(234),
        plot(xx,atotal3(:,3),'--b',xx,atotal3(:,6),'-k',xx,atotal3(:,10),'-.r'),
        hold on,axis([0, 530, -20 ,140]);
        plot(xx,atotal3(:,[1:2,4:5,7:9])'), xlabel('(d)','FontSize',14)
            set(gca,'FontSize',14),title('Detected Defects (w=1.3)','fontweight','normal')
       subplot(235),
        plot(xx,atotal4(:,3),'--b',xx,atotal4(:,6),'-k',xx,atotal4(:,10),'-.r'),
        hold on,axis([0, 530, -20 ,140]);
        plot(xx,atotal4(:,[1:2,4:5,7:9])'), xlabel('(e)','FontSize',14)
            set(gca,'FontSize',14),title('Detected Defects (w=1.7)','fontweight','normal')
       subplot(236),
        plot(xx,atotal5(:,3),'--b',xx,atotal5(:,6),'-k',xx,atotal5(:,10),'-.r'),
        hold on,axis([0, 530, -20 ,140]);
        plot(xx,atotal5(:,[1:2,4:5,7:9])'), xlabel('(f)','FontSize',14)
            set(gca,'FontSize',14),title('Detected Defects (w=2.0)','fontweight','normal')

%% 1.3 sensitivity analysis for the bounds
weightset=0.3:0.1:2.0
for iw=1:length(weightset)
    iw
  weight1=weightset(iw).*ones(512,1); 
    Bound_U1=sqrt(diag(SIGMA)).*weight1;
     [PMD_Fix,PMD_Normal,PMD_Defect] = RMEM_yc6(Y,W,Wa,0.15,Bound_U1,SIGMA); 
  DIR3total(iw)=mean([abs((max(raneff(:,3))-max(PMD_Defect(90:120,3)))/max(raneff(:,3))),...
    abs((max(raneff(:,6))-max(PMD_Defect(230:260,6)))/max(raneff(:,6))),...
    abs((max(raneff(:,10))-max(PMD_Defect(380:420,10)))/max(raneff(:,10)))]);
  DR_total(iw) = nnz([PMD_Defect(94:113,3),PMD_Defect(237:256,6),PMD_Defect(389:408,10)])/...
    nnz([raneff(94:113,3),raneff(237:256,6),raneff(389:408,10)]);
threshold = 0.1;
PMD_Defect_thr = PMD_Defect;
PMD_Defect_thr(abs(PMD_Defect_thr)<threshold)=0;
FAR_total(iw) = (nnz([PMD_Defect_thr(:,[1:2,4:5,7:9])])+nnz(PMD_Defect_thr([1:93,114:512],3))+...
    nnz(PMD_Defect_thr([1:236,257:512],6))+nnz(PMD_Defect_thr([1:388,409:512],10)))/...
    (5120-60-(nnz([raneff(:,[1:2,4:5,7:9])])+nnz(raneff([1:93,114:512],3))+...
    nnz(raneff([1:236,257:512],6))+nnz(raneff([1:388,409:512],10))));

end            
 %% 1.4 Show figures
figure,plot(weightset,DIR3total,'-ob',weightset,DR_total,'-.*k',weightset,FAR_total,'--^r')
legend('DPID','DR','FAR')
axis([0.2, 2.5, 0 ,1.1]);
% Convert y-axis values to percentage values by multiplication
     a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
% Create a vector of '%' signs
     pct = char(ones(size(a,1),1)*'%'); 
% Append the '%' signs after the percentage values
     new_yticks = [char(a),pct];
% 'Reflect the changes on the plot
     set(gca,'yticklabel',new_yticks) 
 xlabel('Weight parameter w','FontSize',14)
 set(gca,'FontSize',14)
 
 
 %% 2.1 sensitivity analysis for the gamma
weightset = 1;
weight1=weightset.*ones(512,1); 
Bound_U1=sqrt(diag(SIGMA)).*weight1;
gamma = 0.1:0.05:1;

for ig=1:length(gamma)
  ig
  [PMD_Fix,PMD_Normal,PMD_Defect] = RMEM_yc6(Y,W,Wa,gamma(ig),Bound_U1,SIGMA);
     
  DIR3total2(ig)=mean([abs((max(raneff(:,3))-max(PMD_Defect(90:120,3)))/max(raneff(:,3))),...
    abs((max(raneff(:,6))-max(PMD_Defect(230:260,6)))/max(raneff(:,6))),...
    abs((max(raneff(:,10))-max(PMD_Defect(380:420,10)))/max(raneff(:,10)))]);
  DR_total2(ig) = nnz([PMD_Defect(94:113,3),PMD_Defect(237:256,6),PMD_Defect(389:408,10)])/...
    nnz([raneff(94:113,3),raneff(237:256,6),raneff(389:408,10)]);
threshold = 0.1;
PMD_Defect_thr = PMD_Defect;
PMD_Defect_thr(abs(PMD_Defect_thr)<threshold)=0;
FAR_total2(ig) = (nnz([PMD_Defect_thr(:,[1:2,4:5,7:9])])+nnz(PMD_Defect_thr([1:93,114:512],3))+...
    nnz(PMD_Defect_thr([1:236,257:512],6))+nnz(PMD_Defect_thr([1:388,409:512],10)))/...
    (5120-60-(nnz([raneff(:,[1:2,4:5,7:9])])+nnz(raneff([1:93,114:512],3))+...
    nnz(raneff([1:236,257:512],6))+nnz(raneff([1:388,409:512],10))));

end            
 %% 2.2 Show figures
figure,plot(gamma,DIR3total2,'-ob',gamma,DR_total2,'-.*k',gamma,FAR_total2,'--^r')
legend('DPID','DR','FAR')
set(gca,'FontSize',14)
axis([0, 1.1, 0 ,1.1]);
% Convert y-axis values to percentage values by multiplication
     a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
% Create a vector of '%' signs
     pct = char(ones(size(a,1),1)*'%'); 
% Append the '%' signs after the percentage values
     new_yticks = [char(a),pct];
% 'Reflect the changes on the plot
     set(gca,'yticklabel',new_yticks) 
 xlabel('Gamma','FontSize',14)

 
 