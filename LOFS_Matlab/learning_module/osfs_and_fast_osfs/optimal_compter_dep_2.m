
function [CI,dep1]=optimal_compter_dep_2(bcf,var,target,max_k, discrete, alpha, test,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for a discrete data set, discrete=1, otherwise, discrete=0 for a continue data set

%if new feature X is not redundant, that is, we cannot 
%remove X from X, then we check redundency for each feature.
%When we test redundency for a feature, we only consider
%its candidate Markov blanlets containg the new feautre X to redunce the
%number of tests. for example, now BCF=[2,3,4,5], If feature 6 is added
%into BCF, BCF=[2,3,4,5,6]. When testing feature 5, we only consider the
%following subsets: [6],[2,6],[3,6],[4,6],[2,3,6],[2,4,6],[3,4,6],if
%max_k=3.

dep1=0;
x=0;

n_pc=length(bcf);
code=bcf;
N=size(data,1);
max_cond_size=max_k;
CI=0;
p=1;
if(max_cond_size>n_pc)
	max_cond_size=n_pc;
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
                if i==cond_size
                    cond_index(i)=n_pc; 
                    cond=[cond code(cond_index(i))];
                else
               	    cond=[cond code(cond_index(i))];
                end
           end
           
   
            
            if discrete==1
                 [CI, dep, alpha2]=my_cond_indep_chisquare(data,var,target,cond,test,alpha);
                 x=dep;
            else 
                 [CI, r, p]= my_cond_indep_fisher_z(data,var,target, cond, N, alpha);
                 x=r;
            end           
            
            if(CI==1 || isnan(x))
				 stop=1;
				 cond_size=max_cond_size+1;
            end
            
		   if(stop==0)
		 	[cond_index,stop]=optimal_next_cond_index(n_pc,cond_size,cond_index);
           end
 end
     cond_size=cond_size+1;     	
end
dep1=x;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [cond_index,stop]=optimal_next_cond_index(n_pc,cond_size,cond_index1)

  stop=1;
  i=cond_size;

while i>=1
  	    if(cond_index1(i)<n_pc+i-cond_size)
            if i==cond_size
		         cond_index1(i)=n_pc+i-cond_size; 
            else
		        cond_index1(i)=cond_index1(i)+1;
            end
            
		    if i<cond_size
			    for(j=i+1:cond_size)
                    if (j==cond_size) 
                        cond_index1(j)=n_pc;
                    else
				        cond_index1(j)=cond_index1(j-1)+1;
                    end
                end
            end
		    stop=0;
		    i=-1;
        end
        i=i-1;
end
cond_index=cond_index1;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
