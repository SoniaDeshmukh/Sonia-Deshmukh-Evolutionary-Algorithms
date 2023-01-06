function sim = simplicity1(C,n,row,col,L)
%{
C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0]
n=5
L=[1 2 3 4; 1 3 2 4; 1 2 3 4; 1 3 2 4; 1 2 3 4;1 5 4 0]

%C=[0 1 1 0 0;0 0 1 1 0;0 1 0 0 0;0 0 0 0 0;0 0 0 0 0]
row=6
col=4
%}
missingActivities=0;
duplicateActivities=0;
eventClasses=n;
nodes=n;
for i=1:n
    s=sum(C(:,i))+sum(C(i,:));
    if s == 0
        missingActivities = missingActivities+1;
    end
    for i=1:row
        if nnz(L(i,:) == i) > 1
            duplicateActivities=duplicateActivities+1;
        end
    end
end

    sim = 1 - ((duplicateActivities+missingActivities)/(nodes+eventClasses));
end

