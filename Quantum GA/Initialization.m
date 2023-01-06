function [A,compArray,comtime2,alpha,beta] = Initialization(L,row,col,n,populationSize)

follow = follows(L,row,col,n); % generating follows
ltl = l2l(L,row,col,n);       % generating l2l i.e. length two loops
D = dependency(follow,ltl,n);   % generating dependency
p=1;         % paramter needed for Casuality
[A,alpha,beta] = causality(D,n,p,populationSize);     % A is the 3D array
    %genArray=zeros(1,populationSize);
    compArray=zeros(1,populationSize);
    %precArray=zeros(1,populationSize);
    %simArray=zeros(1,populationSize);
    comptime=tic;
    parfor i=1:populationSize
        C=A(:,:,i);
        %genArray(i)=generalization(C,L,row,col,n);
        compArray(i)=completeness(C,n,L,row,col);
        %precArray(i)=preciseness(L,row,col,C,n);
        %simArray(i)=simplicity(C,n);
    end
    comtime2=toc(comptime);    
       
end
