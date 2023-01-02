function main
%diary('F:\ouput\abc.txt');
tic
clc;                       % clears the window screen
clear all;                 % clears the workspace and variables
L=csvread('2013BPI.txt');
[row,col]=size(L);         % dimensions of Event log matrix L
[n,t]=size(unique(L));     % to find the unique activites in event log and storing it in variable n
if ismember(0,L) == 1
    n=n-1;
end
PopSize=100;
run=50;
iterArray=zeros(1,run);
timeArray=zeros(1,run);
for r=1:run    
    count1=0;
    iter=100;
    runtime=tic;
   [population,D] = Initialization(L,row,col,n,PopSize);     % population is the initial population used for genetic algorithm
    indexa=1;
    array1=[];
    oldfront=zeros(n,n,PopSize);
    for a=1:iter
        [pool,GeneralizationArr,CompletenessArr] = selection(population,n,L,row,col,PopSize); % binary tournament selection
        [poolNew,x]= Crossover(pool,n,PopSize);  % poolnew will contain the population after performing crossover
        mutation = Mutation(poolNew,n,x);% mutation will contain individuals obtained after performing mutation operation
        Filterpopulation = filterFun(mutation,x,D,n);% filter the mutated population so that it doesnot deviate from D
        [PplusC,Totalsize,PplusCcompleteness,PplusCgeneralization] = PopsPlusChild(population,GeneralizationArr,CompletenessArr,PopSize,Filterpopulation,x,n,L,row,col);% merge initial population and filtered population
        [Childpopulation,fit1,Com1,finalfront,fit2,Com2]=NonDominatedSorting(PplusC,n,Totalsize,PopSize,PplusCcompleteness,PplusCgeneralization);% find non dominated solutions from this population using NSGA-II
        % stopping criteria if non-dominated solution of previous iteration is same as current iteration and coutn>5 stop iterations.
        if oldfront==finalfront
            count1=count1+1;
        end
        oldfront=finalfront;
        if count1>=5
            break
        end
        scatter(Com1,fit1)% to plot the points of each iterations
        hold on % to hold the output till last iteration
        xlabel('Completeness')
        ylabel('generalization')
        population=Childpopulation;        
    end
     iterArray(r)=a;
    timeArray(r)=toc(runtime);
for i=1:PopSize
    if Com2(:,i)==0 && fit2(:,i)==0 || Com2(:,i)==Com2(:,i+1) 
        array1(indexa)=i;
        indexa=indexa+1;
    end
end
Com2(:,array1)=[]
fit2(:,array1)=[]
plot(Com2,fit2) % display only the last firstfront on line graph
end
iterArray
timeArray
end
