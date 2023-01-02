function C = causality(D,n,p,populationSize)
    %tic 
    %disp('... causality ...')
    C=zeros(n,n,populationSize);
   
    parfor k=1:populationSize
        r=rand(n,n);     % a matrix of random numbers is generated of size (n X n)
        C(:,:,k)= (r < D^p);   % if (r < D^p)  , then  1
                               % otherwise 0
    end
    %toc
end
