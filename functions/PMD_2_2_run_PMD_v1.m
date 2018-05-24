%% 2.2 WPMM Analysis
onoff = 1; % whether run this part or not
if onoff ==1
    close all; clc;

    N =2^9;level = 3;
    W3 = WTortho(N,'Daubechies',18,level); %  

    Wt = W3';
    num_wc = 64;  % num of wavelet coefficients
    W =  Wt(:,1:num_wc);
    Wa =  Wt(:,1:num_wc);   
    
    num_x = 512;
    realraman = cell(20,6);
    weightadd1 = [zeros(70,1);+0.3*ones(60,1);zeros(220,1);+0.3*ones(90,1);zeros(num_x-440,1)];  
    weight=1.5.*ones(512,1)+weightadd1;
    % weight=1.20.*ones(512,1);
    for i=1:10
        realraman{i,1}=rawRaman_SWNT((i*10-9):(i*10),1:2);  % X-Y sample coordinate
        Ytemp = rawRaman_SWNT((i*10-9):(i*10),3:end)';    
        realraman{i,2}=Ytemp;% Raman Spectra 

        PMD_Fix = median(Ytemp,2);
        SIGMA=diag(PMD_Fix.*1+42);
        Bound_U=sqrt(diag(SIGMA)).*weight;
        [PMD_Fix,PMD_Normal,PMD_Defect] = RMEM_yc6(Ytemp,W,Wa,0.15,Bound_U,SIGMA); 
        e = Ytemp-repmat(PMD_Fix,1,size(Ytemp,2))-PMD_Normal-PMD_Defect;
        realraman{i,3}=PMD_Fix;% mu
        Mu_total(1:num_x,i) = PMD_Fix;
        realraman{i,4}=PMD_Normal;% W*Theta
        realraman{i,5}=PMD_Defect;% Wa*Delta
        realraman{i,6}=e;% Noise
        AA_total(1:num_x,i) = max(PMD_Defect')';
        Uniform_total(i) = sum(range(W'*PMD_Normal,2));   
    % Show Results    
    figure(i),subplot(221),plot(Ytemp),set(gca,'FontSize',14) 
              subplot(222),plot(PMD_Normal),set(gca,'FontSize',14)
              subplot(223),plot(PMD_Defect),set(gca,'FontSize',14)
                xlabel('Raman Shift Index'),ylabel('Raman Intensity(a.u.)')
              subplot(224),plot(e),set(gca,'FontSize',14)
    end 

    % Show results
%     Muw = W'*Mu_total;
%   figure,subplot(121), plot(Mu_total)
%          subplot(122), plot(max(Mu_total))

%     figure, plot(AA_total)
%     figure, mesh(AA_total)

end