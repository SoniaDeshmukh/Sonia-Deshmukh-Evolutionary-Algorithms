function [A,compArray,comtime2,D] = Initialization(L,row,col,n,populationSize)
follow = follows(L,row,col,n); % generating follows
ltl = l2l(L,row,col,n);       % generating l2l i.e. length two loops
D = dependency(follow,ltl,n);   % generating dependency
p=1;         % paramter needed for Casuality
[A] = causality(D,n,p,populationSize);     % A is the 3D array
compArray=zeros(1,populationSize);
comptime=tic;
parfor i=1:populationSize
    C=A(:,:,i);
    compArray(i)=completeness(C,n,L,row,col);
end
comtime2=toc(comptime);
end
