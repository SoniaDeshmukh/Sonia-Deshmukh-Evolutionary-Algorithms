function [C1,comp1Array,comtime,comiter2,bst1,compbst1,alpha2,beta2]=quantummutationcr(beta1,n,L,row,col,popSize,D)
pool=zeros(n,n,popSize);
%pool1=zeros(n,n,popSize);
C=zeros(n,n);
DE_randvar=2;
C1=0.2;
C2=0.5;
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

        c=(rand(n,n)< beta1(:,:,idx(1)).^2);% this c is generated to apply quantum xor gate as the first operand should be in the form of (0,1)
        a=qxor(c,beta1(:,:,idx(2)),n,D);%using quantum xor(if a=0 b will be same ,if a=1 flip the bits of b)
        %D is used to in the quantum gates to apply the operation only on those bits where D=1 to take less time.as we dont need to execute where D=1 
        c1=(rand(n,n)< a.^2); %randi([0,1],n,n)%this c is generated to apply quantum AND gate as the first operand should be in the form of (0,1)
        b1=qAND(c1,rand(n,n),n,D,a);
        b2=qAND(~c1,(beta1(:,:,idx(1))),n,D,sqrt(1-a.^2));%sqrt(1-a.^2) as we have to pass flip bit of a.
        c2=(rand(n,n)< b1.^2);
        pool(:,:,i)= qOR(c2,b2,n,D,b1);
        
       %b=xor(alpha1(:,:,idx(1)),alpha1(:,:,idx(2)))
        %b =xor(xor(population(:,:,idx(1)),population(:,:,idx(2))),randi([0,1],n,n))
       %a =(xor((~(xor(population(:,:,idx(1)),population(:,:,idx(2))))),(population(:,:,idx(1))))) 
      % pool1(:,:,i)= or(and(b,randi([0,1],n,n)),and(~b,(alpha1(:,:,idx(1)))))
        
        for j=1:n
            for k=1:n
            r=rand();
            
            if (a(j,k)==0) &&(r<C1) % if random number is less than cross over rate then only we will apply cross over
              pool(j,k,i)= pool(j,k,i);	%mutated component
              %pool1(j,k,i)= pool1(j,k,i);
            %disp('......... 1 ............');
            elseif (a(j,k)==1) &&(r<C2)
                 pool(j,k,i)= pool(j,k,i);	%mutated component
                % disp('......... 2 ............');
                %pool1(j,k,i)= pool1(j,k,i);
            else
              pool(j,k,i)=beta1(j,k,i); %original component
              %disp('......... 3 ............');
             % pool1(j,k,i)=alpha1(j,k,i);
            end
            end
            
        end
      beta2(:,:,i)=pool(:,:,i);
      alpha2sq(:,:,i)=(1-beta2(:,:,i).^2);
      alpha2(:,:,i)=sqrt(alpha2sq(:,:,i));
      (alpha2(:,:,1).^2)+(beta2(:,:,1).^2);
end

    C1=zeros(n,n,popSize);
    comp1Array=zeros(1,popSize);
%p=1;
comptime=tic;
for k=1:popSize  
    C1(:,:,k)= (rand(n,n)< beta2(:,:,k).^2);
     %C1(:,:,k)= ((pool(:,:,k)).^2 < D^p);   % if (r < D^p)  , then  1
    % otherwise 0
    %C1(:,:,k)= and(C1(:,:,k),D);
    comp1Array(k)=completeness(C1(:,:,k),n,L,row,col);
end

comiter2=popSize;
    comtime=toc(comptime);
    [compArray2,sortIdx] = sort(comp1Array,'descend');% sort B using the sorting index
C2 = C1(:,:,sortIdx);
bst1=C2(:,:,1);
compbst1=compArray2(:,1);   
    
end


%{
    comp1Array=zeros(1,popSize);
  
    parfor i=1:popSize % to calculate all the four quality dimensiona for the child population after cross over.
        C=pool(:,:,i);
        comp1Array(i)=completeness(C,n,L,row,col);
    end
%}

