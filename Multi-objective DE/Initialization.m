function [A,genArray,compArray,D,follow,comiter1,geniter1,comtime1,gentime1] = Initialization(L,row,col,n,populationSize)

follow = follows(L,row,col,n); % generating follows
ltl = l2l(L,row,col,n);       % generating l2l i.e. length two loops
D = dependency(follow,ltl,n);   % generating dependency
p=1;         % paramter needed for Casuality
A = causality(D,n,p,populationSize);     % A is the 3D array

    genArray=zeros(1,populationSize);
    compArray=zeros(1,populationSize);
    %precArray=zeros(1,populationSize);
    %simArray=zeros(1,populationSize);
    gentime=tic;
    parfor i=1:populationSize
        C=A(:,:,i);
        genArray(i)=generalization(C,L,row,col,n,follow);
        %compArray(i)=completeness(C,n,L,row,col);
        %precArray(i)=preciseness(L,row,col,C,n);
        %simArray(i)=simplicity(C,n);
    end
    %disp('......... generalization ............');
    geniter1=populationSize;    
    gentime1=toc(gentime);
    comtime=tic;
    parfor i=1:populationSize
        C=A(:,:,i);
        %genArray(i)=generalization(C,L,row,col,n,follow);
        compArray(i)=completeness(C,n,L,row,col);
        %precArray(i)=preciseness(L,row,col,C,n);
        %simArray(i)=simplicity(C,n);
    end
     %disp('......... completness ............');
     comiter1=populationSize;
    comtime1=toc(comtime);
    
end
