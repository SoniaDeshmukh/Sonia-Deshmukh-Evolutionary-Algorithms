function [countmissingtokenjoin,TracesMissingTokens] = missingTokenJoin(L,row,col,C,max,indexes)
%{
C=[0 1 1 0 1;0 0 0 1 1;0 0 0 1 0;0 0 0 0 0;0 1 0 1 0]
%C=[0 1 1 0 1;0 0 1 1 1;0 1 0 1 1;0 0 0 0 0;0 1 1 1 0]
L=[1 2 3 4;1 3 2 4;1 2 3 4;1 3 2 4;1 2 3 4;1 5 4 0]
row=6;
col=4;
n=5;

indexes=[2,4,5];    
max=3;
%}

%{
C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0];
L=[1 2 3 4;1 3 2 4;1 3 2 4;1 5 4 0;1 3 2 4;1 2 3 4;1 5 4 0;1 5 4 0];
n=5;
row=8;
col=4;
indexes=[3,4];
max=3;
%}
TracesMissingTokens=[];
countmissingtokenjoin=0;

finalExtra=[];   % unique extra tokens for all the traces, for all values in "indexes"
parfor x=1:row
    extra=[];    % for each element in "indexes", index of extra tokens for all the traces
    for i=1:numel(indexes)
        C1=[];
        for y=1:col
            if L(x,y) == indexes(i)
                j=1;          % j is the index of row in C1
                for p=y:-1:y-max
                    if p > 2 & L(x,p) ~= 0 
                        C1=[C1;C(L(x,p),:)];
                    end
                    for q=p-1:-1:y-max
                        if q > 0 & p > 2 & L(x,q) ~= 0
                            C1(j,L(x,q))=0;
                            
                        end
                    end
                    j=j+1;
                end
               
                r=size(C1);
                
                if r >= 1
                    m=C1(1,:);
                    for a=2:r
                        m=m.*C1(a,:);
                    end
                    [s,l]=size(m);
                    for p=1:l
                        if m(p) == 1
                            extra=[extra;p];
                        end
                    end
                    if sum(m) > 0
                        TracesMissingTokens=[TracesMissingTokens;x];
                    end
                end
            end
      
        end
    end
    c=unique(extra);
    finalExtra=[finalExtra;c];
    
end
countmissingtokenjoin=length(finalExtra);
TracesMissingTokens=unique(TracesMissingTokens);
end