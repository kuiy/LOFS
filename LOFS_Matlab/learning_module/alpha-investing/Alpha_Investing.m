
% Below is the main streamwise feature selection (SFS) code. It uses two helper functions, Linear_Regression and Prediction_Error 
% the main function, Alpha_Investing 

 function [f,time] =Alpha_Investing(X, y)
 % configure parameters (I never change these)
 start=tic;
   wealth = 0.5;
   delta_alpha = 0.5;
 % n observations; p features
   [n,p] = size(X);
 % initially add constant term into the model
   model = [1, zeros(1,p-1)];
   error = Prediction_Error(X(:,model==1), y, Linear_Regression(X(:,model==1), y));
 for i=2:p
     
     %if mod(i,1000)==0
         %i
    %end
     
   alpha = wealth/(2*i);
   %i
   %compute p_value
   %method one: derive delta(loglikelihood) from L2 error
   model(i) = 1;
   error_new = Prediction_Error(X(:,model==1), y, Linear_Regression(X(:,model==1), y));
   sigma2 = error/n;
   p_value = exp((error_new-error)/(2*sigma2));
   
   %method two: derive delta(loglikelihood) from t-statistic
   %model(i) = 1;
   %w = Linear_Regression(X(:,model==1), y);
   %sigma2 = Prediction_Error(X(:,model==1), y, w)/n;
   %EX = mean(X(:,model==1));
   %w_new_std = w(end)/sqrt(sigma2/(sum(sum((X(:,model==1)-ones(n,1)*EX).^2, 2))));
   %p_value = 2*(1-normcdf(abs(w_new_std), 0, 1));
   
   if p_value < alpha %feature i is accepted
       model(i) = 1;
       error = error_new;
       wealth = wealth + delta_alpha - alpha;
   else %feature i is discarded
       model(i) = 0;
       wealth = wealth - alpha;
   end
 end
 % train final model
  w = zeros(p,1);
  w(model==1,1) = Linear_Regression(X(:,model==1), y);
  
  time=toc(start);
  f=find(model);
  % Linear_Regression 
function [w] = Linear_Regression(X, y)
   % this is not the most efficient way to find w!
  w = inv(X'*X)*X'*y;
   %w=regress(y,X);
   
  % Prediction_Error 
  function [error] = Prediction_Error(X, y, w)
     yhat = X*w;
     error = sum((y-yhat).^2);
