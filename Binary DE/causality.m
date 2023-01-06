function C = causality(D,n,populationSize)
%tic
%disp('... causality ...')
C=zeros(n,n,populationSize);
parfor k=1:populationSize
    r=rand(n,n);     % a matrix of random numbers is generated of size (n X n)
    C(:,:,k)=(r<D^1); % Case 2- only +values
end
%toc
end
