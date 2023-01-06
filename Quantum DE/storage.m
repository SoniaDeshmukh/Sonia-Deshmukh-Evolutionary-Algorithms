function [C1,comp1Array,bst1,compbst1]=storage(beta1,n,L,row,col,D,follow,popSize)
C1=zeros(n,n,popSize);
%compArray1=zeros(1,popSize);
p=1;

parfor k=1:popSize
    
     C1(:,:,k)= ((beta1(:,:,k)).^2 < D^p)   % if (r < D^p)  , then  1
    % otherwise 0
    %compArray1(k)=completeness(C1(:,:,k),n,L,row,col)
end

[pool,comp1Array,bst1,compbst1] = DE1(C1,popSize,L,row,col,n,follow)

end