function [CD] = Nemenyitest(Error,alpha)

% Nemenyi test
% post-hoc test, if the Friedman test is rejected (acceptF=false)

[N,k]=size(Error);
% critical values for the two-tailed Nemenyi test, 2-20 classifiers, df=inf
qalphas=[2.5760    2.9133    3.1113    3.2527    3.3658    3.4507    3.5285    3.5921    3.6487    3.6982    3.7406    3.7830    3.8184    3.8537    3.8820    3.9174    3.9386    3.9669    3.9952;
         1.9601    2.3405    2.5668    2.7294    2.8496    2.9486    3.0335    3.1042    3.1608    3.2173    3.2668    3.3093    3.3517    3.3941    3.4295    3.4578    3.4860    3.5143    3.5426;
         1.645     2.052     2.291     2.459     2.589     2.693     2.780     2.855     2.920     NaN       NaN       NaN       NaN       NaN       NaN       NaN        NaN      NaN       NaN];
% qalphas=[1.960,2.343,2.569,2.728,2.850,2.949,3.031,3.102,3.164;
%          1.645,2.052,2.291,2.459,2.589,2.693,2.780,2.855,2.920];
pvals=[0.01;0.05;0.10];
CD=qalphas(pvals==alpha,k-1)*sqrt((k*k+k)/(6*N));

