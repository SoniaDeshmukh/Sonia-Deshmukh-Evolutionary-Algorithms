function main
%diary('E:\Mantarays\SingleobjectiveGPM\finalGPM30pop30run100iter\2014BPI5runs.txt');
clc;                       % clears the window screen
clear all;                 % clears the workspace and variables
L=csvread('2013BPI.txt');
[row,col]=size(L);         % dimensions of Event log matrix L
[n,t]=size(unique(L));     % to find the unique activites in event log and storing it in variable n
if ismember(0,L) == 1
    n=n-1;
end
PopSize=30;
run=30;
iterArray=zeros(1,run);
timeArray=zeros(1,run);
comptimeArray=zeros(1,run);
compiterArray=zeros(1,run);
for r=1:run
    count=0;
    iter=100;
    PopFitF=zeros(iter,PopSize);
    runtime=tic;
    comtime1=0;
    comiter=0;
    [population,Completeness,comtime,D] = Initialization(L,row,col,n,PopSize);    % population is the initial population used for genetic algorithm
    for a=1:iter
        [pool] = selection(population,Completeness,n,PopSize); % binary tournament selection
        [poolNew,x]= Crossover(pool,n,PopSize);  % poolnew will contain the population after performing crossover
        mutation = Mutation(poolNew,n,x);% mutation will contain individuals obtained after performing mutation operation
        Filterpopulation = filterFun(mutation,x,D,n);% filter the mutated population so that it doesnot deviate from D
        [PplusC,PplusCcompleteness,comiter2,comtime2] = PopsPlusChild(population,Completeness,PopSize,Filterpopulation,x,n,L,row,col);% merge initial population and filtered population
        [childpop,childFitnessArray] = Elitism(PplusC,PplusCcompleteness,PopSize,n); % elitism will contain fittest individuals(causality matrices)
        comiter=comiter+comiter2;
        comtime1=comtime1+comtime2;
        oldFitness=Completeness;
        childcomp=childFitnessArray; %just to sort Fitness and childcompArray we stored them in a different array
        population=childpop;
        Completeness=childFitnessArray;
        [childcomp]=sort(childcomp,'descend');
        [oldFitness]=sort(oldFitness,'descend');
        PopFitF(a,:)=childcomp;
        if isequal(oldFitness,childcomp) == 1%isequal(currentComp,prevComp) == 1 && isequal(currentGen,prevGen) == 1 && isequal(currentPrec,prevPrec) == 1
            count = count+1;
        else
            count=0;
        end
        if count>=5
            break
        end
    end
    [compArray1,sortIdx] = sort(childFitnessArray,'descend');
    r
    % sort B using the sorting index
    A1 = childpop(:,:,sortIdx);
    bst=A1(:,:,1)
    compbst=compArray1(:,1);
    genArray=generalization(bst,L,row,col,n);
    precArray=preciseness(L,row,col,bst,n);
    sim=simplicity(bst,n);
    PopFitF
    iterArray(r)=a
    timeArray(r)=toc(runtime)
    comArray(r)=compbst
    genArray1(r)=genArray
    simArray2(r)=sim
    precArray1(r)=precArray
    comptimeArray(r)=comtime+comtime1
    compiterArray(r)=PopSize+comiter
end
iterArray
comArray
genArray1
simArray2
precArray1
comptimeArray
timeArray
end

