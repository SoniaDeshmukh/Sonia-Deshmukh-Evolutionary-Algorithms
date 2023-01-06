function [alpha2,beta2]=thetaquantummutationcr2(beta1,n,popSize)
pool=zeros(n,n,popSize);
DE_randvar=3;
CR1=0.0375.*randn(1,1)+0.5;
F=rand*rand*(0.1);
theta=asin(beta1);
%thetapop= (rand(n,n)< sind(theta).^2)
alpha2=zeros(n,n,popSize);
beta2=zeros(n,n,popSize);
for i=1:popSize
    count=1;
    idx=zeros(1,DE_randvar); % we need to pick three random individuals from the population, even should be different from i.
    while(count<=DE_randvar)
        x=randi([1,popSize]);
        if(x~=i && x~=idx(1) && x~=idx(2));% the individual should not be equal to the any of the the other individual to get maximum deviation
            idx(count)=x;
            count=count+1;
        end
    end
    pool(:,:,i)=theta(:,:,idx(1))+F*(theta(:,:,idx(2))-theta(:,:,idx(3))) ;  
    parfor j=1:n
        for k=1:n
            r=rand();
            I=randi([1,popSize]);
            j;
            if r<=CR1 || j==I;% if random number is less than cross over rate then only we will apply cross over
                pool(j,k,i)= pool(j,k,i);	%mutated component
            elseif r>CR1 && j~=I;
                pool(j,k,i)=theta(j,k,i); %original component
            end
        end        
    end
beta2(:,:,i)=sin(pool(:,:,i));
alpha2sq(:,:,i)=(1-beta2(:,:,i).^2);
alpha2(:,:,i)=sqrt(alpha2sq(:,:,i));
end
end



