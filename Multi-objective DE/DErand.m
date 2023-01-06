clc
DE_randvar=3;
popSize=6;

for i=1:popSize
    count=1;
    idx=zeros(1,DE_randvar); % we need to pick three random individuals from the population
    
          
        while(count<=DE_randvar)
            x=randi([1,popSize]);
            if(x~=i && x~=idx(1) && x~=idx(2))% the individual should not be equal to the any of the the other individual to get maximum deviation
                idx(count)=x
                count=count+1
            end
        end
    idx;
end