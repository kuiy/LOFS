function [F,pvalF,acceptF,rankCl]=FriedmanTest(Error,alpha)
% Friedman test for comparing multiple classifiers over multiple data sets
% Error: matrix, Acc_ij is the error rate of classifier j over the ith data
% alpha: the first type error
% Yifeng Li
% October 24, 2012
% get ranks
[N,k]=size(Error);
rank=zeros(N,k);
for i=1:N
   rank(i,:)=getRank(Error(i,:)); 
end
rankCl=mean(rank,1);
CD=[];
% Friedman test
xi2=(12*N)/(k*k+k) * (sum(rankCl.*rankCl) - (k*(k+1)*(k+1))/4  );
F=((N-1)*xi2)/(N*(k-1) - xi2);
pvalF=fpdf(F,k-1,(k-1)*(N-1));

if pvalF>alpha
   acceptF=true;
   return;
end


