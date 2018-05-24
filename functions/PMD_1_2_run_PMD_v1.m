%% 1.2 Penalized Mixed Effects Decomposition
onoff = 1; % whether run this part or not
if onoff ==1
    clc;%close all;
    y = S.ramany;% Response
    Y = reshape(y,512,[]);
    xx=1:num_x;
    N =2^9;level = 3;
    W3 = WTortho(N,'Daubechies',18,level); %  

    Wt = W3';
    num_wc = 64;  % num of wavelet coefficients
    W =  Wt(:,1:num_wc);
    Wa =  Wt(:,1:num_wc);   
    weightadd1 = [zeros(80,1);-0.3*ones(40,1);zeros(230,1);-0.3*ones(70,1);zeros(num_x-420,1)];  
    weight=1.0.*ones(512,1)+weightadd1;  % weight can be determined by the detection robustness
    %  weight=1.5.*ones(512,1); 
    Bound_U=sqrt(diag(SIGMA)).*weight;

    PMD_Fix = median(Y,2);
    Y_rmu = Y-repmat(median(Y,2),1,num_p);

    % % When determine gamma, Y should be in-control profiles
    % tic
    % gammabd=[0.001:0.01:10];
    % for ii=1:length(gammabd)
    %     cvscore(ii)=waveletrcv(gammabd(ii),Y,W,Wa,Bound_U,SIGMA,0);
    % end
    % index = find(cvscore==min(cvscore))
    % gammabd(index(1))  % 0.15
    % figure,plot(cvscore)
    % toc
    %
    
    tic
    [PMD_Fix,PMD_Normal,PMD_Defect] = RMEM_yc6(Y,W,Wa,0.15,Bound_U,SIGMA);   
    e = Y-repmat(PMD_Fix,1,size(Y,2))-PMD_Normal-PMD_Defect;
    toc %% Elapsed time is 0.947074 seconds.
    % %  Show results 
     figure, plot(PMD_Normal),hold on, plot(Bound_U)
    % figure, mesh(yhattotal) 
    figure, subplot(121),
       plot(xx,raneff(:,3),'--b',xx,raneff(:,6),'-k',xx,raneff(:,10),'-.r'),
       hold on,axis([0, 530, -20 ,140]);
       legend('3rd profile','6th profile','10th profile')
       set(gca,'FontSize',14),title('Added Defects','fontweight','normal')      
       subplot(122),
        plot(xx,PMD_Defect(:,3),'--b',xx,PMD_Defect(:,6),'-k',xx,PMD_Defect(:,10),'-.r'),
        hold on,axis([0, 530, -20 ,140]);
        plot(xx,PMD_Defect(:,[1:2,4:5,7:9])'), 
            set(gca,'FontSize',14),title('Detected Defects','fontweight','normal')


    figure,subplot(221),plot(PMD_Fix),set(gca,'FontSize',14),         
                           title('Fixed Effects','fontweight','normal') 
           subplot(222),plot(PMD_Normal),set(gca,'FontSize',14),
                           title('Normal Effects','fontweight','normal')
           subplot(223),plot(PMD_Defect),set(gca,'FontSize',14),
                           title('Defective Effects','fontweight','normal')
           subplot(224),plot(e),set(gca,'FontSize',14),
                        title('Signal Dependent Noise','fontweight','normal')

%     figure,subplot(221),hist(reshape(e,5120,[]),40)
%            subplot(222),plot(Y,e,'Xb')
%            subplot(223),qqplot(e(:,1))
%            subplot(224),plot(e(1:511,1),e(2:512,1),'Xb')

    % figure,subplot(221),hist(reshape(noise,5120,[]),40)
    %        subplot(222),plot(Y,noise,'Xb')
    %        subplot(223),qqplot(noise(:,1))
    %        subplot(224),plot(noise(1:511,1),noise(2:512,1),'Xb')

%     figure,subplot(221),qqplot(noise(:,1)), set(gca,'FontSize',14)
%            title('QQ plot of simulated noise','fontweight','normal') 
%            subplot(222),plot(Y,noise,'Xb'),set(gca,'FontSize',14)
%            title('Noise vs Intensity of simulated noise ','fontweight','normal') 
%            subplot(223),qqplot(e(:,1)),set(gca,'FontSize',14)
%            title('QQ plot of estimated noise','fontweight','normal') 
%            subplot(224),plot(Y,e,'Xb') ,set(gca,'FontSize',14)  
%            title('Noise vs Intensity of estimated noise','fontweight','normal') 
 %         
%     figure,subplot(121),plot(noise(:,1)), set(gca,'FontSize',16)
%               axis([0,550,-60,60])
%            title('Simulated noise','fontweight','normal') 
%            subplot(122),plot(e(:,1)), set(gca,'FontSize',16)
%               axis([0,550,-60,60])
%            title('Estimated noise','fontweight','normal')            
           
end