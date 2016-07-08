
%load data
load('data.mat');
%set parameters
[n,p]=size(data);
class_index=p;%the index of the class attribute
alpha=0.01;%alpha is the significant level, and can be set to 0.01 or 0.05
test='g2';%test can be set to 'chi2' or 'g2'
%learning module
%example 1 for Fast-OSFS for discrete data
[selectedFeatures,time]=fast_osfs_d(data,class_index,alpha,test);
%example 2 for Fast-OSFS for continuous data
[selectedFeatures,time]=fast_osfs_z(data,class_index,alpha);
%evaluation module
load('testdata.mat');%load test data
%use KNN clasifier (k=3)
test_class = knnclassify(testdata(:,selectedFeatures),data(:,selectedFeatures),data(:,class_index),3);
%calculate AUC, prediction accuracy, and kappa
[X,Y,T,AUC] = perfcurve(testdata(:,class_index),test_class,1);
accuracy=length(find(testdata(:,class_index) == test_class))/length(test_class);
kappa = kappa_assess(class_label(test_indices),test_class,'class');
%Statistical comparison of two methods on multiple data sets
%error can be set to AUC or prediction accuracy, or prediction errors, etc.
%alpha is the significant level (0.01 or 0.05)
[F,pvalF,acceptF,rankCl]=FriedmanTest(error,alpha);
%if acceptF=false, then run the Nemenyi test
[CD] = Nemenyitest(error,alpha);%CD denotes critical values