function   [selected_features,time]=fast_osfs_d(data1,class_index,alpha,test)


%for disccrete data


%important note:
%for discrete dataset: the feature values of X must be from 1 to max_value(X), for example,feature X has to take consecutive integer values starting from 1,
%that is, 1..max_value(X). For example, if max_value(X)=3, this means that feature X takes values {1,2,3}.


%input parameter:

%data1: data with all features including the class attribute
%target: the index of the class attribute ( we assume the class attribute is the last colomn of a data set)
%alpha: significant level( 0.01 or 0.05 )
%for discrete data: test = 'chi2' for Pearson's chi2 test;'g2' for G2 likelihood ratio test

%for example: The UCI dataset wdbc with 569 instances and 31 features (the index of the  class attribute is 31).

%[selected_features1,time]=fast_osfs_d(wdbc,31,0.01,'g2')

%if the feature values of X must be from 0 to max_value(X)-1,then 

%[selected_features1,time]=fast_osfs_d(wdbc+1,31,0.01,'g2')

%output: 
%selected_features1: the selected features
%time: running time

%please refer to the following papers for the details and cite them:
%Wu, Xindong, Kui Yu, Wei Ding, Hao Wang, and Xingquan Zhu. "Online feature selection with streaming features." Pattern Analysis and Machine Intelligence, IEEE Transactions on 35, no. 5 (2013): 1178-1192.



start=tic;

[n,p]=size(data1);
ns=max(data1);
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
     
      [CI] = my_cond_indep_chisquare(data1,i, class_index, [], test, alpha, ns);
      
      if CI==0
          stop=1;
      end
         
          if stop
              
                if ~isempty(selected_features)
                    [CI]=compter_dep_2(selected_features,i,class_index,3, 1, alpha, test,data1);
                end              
                           
                if CI==0
                    
                    selected_features=[selected_features,i];
                    p2=length(selected_features);
                    selected_features1=selected_features;           
                  
                    for j=1:p2
 
                       %b=setdiff(selected_features1,selected_features(j), 'stable');  
                       
                       b=selected_features1(~sum(bsxfun(@eq,selected_features1',selected_features(j)),2));
                       
                       if ~isempty(b)
                          [CI]=optimal_compter_dep_2(b,selected_features(j),class_index,3, 1, alpha, test,data1);                    
                                 
                           if CI==1
                               selected_features1=b;
                           end
                       end
                    end
                end
          end
   selected_features=selected_features1;
 end
time=toc(start);    

   
  
    
      