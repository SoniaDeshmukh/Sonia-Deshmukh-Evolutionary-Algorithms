function Completeness = completeness(C,n,L,row,col)
%{

    clc;                       % clears the window screen
    clear all;                 % clears the workspace and variables
    L=csvread('file1.txt');
    %L=[1 2 4 5 7;1 3 4 6 7];
    [row,col]=size(L);         % dimensions of Event log matrix L
    [n,t]=size(unique(L));     % to find the unique activites in event log and storing it in variable n
    if ismember(0,L) == 1
        n=n-1;
    end
    %{
    C=[0     1     0     0     1
     0     0     1     1     0
     0     1     0     1     0
     0     0     0     0     0
     0     0     0     1     0];
    %}
    %C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0];
  %C=[0 1 1 0 0 0 0;0 0 0 1 1 0 0;0 0 0 1 0 1 0;0 0 0 0 1 1 0;0 0 0 0 0 0 1;0 0 0 0 0 0 1;0 0 0 0 0 0 0]
  %C=[0 1 1 0 0 0 0;0 0 0 1 0 0 0;0 0 0 1 0 0 0;0 0 0 0 1 1 0;0 0 0 0 0 0 1;0 0 0 0 0 0 1;0 0 0 0 0 0 0]
  %C=[0 0 1 0 0 0 0;0 0 0 0 0 0 0;0 0 0 1 0 0 0;0 0 0 0 0 1 0;0 0 0 0 0 0 0;0 0 0 0 0 0 1;0 0 0 0 0 0 0]
  %C=[0 1 1 0 0 0 0;0 0 0 1 1 0 0;0 0 0 1 0 1 0;0 0 0 0 1 1 0;0 0 0 0 0 0 1;0 0 0 0 0 0 1;0 0 0 0 0 0 0]

 C=[0     0     1     0     1;
     0     0     1     1     0;
     0     1     0     1     0;
     0     0     0     0     0;
     0     0     0     0     0]
%}
%TracesMissingTokens=[];                       % storing traces with missing tokens
%TracesExtraTokensLeftBehind=[];               % storing traces with extra tokens
%maxAllEnabledActivities = maxEnabledActivities(population,populationSize,L,row,col,n);

%count missing tokens and traces in which tokens are missing
[maxr,indexesr,maxc,indexesc] = maxones(C,n);

[MissingTokenSplit,TracesMissingTokensplit] = missingtokensplit(L,row,col,C,maxr,indexesr);
[MissingTokenJoin,TracesMissingTokenjoin] = missingTokenJoin(L,row,col,C,maxc,indexesc);
allMissingTokens = MissingTokenSplit+MissingTokenJoin;
numTracesMissingTokens=length(union(TracesMissingTokensplit,TracesMissingTokenjoin));

%count extra tokens and traces in which tokens are extra

[ExtraTokenSplit,TracesExtraTokensLeftBehindSplit]= extraTokenSplit(L,row,col,C,maxr,indexesr);
[ExtraTokenJoin,TracesExtraTokenjoin] = extratokenjoin(L,row,col,C,maxc,indexesc);
allExtraTokensLeftBehind = ExtraTokenSplit+ExtraTokenJoin;
numTracesExtraTokensLeftBehind=length(union(TracesExtraTokensLeftBehindSplit,TracesExtraTokenjoin));

numTracesLog=row;

punishment =((allMissingTokens)/(numTracesLog-numTracesMissingTokens+1))+ ((allExtraTokensLeftBehind)/(numTracesLog - numTracesExtraTokensLeftBehind+ 1));
allParsedActivities = parsedActivities(C,L,row,col);
numActivitiesLog = activities(L,row,col);

Completeness =(allParsedActivities - punishment)/numActivitiesLog;
end