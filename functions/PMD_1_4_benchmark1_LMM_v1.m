%% 1.4 Benchmark 1: Linear Mixed Effects Model (LMM) based on Spline

onoff = 1; % whether run this part or not
if onoff ==1
    clc;close all;
    y = S.ramany;% Response (Dependent Variable)
    y_re=reshape(y,[512,num_p]);
    y_median=median(y_re,2);
    figure,plot(y_re),hold on
           plot(y_median,'-k')
    X = [ones(height(S),1), repmat(y_median,num_p,1)];% Fixed Effects Design Matrix
    % X = [ones(height(S),1), S.ramanx];% Fixed Effects Design Matrix
    k = linspace(0.05,0.95,100);  
    Z = zeros(height(S),length(k));% Random Effects Design Matrix
    for j = 1:length(k)
          Z(:,j) = max(X(:,2) - k(j),0);
    end
    G = S.measurex;% Grouping Variable
    % The random-effects design matrix can optionally include the dummy coded
    % variable for the group. If however group 'G' is provided, fitlmematrix
    % automatically does this for you.
    % Fit the model
    tic
    %lme_matrix1 = fitlmematrix(X,y,Z,G,'CovariancePattern','Isotropic');
    % lme_matrix1 = fitlmematrix(X,y,Z,[],'CovariancePattern','Isotropic');
    lme_matrix1 = fitlmematrix(X,y,Z,G,'CovariancePattern','Diagonal');
        % % % Elapsed time is 3914.090503 seconds. for "Diagonal"
    toc %% Elapsed time is 1203.272962 seconds.

    Fw = fitted(lme_matrix1);
    % Show the plots
    figure,gscatter(S.ramanx,S.ramany,S.measurex,[],'.');
    figure, gscatter(S.ramanx,Fw,S.measurex,[],'.');
    figure, gplotmatrix(S.ramanx,Fw,S.measurex)

    figure % plot the residuals
          subplot(221), plotResiduals(lme_matrix1)
          subplot(222), plotResiduals(lme_matrix1,'fitted')
          subplot(223), plotResiduals(lme_matrix1,'probability')
          subplot(224), plotResiduals(lme_matrix1,'lagged')

    % Fw1 = fitted(lme_matrix1,'Conditional',false); 
    % output details
       %%http://www.mathworks.com/help/stats/mixed-effects-1.html?searchHighlight=fitlmematrix
%     disp(lme_matrix1)
%     lme_matrix1
    [betaw,betanames,stats] = fixedEffects(lme_matrix1);
    [Bw,Bnames,stats] = randomEffects(lme_matrix1);
    Bw_re=reshape(Bw,[100,num_p]);
    LME_Fix = X*betaw;
    LME_ran = Z*Bw_re;

% 
%     X*betaw;
%     figure, gscatter(S.ramanx,X*betaw,S.measurex,[],'.');  
%     figure, gscatter(S.ramanx,Z*Bw_re,S.measurex,[],'.');  
%     fix_part=X*betaw;
%     random_part=Z*Bw_re;
%     figure,plot(fix_part(1:512,:))
%     figure,plot(random_part(1:512,:))
%     figure,plot(Bw_re)
% 
%     designMatrix(lme_matrix1);
%     stats = anova(lme_matrix1);
%     [psi,mse,stats] = covarianceParameters(lme_matrix1);
%     Rw = residuals(lme_matrix1);
%     Rw_re=reshape(Rw,[num_x,num_p]);
%     figure,plot(Rw_re)
%     psi_diag=diag(psi{1,1});
end