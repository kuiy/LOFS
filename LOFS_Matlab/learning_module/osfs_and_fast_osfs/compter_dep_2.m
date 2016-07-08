
function [CI,dep1,p_value]=compter_dep_2(bcf,var,target,max_k, discrete, alpha, test,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for a discrete data set, discrete=1, otherwise, discrete=0 for a continue data set
%test = 'chi2' for Pearson's chi2 test;'g2' for G2 likelihood ratio test (default)

dep1=0;
x=0;
n_bcf=length(bcf);
code=bcf;
N=size(data,1);
max_cond_size=max_k;
CI=0;
p_value=1;
if(max_cond_size>n_bcf)
	max_cond_size=n_bcf;
end
cond=[];
cond_size=1;
while cond_size<=max_cond_size
    
       cond_index=zeros(1,cond_size);
       for i=1:cond_size
		    cond_index(i)=i;
        end
        stop=0;
       
while stop==0
    
		     cond=[];  
             
                           
           for i=1:cond_size
			  cond=[cond code(cond_index(i))];
           end
           
          
            
            if discrete==1
                 ns=max(data);
                 [CI, dep, p_value]=my_cond_indep_chisquare(data,var,target,cond,test,alpha,ns);
                 x=dep;
            else 
                 [CI, r, p_value]= my_cond_indep_fisher_z(data,var,target, cond, N, alpha);
                 x=r;
            end           
            
            if(CI==1||isnan(x))
				 stop=1;
				 cond_size=max_cond_size+1;
            end
            
		   if(stop==0)
		 	[cond_index,stop]=next_cond_index(n_bcf,cond_size,cond_index);
           end
 end
     cond_size=cond_size+1;     	
end
dep1=x;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [cond_index,stop]=next_cond_index(n_bcf,cond_size,cond_index1)

  stop=1;
  i=cond_size;

while i>=1
  	    if(cond_index1(i)<n_bcf+i-cond_size)
		 cond_index1(i)=cond_index1(i)+1;
		 if(i<cond_size)
			for(j=i+1:cond_size)
				cond_index1(j)=cond_index1(j-1)+1;
            end
         end
		  stop=0;
		  i=-1;
        end
        i=i-1;
end
cond_index=cond_index1;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
