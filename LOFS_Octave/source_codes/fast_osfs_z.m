function   [selected_features,time]=fast_osfs_z(data1,class_index,alpha)


%for continouous data

%input parameter:

%data1: data with all features including the class attribute.
%the class attribute in data matrix has to take consecutive integer values starting from 0 for classification. 
%target: the index of the class attribute (we assume the class attribute is the last colomn of data1)
%alpha: significant level( 0.01 or 0.05 )
%for example: The UCI dataset wdbc with 569 instances and 31 features (the index of the class attribute is 31).

% [selected_features1,time]=fast_osfs_z(wdbc,31,0.01)

%output: 
%selected_features1: the selected features
%time: running time

%please refer to the following papers for the details and cite them:
%Wu, Xindong, Kui Yu, Wei Ding, Hao Wang, and Xingquan Zhu. "Online feature selection with streaming features." Pattern Analysis and Machine Intelligence, IEEE Transactions on 35, no. 5 (2013): 1178-1192.


start=tic;

[n,p]=size(data1);

selected_features=[];
selected_features1=[];
b=[];

 for i=1:p-1%the last feature is the class attribute, i.e., the target)
 
                 
       
     %for very sparse data 
     n1=sum(data1(:,i));
      if n1==0
        continue;
      end
     
               
        stop=0;
        CI=1;
     
        [CI,dep]=my_cond_indep_fisher_z(data1,i,class_index,[],n,alpha);
        
        if CI==1|| isnan(dep)
          continue;
        end
        
         if CI==0
           stop=1;
         end
         
       if stop
           
           if ~isempty(selected_features)
               [CI,dep]=compter_dep_2(selected_features,i,class_index,3, 0, alpha, 'z',data1);
           end
           
           if CI==0 && ~isnan(dep)
                    
               selected_features=[selected_features,i]; %adding i to the set of selected_features
               p2=length(selected_features);
               selected_features1=selected_features;           
                  
               for j=1:p2
 
                  %b=setdiff(selected_features1,selected_features(j), 'stable');
                  b=selected_features1(~sum(bsxfun(@eq,selected_features1',selected_features(j)),2));
             
                  if ~isempty(b)
                     
                    [CI,dep]=optimal_compter_dep_2(b,selected_features(j),class_index,3, 0, alpha, 'z',data1);
                   
                    if CI==1 || isnan(dep)
                        selected_features1=b;  
                    end
                 end

            end
           end
       end
 selected_features=selected_features1; 
 end
time=toc(start);
   
  
    
      