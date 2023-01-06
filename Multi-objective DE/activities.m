function allActivities = activities(L,row,col)
%{
    allActivities stores the sum of unique activities of each event trace
    in the event log.
%}
    allActivities=0;
    parfor i=1:row
        x=col;
        while(L(i,x) == 0)
            x=x-1;
        end
        allActivities=allActivities+x;
    end
end
            