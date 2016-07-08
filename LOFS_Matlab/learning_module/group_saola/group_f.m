function [group_feature] = group_f(features_index,numberGroups)


k=floor(length(features_index)/numberGroups);

group_feature=cell(1,numberGroups);

j=1;
 for i=1:numberGroups
         % i
   if i~=numberGroups
       group_feature{i}=features_index(j:k*i);
   end
   if i==numberGroups
       group_feature{i}=features_index(j:end);
   end
j=j+k;

end

