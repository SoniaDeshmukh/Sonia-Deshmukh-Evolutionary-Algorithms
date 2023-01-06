function allParsedActivities = parsedActivities(C,L,row,col)
%{
     allParsedActivities(L; CM) gives the total number of tasks in
     the event log L that could be parsed without problems by the 
     causal matrix (or individual) CM.
%}
  
   % disp('.. parsed ..')

    allParsedActivities=0;
    parfor i=1:row
        allParsedActivities=allParsedActivities+1;
        for j=1:col-1
            if L(i,j) ~= 0 & L(i,j+1) ~=0 & C(L(i,j),L(i,j+1)) == 1 
                allParsedActivities=allParsedActivities+1;
            end
        end
    end
   
end

           