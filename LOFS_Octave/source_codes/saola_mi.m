function [current_feature,time] = saola_mi(data,threshold)

%input
%Performs the SAOLA algorithm using mutual information measure by Yu 2014.
%data: columns denote features (attributes), while rows represent data
%instances. if data is the sparse format, please using full(data)
%the last column of a data set is the class attribute

%output
%current_feature: selected features
%time: running time



start=tic;

numFeatures = size(data,2);

class_a=numFeatures;%the index of the class attribute

current_feature=[];

dep=sparse(1,numFeatures-1);

for i = 1:numFeatures-1
       
   %for very sparse data
    n1=sum(data(:,i));
    if n1==0
        continue;
     end

    
    
    [dep(i)] = SU(data(:,i),data(:,class_a));
    
    if dep(i)<=threshold
        continue;
    end
    
       current_feature=[current_feature, i];     
         
       %current_feature1=setdiff(current_feature,i,'stable');
       current_feature1=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
       
       if ~isempty(current_feature1)
                
        p=length(current_feature1);
              
        for j=1:p
           
                [dep_ij] = SU(data(:,i),data(:,current_feature1(j)));
                                   
                if dep_ij<=threshold
                     continue;
                 end
                 
                 max_dep=dep_ij;
                 max_feature=current_feature1(j);
                 
                 if dep(max_feature)>dep(i) && max_dep>dep(i)
                          
                        %current_feature=setdiff(current_feature,i, 'stable');
                        current_feature=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
                        break;
                 end   
                  
                 if dep(i)>dep(max_feature) && max_dep>dep(max_feature)
                 
                        %current_feature=setdiff(current_feature,max_feature, 'stable');
                       current_feature=current_feature(~sum(bsxfun(@eq,current_feature',max_feature),2));
                end  
               
         end
    
    end
end

time=toc(start);


  
