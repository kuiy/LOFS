function r=getRank(v)
% rank the values in column vector v
% Yifeng Li
% October 24, 2012
% example: 
% v=[ 0.5;0.2;0.4;0.6;0.2;0.1;0.9;0.5;0.5]
% r=getRank(v)

n=numel(v);
r=zeros(n,1);
[vS,ind]=sort(v);
i=1;
while i<=n
       su=i; % sum
        c=1;
        
     while i<n &&  vS(i)== vS(i+c)
       su=su+i+c;
       c=c+1;
       if (i+c)>n
           break;
      end
    end
    
   rankAvg=su/c;
   for k=i:i+c-1
       r(ind(k))=rankAvg;
   end
   i=i+c;
end
