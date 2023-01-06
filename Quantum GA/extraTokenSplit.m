function [countextratokensplit,TracesExtraTokensLeftBehind] = extraTokenSplit(L,row,col,C,max,indexes)

%{
C=[0 1 1 0 1;0 0 0 1 1;0 0 0 1 0;0 0 0 0 0;0 1 0 1 0]
%C=[0 1 1 0 1;0 0 1 1 1;0 1 0 1 1;0 0 0 0 0;0 1 1 1 0]
L=[1 2 3 4;1 3 2 4;1 2 3 4;1 3 2 4;1 2 3 4;1 5 4 0]
row=6;
col=4;
n=5;

indexes=[1,2,3,5];
max=3;
%}
%{
 C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0];
L=[1 2 3 4;1 3 2 4;1 3 2 4;1 5 4 0;1 3 2 4;1 2 3 4;1 5 4 0;1 5 4 0];
n=5;
row=8;
col=4;
indexes=[1,2,3];
max=3;
%}
TracesExtraTokensLeftBehind=[];
countextratokensplit=0;

finalExtra=[];   % unique extra tokens for all the traces, for all values in "indexes"
parfor x=1:row
    extra=[];    % for each element in "indexes", index of extra tokens for all the traces
    for i=1:numel(indexes)
        C1=[];
        for y=1:col
            if L(x,y) == indexes(i)
                
                
                j=1;          % j is the index of row in C1
                for p=y:y+max-1
                    if p < col-1 & L(x,p) ~= 0 & L(x,p+1) ~= 0
                        C1=[C1;C(L(x,p),:)];
                    end
                    for q=p+1:y+max
                        if q <= col & L(x,q) ~= 0
                            C1(j,L(x,q))=0;
                            
                        end
                    end
                    j=j+1;
                end
                
                [r,t]=size(C1);
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
                        TracesExtraTokensLeftBehind=[TracesExtraTokensLeftBehind;x];
                    end
                end
            end
        end
    end
    extra;
    c=unique(extra);
    finalExtra=[finalExtra;c];
    
end
countextratokensplit=length(finalExtra);
TracesExtraTokensLeftBehind=unique(TracesExtraTokensLeftBehind);

end
