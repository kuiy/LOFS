

function [current_feature,time] = saola_z_test(data,alpha)

%input
%Performs the SAOLA algorithm using mutual information measure by Yu 2014.
%data: columns denote features (attributes), while rows represent data instances.
%the last column of a data set is the class attribute

%output
%current_feature: selected features
%time: running time

start_time=tic;
[n,numFeatures] = size(data);

class_a=numFeatures;%the index of the class attribute

current_feature=[];
dep=sparse(1,numFeatures-1);

CI=1;


for i = 1:numFeatures-1
    
    
    %for very sparse data 
     n1=sum(data(:,i));
     if n1==0
        continue;
     end
     
      
    
    [CI,dep(i)] = my_cond_indep_fisher_z(data,i, class_a, [],n,alpha);
    
    
    if CI==1 || isnan(dep(i))
        continue;
    end
    
       current_feature=[current_feature, i];
             
       %current_feature1=setdiff(current_feature,i,'stable');
        current_feature1=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
       
    if ~isempty(current_feature1)
                
          p=length(current_feature1);
              
          for j=1:p
          
                             
                 [CI, dep_ij] = my_cond_indep_fisher_z(data,i, current_feature1(j), [],n,alpha);
                                                                    
                  if CI==1|| isnan(dep_ij)
                     continue;
                  end
                  
                  t_dep=dep_ij;
                  t_feature=current_feature1(j);
                  
                   if dep(t_feature)>=dep(i) && t_dep>dep(i)
                     
                           %current_feature=setdiff(current_feature,i, 'stable');
                           current_feature=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
                           break;
                  end
                         
                  if dep(i)>dep(t_feature) && t_dep>dep(t_feature)
                 
                       current_feature=current_feature(~sum(bsxfun(@eq,current_feature',t_feature),2));
                       
                  end             
          end        
   end
    
end

time=toc(start_time);


  
