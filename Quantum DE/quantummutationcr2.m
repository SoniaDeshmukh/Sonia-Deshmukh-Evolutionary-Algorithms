function [alpha2,beta2]=quantummutationcr2(beta1,n,popSize)
pool=zeros(n,n,popSize);
DE_randvar=3;
CR1=0.9480;
F=1.9298;
alpha2=zeros(n,n,popSize);
beta2=zeros(n,n,popSize);
for i=1:popSize
    count=1;
    idx=zeros(1,DE_randvar); % we need to pick two random individuals from the population, even should be different from i.
    while(count<=DE_randvar)
        x=randi([1,popSize]);
        if(x~=i && x~=idx(1) && x~=idx(2));% the individual should not be equal to the any of the the other individual to get maximum deviation
            idx(count)=x;
            count=count+1;
        end
    end
    pool(:,:,i)=beta1(:,:,idx(1))+F*(beta1(:,:,idx(2))-beta1(:,:,idx(3))) ;   
     parfor j=1:n
        for k=1:n
             r=rand();
             I=randi([1,n]);
           if r<=CR1 || j==I; % if random number is less than cross over rate then only we will apply cross over
                pool(j,k,i)= pool(j,k,i);	%mutated component
            elseif r>CR1 && j~=I;
                pool(j,k,i)=beta1(j,k,i); %original component
            end
        end        
     end   
beta2(:,:,i)=pool(:,:,i);
alpha2sq(:,:,i)=(1-beta2(:,:,i).^2);
alpha2(:,:,i)=sqrt(alpha2sq(:,:,i));
end
end

%{
SEED STorage
rstates1=cell(n*n,1);
rstates2=cell(n*n,1);
for i=1:popSize
    count=1;
    idx=zeros(1,DE_randvar); % we need to pick two random individuals from the population, even should be different from i.
    while(count<=DE_randvar)
        x=randi([1,popSize]);
        if(x~=i && x~=idx(1) && x~=idx(2));% the individual should not be equal to the any of the the other individual to get maximum deviation
            idx(count)=x;
            count=count+1;
        end
    end
    pool(:,:,i)=beta1(:,:,idx(1))+F*(beta1(:,:,idx(2))-beta1(:,:,idx(3))) ;   
    filename = sprintf('g4run%02d_iter%03d_qmutpop%02d.csv',run,iter,i);
    parfor j=1:n
        for k=1:n
             s1=rng();
        %rstates1{j*k} =s1;
         r=rand();
        dlmwrite(filename,s1.Type,'delimiter',',','-append');
         dlmwrite(filename,s1.State,'delimiter',',','-append');
         dlmwrite(filename,r,'delimiter',',','-append');         
             s2=rng();
         %rstates2{j*k} =s2;
            I=randi([1,n]);
         dlmwrite(filename,s2.Type,'delimiter',',','-append');
         dlmwrite(filename,s2.State,'delimiter',',','-append');
         dlmwrite(filename,I,'delimiter',',','-append');
            if r<=CR1 || j==I; % if random number is less than cross over rate then only we will apply cross over
                pool(j,k,i)= pool(j,k,i);	%mutated component
            elseif r>CR1 && j~=I;
                pool(j,k,i)=beta1(j,k,i); %original component
            end
        end        
    end
   
beta2(:,:,i)=pool(:,:,i);
alpha2sq(:,:,i)=(1-beta2(:,:,i).^2);
alpha2(:,:,i)=sqrt(alpha2sq(:,:,i));
end
end
%}



