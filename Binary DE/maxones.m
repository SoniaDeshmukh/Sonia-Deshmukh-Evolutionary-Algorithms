function [maxr,indexesr,maxc,indexesc] = maxones(C,n)
%{  
    maxc returns the maximum number of 1's in column
    maxr returns the maximum number of 1's in row
%}
    maxr=0;
    maxc=0;
    indexesc=[];    % column indexes with more than one 1's
    indexesr=[];    % row indexes with more than one 1's
    for i=1:n
        s = sum(C(i,:));
        if s > maxr
            maxr=s;
        end
        if s > 1
          indexesr(numel(indexesr)+1)=i;
        end
    end
    for j=1:n
        s=sum(C(:,j));
        if s > maxc
            maxc=s;
        end
        if s > 1
            indexesc(numel(indexesc)+1)=i;
        end
    end
end

        