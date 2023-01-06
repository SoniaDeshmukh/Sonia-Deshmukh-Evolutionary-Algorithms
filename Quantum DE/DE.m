function[pool,comp1Array,bst1,compbst1] = DE(population,popSize,L,row,col,n)
pool=zeros(n,n,popSize);
DE_randvar=3;
Cross_rate=0.9;
beta=1;

for i=1:popSize
    count=1;
    idx=zeros(1,DE_randvar); % we need to pick three random individuals from the population, even should be different from i.        
        while(count<=DE_randvar)
            x=randi([1,popSize]);
            if(x~=i && x~=idx(1) && x~=idx(2))% the individual should not be equal to the any of the the other individual to get maximum deviation
                idx(count)=x;
                count=count+1;
            end
        end
       
        % mutation operator for DE 
        % here we dont need to apply filter function after mutation as in
        % case of NSGA-II because we are not randomly adding any point anywhere in matrices. we are just adding the already existed matrices. 
        pool(:,:,i)=population(:,:,idx(1))+beta*(population(:,:,idx(2))-population(:,:,idx(3)));
        for j=1:n
            for k=1:n
                if (pool(j,k,i)>1 || pool(j,k,i)<0)% if we get any other element in the matrix such as 2,-1 etc we replace it randomly with 0 or 1.
                    pool(j,k,i)=randi([0,1]); % randomly replacing it with 0 or 1.              
                end
            end
        end
        
        for j=1:n
            r=rand();
            if (r<Cross_rate) % if random number is less than cross over rate then only we will apply cross over
              pool(j,:,i)= pool(j,:,i);	%mutated component
            
            else
              pool(j,:,i)=population(j,:,i); %original component
            end
        end
        %{
         r=rand();
        if (r<Cross_rate) % if random number is less than cross over rate then only we will apply cross over
             crossOverPoint = randi(n);          % to generate random numbers between 1 to n this will be our crossover point
        Child_1=population(:,:,i);
        Child_2=pool(:,:,i);
        for m=1:n
            if Child_1(crossOverPoint,m) ~= Child_2(crossOverPoint,m)     % swapping of outputs
                temp=Child_1(crossOverPoint,m);
                Child_1(crossOverPoint,m)=Child_2(crossOverPoint,m);
                Child_2(crossOverPoint,m)=temp;
            end

            if Child_1(m,crossOverPoint) ~= Child_2(m,crossOverPoint)     %swapping of inputs
                temp=Child_1(m,crossOverPoint);
                Child_1(m,crossOverPoint)=Child_2(m,crossOverPoint);
                Child_2(m,crossOverPoint)=temp;
            end
        end        
        pool(:,:,i)= Child_2;        
        end
   %}
end
    %gen1Array=zeros(1,popSize);
    comp1Array=zeros(1,popSize);
    %prec1Array=zeros(1,popSize);
   % sim1Array=zeros(1,popSize);
    parfor i=1:popSize % to calculate all the four quality dimensiona for the child population after cross over.
        C=pool(:,:,i);
       % gen1Array(i)=generalization(C,L,row,col,n);
        comp1Array(i)=completeness(C,n,L,row,col);
       % prec1Array(i)=preciseness(L,row,col,C,n);
       % sim1Array(i)=simplicity(C,n);
    end
 [compArray2,sortIdx] = sort(comp1Array,'descend');% sort B using the sorting index
C2 = pool(:,:,sortIdx);
bst1=C2(:,:,1);
compbst1=compArray2(:,1);
end
