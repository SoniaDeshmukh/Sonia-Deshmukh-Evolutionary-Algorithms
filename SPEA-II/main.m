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
PopSize1=100;
run=50;
iterArray=zeros(1,run);
timeArray=zeros(1,run);
for r=1:run
    count1=0;
    iter=100;
    runtime=tic;
    archiveSize=10;
    [population1,D] = Initialization(L,row,col,n,PopSize1);     % population is the initial population used for genetic algorithm
    oldarchive=[];
    oldarchiveup=[];
    for a=1:iter
        [archive,fit1,Com1,archiveup,fit4,Com4,population,populationgeneralization,populationcompleteness]=NonDominatedSorting1(population1,oldarchive,archiveSize,PopSize1,L,row,col,n);
        [PplusC,Totalsize,PplusCcompleteness,PplusCgeneralization] = PopsPlusChild(population,archive,fit1,Com1,populationgeneralization,populationcompleteness,n,L,row,col);
        [pool] = selection(PplusC,Totalsize,PplusCcompleteness,PplusCgeneralization,n);% binary tournament selection
        [list1,poolNew,x]= Crossover(pool,n,Totalsize);  % poolnew will contain the population after performing crossover
        mutation = Mutation(poolNew,n,x);% mutation will contain individuals obtained after performing mutation operation
        Filterpopulation = filterFun(mutation,x,D,n);
        [f,g,h]=size(Filterpopulation);
        indexr=h+1;
        for rw=1:length(list1)
            Filterpopulation(:,:,indexr)=pool(:,:,list1(rw));%concatenating three dimensional matrix
            indexr=indexr+1;
        end
        [f,g,h]=size(archiveup);
        [o,p,q]=size(oldarchiveup);
        if h==q && f==0 && g==p
            if oldarchiveup==archiveup
                count1=count1+1
            end
        end
        oldarchiveup=archiveup;
        if count1>=5
            break
        end        
        scatter(Com4,fit4)
        hold on
        xlabel('Completeness')
        ylabel('generalization')
        population1=Filterpopulation;
        oldarchive=archive;
    end
    iterArray(r)=a;
    timeArray(r)=toc(runtime);
    Com4
    fit4
    plot(Com4,fit4)
end
iterArray
timeArray
end
