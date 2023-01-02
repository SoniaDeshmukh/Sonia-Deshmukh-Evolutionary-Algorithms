function [countmissingtokensplit,TracesMissingTokensplit] = missingtokensplit(L,row,col,C,max,indexes)
%{
   this fuction counts number of missing tokens
%}
%{
C=[0 1 1 0 1;0 0 1 1 0;0 1 0 0 0;0 0 0 0 0;0 0 0 0 0]
L=[1 2 3 4;1 3 2 4;1 2 3 4;1 3 2 4;1 2 3 4;1 5 4 0]
row=6;
col=4;
indexes=[1,2];
max=3;
%}
TracesMissingTokensplit=[];
%{
C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0];
L=[1 2 3 4;1 3 2 4;1 3 2 4;1 5 4 0;1 3 2 4;1 2 3 4;1 5 4 0;1 5 4 0];
n=5;
row=8;
col=4;
indexes=[1,2,3];
max=3;
%}
    countmissingtokensplit=0;
    parfor i=1:numel(indexes)
        for x=1:row
            for y=1:col
                if L(x,y) == indexes(i)
                   for k=1:max-1
                       if y+k+1 <= col && L(x,y) ~= 0 && L(x,y+k) ~= 0 && L(x,y+k+1)~= 0 && C(L(x,y),L(x,y+k)) == 1 && C(L(x,y),L(x,y+k+1)) == 1 && C(L(x,y+k),L(x,y+k+1)) ~= 1    
                           countmissingtokensplit=countmissingtokensplit+1;
                           TracesMissingTokensplit=[TracesMissingTokensplit;x];
                       end                           
                   end
                end
            end
        end
    end
end


                            
                        