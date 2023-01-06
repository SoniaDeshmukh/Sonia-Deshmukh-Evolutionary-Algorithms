function [C,alpha,beta] = causality(D,n,p,populationSize)
%disp('... causality ...')
C=zeros(n,n,populationSize);
alpha=zeros(n,n,populationSize);
beta=zeros(n,n,populationSize);
parfor k=1:populationSize
    betasq(:,:,k)=D;
    alphasq(:,:,k)=(1-betasq(:,:,k));
    alpha(:,:,k)=sqrt(alphasq(:,:,k));
    beta(:,:,k)=sqrt(betasq(:,:,k));
    r=rand(n,n);
    C(:,:,k)= (r< betasq(:,:,k));
end
end


