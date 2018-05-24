function [mu,normeff,defeff] = RMEM_yc6(Y,W,Wa,gamma,Bound_U,SIGMA,maxIter,errtol)
%% Coding for PMD  
%
%   Parameters:
%       -----------------
%       Y      :    Signal to be decomposed
%       W      :    Basis for normal effects
%       Wa     :    Basis for defective effects
%       gamma  :    Penalized Parameter
%       Bound_U  :  The bound for normal effects
%       SIGMA  :    Known covariance matrix (can be obtained from the phase-I data analysis)
%       maxIter  :  Maximum iteration number
%       errtol  :   error tolerance
%       -----------------
%  Output:
%       -----------------
%       mu          :    fixed effects
%       normeff     :    normal effects
%       defeff      :    defective effects
%  Note: the code is developed based on the framework in the SSD code
%
%% Test & prepare the variables
%---
plus0 = @(x) (x>0).*x;

% default parameters setup
if nargin<8
    errtol = 1e-6;
    if nargin<7
        maxIter = 30;
    end
end

isAutoGamma = isempty(gamma);
[num_x,num_p] = size(Y);
num_wc = size(W,2);

   mu = median(Y,2);
   Y_rmu = Y-repmat(median(Y,2),1,num_p);
  
if numel(gamma) == 1
    gamma = ones(num_wc,1)*gamma;
end
  




   for j = 1:num_p
% initialization   
deltaj = zeros(size(Wa,2),1);
Lbs = 2*norm(Wa)^2/min(diag(SIGMA));
X = zeros(size(Wa,2),1);

a = Wa*deltaj;  % mean the defect part
iIter = 0;
errtol = 1e-6;
maxIter = 20;
SChange = 1e10;
t = 1;


while SChange > errtol && iIter < maxIter
    
    iIter = iIter + 1;
    Sold = a;
    deltajold = deltaj;
    told = t;

    %

       theta_temp = W'*(Y_rmu(:,j)-a); 
       theta = (theta_temp>=-W'*Bound_U).*(theta_temp<=W'*Bound_U).*theta_temp+...
       (theta_temp<-W'*Bound_U).*(-W'*Bound_U)+(theta_temp>W'*Bound_U).*(W'*Bound_U);
       yhat = W*theta;
        deltajtemp = X + 2/Lbs*Wa'*inv(SIGMA)*(Y_rmu(:,j) -Wa*X - yhat);
  

%    deltaj = wthreshv(deltajtemp,'h',gamma); % change 'h' to 's' for softthresholding   
%     BetaA = wthresh(BetaSe,'h',gamma/Lbs); % change 'h' to 's' for softthresholding
     deltaj = wthresh(deltajtemp,'h',gamma/Lbs); 
        a = Wa*deltaj;

    t = (1+sqrt(1+4*told^2))/2;
    if iIter==1
        X = deltaj;
    else
        X = deltaj+(told-1)/t*(deltaj-deltajold);
    end
    SChange = sum(sum(sum((a - Sold).^2)));
    
end
normeff(:,j)=yhat;
defeff(:,j)=a;
   end
end



