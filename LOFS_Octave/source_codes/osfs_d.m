function   [selected_features, time]=osfs_d(data1,class_index,alpha,test)
% for discrete data

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
        
     [CI] = my_cond_indep_chisquare(data1,i, class_index, [], test, alpha, ns);
      
      if CI==0
          stop=1;
          selected_features=[selected_features,i];
      end
         
      if stop
          
          p2=length(selected_features);
          selected_features1=selected_features;
          
           for j=1:p2
               
              %b=setdiff(selected_features1, selected_features(j),'stable');
               b=selected_features1(~sum(bsxfun(@eq,selected_features1',selected_features(j)),2));

                if ~isempty(b)
                  [CI]=compter_dep_2(b,selected_features(j),class_index,3, 1, alpha, test,data1);
      
                   if CI==1
                      selected_features1=b;
                   end
              end
          end
     end   
   selected_features=selected_features1;
 end
 
  time=toc(start);
  
    
      