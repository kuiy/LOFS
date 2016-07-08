

function [select_feature,select_group, time] = saloa_group_z_test(group_feature,data,class_attribute,alpha)

%
%Performs the SAOLA algorithm using Fisher's Z-test by Yu 2014.

start_time=tic;
[numgroup] =length(group_feature);
[numInstances,numFeatures]=size(data);
current_feature=[];
dep=zeros(1,numFeatures-1);

CI=1;

g=cell(1,numgroup);

f_index=1:numFeatures;

for i = 1:numgroup
    
       
        f_g_index=group_feature{i};
        current_feature=[];
        
        for j=1:length(f_g_index)   
           
           n1=sum(data(:,f_g_index(j)));
           if n1==0
              continue;
           end
           
           [CI,dep(f_g_index(j))] = my_cond_indep_fisher_z(data,f_g_index(j), class_attribute,[],numInstances,alpha);
        
           if CI==1 || isnan(dep(f_g_index(j)))
             continue;
           end
    
            current_feature=[current_feature, f_g_index(j)]; 
            
            %current_feature1=setdiff(current_feature,f_g_index(j),'stable');
             current_feature1=current_feature(~sum(bsxfun(@eq,current_feature',f_g_index(j)),2));
                  
            if ~isempty(current_feature1)
                
                p=length(current_feature1);
              
                for k=1:p
                     
                 [CI, dep_ij] = my_cond_indep_fisher_z(data,f_g_index(j), current_feature1(k), [],numInstances,alpha);
                                                                    
                  if CI==1|| isnan(dep_ij)
                     continue;
                  end
                                  
                  t_dep=dep_ij;
                  t_feature=current_feature1(k);
                  
                   if dep(t_feature)>=dep(f_g_index(j)) && t_dep>min(dep(f_g_index(j)),dep(t_feature))
                     
                          %current_feature=setdiff(current_feature,f_g_index(j), 'stable');
                          current_feature=current_feature(~sum(bsxfun(@eq,current_feature',f_g_index(j)),2));
                          
                          break;
                  end
                         
                  if dep(f_g_index(j))>dep(t_feature) && t_dep>min(dep(f_g_index(j)),dep(t_feature))
                 
                       %current_feature=setdiff(current_feature,t_feature, 'stable');
                       current_feature=current_feature(~sum(bsxfun(@eq,current_feature',t_feature),2));
                  end                         
            end
         end
    end %for j=1:length(f_g_index) 
        
        g{i}=current_feature;
        if ~isempty(g{i})
            
          CI=1;
            
          for m=1:i-1
            
            g1= g{m};
            
             for m1=1:length(current_feature)
                
               for m2=1:length(g1)
                
                 [CI, dep_ij1] = my_cond_indep_fisher_z(data,g1(m2), current_feature(m1), [],numInstances,alpha);
                 
                 if CI==1|| isnan(dep_ij1)
                     continue;
                  end
                   
                  t_dep1=dep_ij1;
                  t_feature1=current_feature(m1);
                  
                                          
                  if dep(g1(m2))>dep(t_feature1) && t_dep1>min(dep(g1(m2)),dep(t_feature1))
                        %g{i}=setdiff(g{i},t_feature1, 'stable');
                        g{i}=g{i}(~sum(bsxfun(@eq,g{i}',t_feature1),2));
                        break;
                  end       
                  
                   if dep(t_feature1)>=dep(g1(m2)) && t_dep1>min(dep(g1(m2)),dep(t_feature1))
                        %g{m}=setdiff(g{m},g1(m2), 'stable');
                        g{m}=g{m}(~sum(bsxfun(@eq,g{m}',g1(m2)),2));
                   end
        
               end
             end
          end
        end
end

select_feature=[];
select_group=0;

for i=1:numgroup
   if ~isempty(g{i})
     select_feature=[select_feature g{i}];
     select_group=select_group+1;
   end
end

time=toc(start_time);
