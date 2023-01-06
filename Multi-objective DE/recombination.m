function [childpop,childgenArray,childcompArray,popSize1] = recombination(population,genArray,compArray,pool,gen1Array,comp1Array,popSize,n)
 ind1=1;
 childpop1=zeros(n,n,2*popSize);
    childcompArray1=zeros(1,2*popSize);
   % childprecArray=zeros(1,2*popSize);
    childgenArray1=zeros(1,2*popSize);
    %childsimArray=zeros(1,2*popSize);
       % create a new pool by comparing first parent to first child if
       % child dominates add it to pool if parent dominates discard child
       % and if both are non-dominating add both to the pool.
        for t=1:popSize                                 
              flag=evalObjective(gen1Array(t),comp1Array(t),genArray(t),compArray(t)); % to evaluate four objective functions which one is dominating whom
               if flag == 1            %  child dominates population
                    %disp('...... flag = 0 ....................');
                    childpop1(:,:,ind1)=pool(:,:,t);
                    childgenArray1(ind1)=gen1Array(t);
                    childcompArray1(ind1)=comp1Array(t);
                    %childprecArray(ind1)=prec1Array(t);
                    %childsimArray(ind1)=sim1Array(t);
                    ind1=ind1+1;
                elseif flag==0 % if parent dominates child discard child
                    childpop1(:,:,ind1)=population(:,:,t);
                    childgenArray1(ind1)=genArray(t);
                    childcompArray1(ind1)=compArray(t);
                    %childprecArray(ind1)=precArray(t);
                    %childsimArray(ind1)=simArray(t);
                    ind1=ind1+1;
                    
                elseif flag==-1
                    childpop1(:,:,ind1)=population(:,:,t);% non dominating solutions so add both population and child into childpop
                    childgenArray1(ind1)=genArray(t);
                    childcompArray1(ind1)=compArray(t);
                    %childprecArray(ind1)=precArray(t);
                    %childsimArray(ind1)=simArray(t);
                    ind1=ind1+1;
                    childpop1(:,:,ind1)=pool(:,:,t);
                    childgenArray1(ind1)=gen1Array(t);
                    childcompArray1(ind1)=comp1Array(t);
                    %childprecArray(ind1)=prec1Array(t);
                    %childsimArray(ind1)=sim1Array(t);
                    ind1=ind1+1;
               end
        end
        
        popSize1=ind1-1;
        childpop=zeros(n,n, popSize1);
    childcompArray=zeros(1, popSize1);
    childgenArray=zeros(1, popSize1);
    index=1;
        for i=1:popSize1
                childpop(:,:,index)=childpop1(:,:,i);    % finally taking out top popSize matrices
                childgenArray(index)=childgenArray1(i);
                childcompArray(index)=childcompArray1(i);
                index=index+1;                
        end
end