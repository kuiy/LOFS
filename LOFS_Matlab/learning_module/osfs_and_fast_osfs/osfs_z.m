function   [selected_features, time]=osfs_z(data1,class_index,alpha)
% for continue value

[n,p]=size(data1);
ns=max(data1);
selected_features=[];
selected_features1=[];
b=[];


start=tic;

 for i=1:p-1
     
      
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
          selected_features=[selected_features,i];
      end
         
      if stop
          
          p2=length(selected_features);
          selected_features1=selected_features;
          
           for j=1:p2
               
              b=setdiff(selected_features1, selected_features(j),'stable');
               
               if ~isempty(b)
                  [CI,dep]=compter_dep_2(b,selected_features(j),class_index,3, 0, alpha, 'z',data1);

      
                   if CI==1 || isnan(dep)
                      selected_features1=b;
                   end
              end
          end
     end   
   selected_features=selected_features1;
 end
 
  time=toc(start);
  
    
      