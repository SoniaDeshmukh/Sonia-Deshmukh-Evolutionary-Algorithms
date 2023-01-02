function [A,D] = Initialization(L,row,col,n,populationSize)
follow = follows(L,row,col,n); % generating follows
ltl = l2l(L,row,col,n);       % generating l2l i.e. length two loops
D = dependency(follow,ltl,n);   % generating dependency
p=1;         % paramter needed for Casuality
A = causality(D,n,p,populationSize);     % A is the 3D array
end
