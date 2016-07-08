function auc = auc(Turelabel,Predictedlabel)
% auc = scoreAUC(Turelabel,Predictedlabel)
%
% Calculates the area under the ROC for a given set
% of Predictedlabel predictions and labels.  Currently limited to two classes.
%
% Predictedlabel: n*1 matrix of Predictedlabel probabilities for class 1
% Turelabel: n*1 matrix of categories {0,1}
% auc: Area under the curve
%
% Author: Ben Hamner (ben@benhamner.com)
%
% Algorithm found in
% A  Simple Generalisation of the Area Under the ROC
% Curve for Multiple Class Classification Problems
% David Hand and Robert Till
% http://www.springerlink.com/content/nn141j42838n7u21/fulltext.pdf

r = myrank(Predictedlabel);
    
auc = (sum(r(Turelabel==1)) - sum(Turelabel==1)*(sum(Turelabel==1)+1)/2) / ...
    ( sum(Turelabel<1)*sum(Turelabel==1));

function r = myrank(x)

[~,I] = sort(x);

r = 0*x;
cur_val = x(I(1));
last_pos = 1;

for i=1:length(I)
    if cur_val ~= x(I(i))
        r(I(last_pos:i-1)) = (last_pos+i-1)/2;
        last_pos = i;
        cur_val = x(I(i));
    end
    if i==length(I)
        r(I(last_pos:i)) = (last_pos+i)/2;
    end
end

