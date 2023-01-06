function C = causality(D,n,p,populationSize)
    %tic 
    %disp('... causality ...')
    C=zeros(n,n,populationSize);
    
    parfor k=1:populationSize
        r=rand(n,n);     % a matrix of random numbers is generated of size (n X n)
        %C(:,:,k)= (r < abs(D));   %Case 1--values will convert to +
           C(:,:,k)=(r<D^1); % Case 2- only +values 
      end
    %{
    % Case 3: when we give equal probability to all the bits in anindividual
    %With repair- means repair according to D
    beta=ones(n,n)*0.5;
     for i=1:n
            for j=1:n
                if D(i,j)==0 
                    beta(i,j)=0;
                end
            end
        end
      parfor k=1:populationSize
        r=rand(n,n);     % a matrix of random numbers is generated of size (n X n)
          C(:,:,k)=(r<beta);
          
      end
    
    % Case 4: when we give equal probability to all the bits in anindividual
    %Without repair- dont repair according to D
    beta=ones(n,n)*0.5;
      parfor k=1:populationSize
        r=rand(n,n);     % a matrix of random numbers is generated of size (n X n)
        C(:,:,k)=(r<beta);
      end
    %}
        %toc
end
