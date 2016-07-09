
%load data
load('spect.mat');
%set training and testing data
traindata=spect(1:500,:);
testdata=spect(501:end,:);
%set parameters
[n,p]=size(traindata);
%set the index of the class attribute
class_index=p;
%alpha is the significant level and set to 0.01
alpha=0.01;
%using the G2 test
test='g2';
%learning module
%example of Fast-OSFS for discrete data
[selectedFeatures,time]=fast_osfs_d(traindata,class_index,alpha,test);
%use KNN clasifier (k=3)
%test_class denotes the predicted class labels
test_class = knnclassify(testdata(:,selectedFeatures),traindata(:,selectedFeatures),traindata(:,class_index),3);
%calculate AUC, prediction accuracy, and kappa
[X,Y,T,AUC] = perfcurve(testdata(:,class_index),test_class,1);
accuracy=length(find(testdata(:,class_index) == test_class))/length(test_class);
kappa = kappa_assess(testdata(:,class_index),test_class,'class');