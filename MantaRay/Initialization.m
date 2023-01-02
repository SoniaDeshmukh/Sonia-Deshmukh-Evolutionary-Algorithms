function [D] = Initialization(L,row,col,n)
follow = follows(L,row,col,n); % generating follows
ltl = l2l(L,row,col,n);       % generating l2l i.e. length two loops
D = dependency(follow,ltl,n);   % generating dependency
end
