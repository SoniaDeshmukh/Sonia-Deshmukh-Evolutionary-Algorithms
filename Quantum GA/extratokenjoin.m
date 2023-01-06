function [CountExtraTokenJoin,TracesExtraTokens] = extratokenjoin(L,row,col,C,indexes,max)
%tic
%disp('.. extratokenjoin ..')
%{

%C=[0 1 1 0 1;0 0 1 1 0;0 1 0 0 0;0 0 0 0 0;0 0 0 0 0]
C=[0 1 1 0 1;0 0 0 1 0;0 0 0 1 0;0 0 0 0 0;0 0 0 0 0]
L=[1 2 3 4;1 3 2 4;1 2 3 4;1 3 2 4;1 2 3 4;1 5 4 0]
row=6;
col=4;
TracesExtraTokens=[];
indexes=[4];
max=2;
%}
TracesExtraTokens=[];
%{
 C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0];
L=[1 2 3 4;1 3 2 4;1 3 2 4;1 5 4 0;1 3 2 4;1 2 3 4;1 5 4 0;1 5 4 0];
n=5;
row=8;
col=4;
indexes=[3,4];
max=3;
%}
    CountExtraTokenJoin=0;
    parfor i=1:numel(indexes)
        for x=1:row
            for y=1:col
                if L(x,y) == indexes(i)
                     for k=1:max
                       if y-k-1 >=1 & L(x,y) ~= 0 & L(x,y-k) ~= 0 & L(x,y-k-1) ~= 0 & C(L(x,y-k),L(x,y)) == 1 & C(L(x,y-k-1),L(x,y)) == 1 & C(L(x,y-k-1),L(x,y-k)) ~= 1    
                           CountExtraTokenJoin=CountExtraTokenJoin+1;
                            TracesExtraTokens=[TracesExtraTokens;x];
                       end
                           
                   end
                end
            end
        end
    end
   CountExtraTokenJoin;
   TracesExtraTokens;
  %  toc
end


    