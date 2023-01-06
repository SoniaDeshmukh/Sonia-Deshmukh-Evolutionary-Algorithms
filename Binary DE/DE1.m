function[pool,comp1Array,comtime2] = DE1(population,popSize,L,row,col,n)
pool=zeros(n,n,popSize);
DE_randvar=2;
C1=0.2;
C2=0.5;
for i=1:popSize
    count=1;
    idx=zeros(1,DE_randvar); % we need to pick two random individuals from the population, even should be different from i.
    while(count<=DE_randvar)
        x=randi([1,popSize]);
        if(x~=i && x~=idx(1) && x~=idx(2))% the individual should not be equal to the any of the the other individual to get maximum deviation
            idx(count)=x;
            count=count+1;
        end
    end
    a=xor(population(:,:,idx(1)),population(:,:,idx(2)));
     % mutation operator for DE
    % here we dont need to apply filter function after mutation as in
    % case of NSGA-II because we are not randomly adding any point anywhere in matrices. we are just adding the already existed matrices.
    pool(:,:,i)= or(and(a,randi([0,1],n,n)),and(~a,(population(:,:,idx(1)))));
    for j=1:n
        for k=1:n
            r=rand();
            if (a(j,k)==0) &&(r<C1) % if random number is less than cross over rate then only we will apply cross over
                pool(j,k,i)= pool(j,k,i);	%mutated component
            elseif (a(j,k)==1) &&(r<C2)
                pool(j,k,i)= pool(j,k,i);	%mutated component
            else
                pool(j,k,i)=population(j,k,i); %original component
            end
        end
    end
end
comp1Array=zeros(1,popSize);
comptime=tic;
parfor i=1:popSize % to calculate all the four quality dimensiona for the child population after cross over.
    C=pool(:,:,i);
    comp1Array(i)=completeness(C,n,L,row,col);
end
% disp('......... completness ............');
comtime2=toc(comptime);
end

