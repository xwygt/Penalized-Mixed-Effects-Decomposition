%% 2.3 show results
i=2;  Ytemp1 = rawRaman_SWNT((i*10-9):(i*10),3:end)';    
      [PMD_Fix,PMD_Normal,atotal1] = RMEM_yc6(Ytemp1,W,Wa,0.15,Bound_U,SIGMA); 
i=4;  Ytemp2 = rawRaman_SWNT((i*10-9):(i*10),3:end)';    
      [PMD_Fix,PMD_Normal,atotal2] = RMEM_yc6(Ytemp2,W,Wa,0.15,Bound_U,SIGMA); 
i=10;  Ytemp3 = rawRaman_SWNT((i*10-9):(i*10),3:end)';    
      [PMD_Fix,PMD_Normal,atotal3] = RMEM_yc6(Ytemp3,W,Wa,0.15,Bound_U,SIGMA);
i=6;  Ytemp4 = rawRaman_SWNT((i*10-9):(i*10),3:end)';    
      [PMD_Fix,PMD_Normal,atotal4] = RMEM_yc6(Ytemp4,W,Wa,0.15,Bound_U,SIGMA);      
figure,subplot(241),%plot(Ytemp1),
ny = 10;
[linestyles,MarkerEdgeColors,Markers]=generate_line_styles(ny);
    for i=1:ny
        plot(Ytemp1(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end  
set(gca,'FontSize',14),xlim([0,550]),title('Raman:2nd Sample group','fontweight','normal') 
          subplot(242),%plot(Ytemp2),
    for i=1:ny
        plot(Ytemp2(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end            
          set(gca,'FontSize',14),xlim([0,550]),title('Raman:4th Sample group','fontweight','normal') 
          subplot(243),%plot(Ytemp3),
    for i=1:ny
        plot(Ytemp3(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end            
          set(gca,'FontSize',14),xlim([0,550]),title('Raman:10th Sample group','fontweight','normal') 
          subplot(244),%plot(Ytemp4),
    for i=1:ny
        plot(Ytemp4(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end            
          set(gca,'FontSize',14),xlim([0,550]),title('Raman:6th Sample group','fontweight','normal')           
          subplot(245),%plot(atotal1),
     for i=1:ny
        plot(atotal1(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end           
          set(gca,'FontSize',14),xlim([0,550]),title('Defects:2nd Sample group','fontweight','normal')       
          subplot(246),%plot(atotal2),
    for i=1:ny
        plot(atotal2(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end            
          set(gca,'FontSize',14),xlim([0,550]),title('Defects:4th Sample group','fontweight','normal')       
          subplot(247),%plot(atotal3),
    for i=1:ny
        plot(atotal3(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end            
          set(gca,'FontSize',14),xlim([0,550]),title('Defects:10th Sample group','fontweight','normal')       
          subplot(248),%plot(atotal4),
    for i=1:ny
        plot(atotal4(:,i),[linestyles{i} Markers{i}],'LineWidth',1.5,'Color',MarkerEdgeColors(i,:)),set(gca,'FontSize',14),hold on                  
    end            
          set(gca,'FontSize',14),xlim([0,550]),title('Defects:6th Sample group','fontweight','normal')       
       
    figure, mesh(Mu_total),set(gca,'FontSize',14)
    x1=xlabel('Raman Sample Group');
    x2=ylabel('Raman Shift Index');
    x3=zlabel('Separated Fixed Effects(a.u.)');
    set(x1,'Rotation',20)
    set(x2,'Rotation',-30)      
    