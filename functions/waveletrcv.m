function [ CVscore ] = waveletrcv( gamma,Y,W,Wa,Bound_U,SIGMA,nmiss )
% Estimate Cross-validation value
deltaj = zeros(size(Wa,2),1);
Lbs = 2*norm(Wa)^2/min(diag(SIGMA));
X = zeros(size(Wa,2),1);

mu = median(Y,2);
Y_rmu = Y-repmat(median(Y,2),1,size(Y,2));

for ii = 1: size(Y,2)
    Y_rmuj = Y_rmu(:,ii);
    
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

       theta_temp = W'*(Y_rmuj-a); 
       theta = (theta_temp>=-W'*Bound_U).*(theta_temp<=W'*Bound_U).*theta_temp+...
       (theta_temp<-W'*Bound_U).*(-W'*Bound_U)+(theta_temp>W'*Bound_U).*(W'*Bound_U);
       yhat = W*theta;
        deltajtemp = X + 2/Lbs*Wa'*inv(SIGMA)*(Y_rmuj -Wa*X - yhat);
  

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
atotal(:,ii)=a;
yhattotal(:,ii)=yhat;
end

for ii = 1: size(Y,2)
    Y_rmuj = Y_rmu(:,ii);
    atemp = atotal;yhattemp = yhattotal;
    atemp(:,ii)=[];yhattemp(:,ii)=[];
   ecv(:,ii)=Y_rmuj-mean(atemp,2)-mean(yhat,2);
 %     ecv(:,ii)=median(Y_rmu,2)-mean(atemp,2)-mean(yhat,2);
end


RSS = sum(sum((ecv).^2));
n = numel(ecv);
CVscore = RSS/(n-nmiss);

end