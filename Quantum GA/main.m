function main
diary('E:\Paper5 single objective quantum algorithms\Code\SOQGeneticAlgorithmCode\results\BPI2018run9.txt');
tic
clc;                       % clears the window screen
clear all;                 % clears the workspace and variables
L=csvread('convertedr_2018.csv');
[row,col]=size(L);         % dimensions of Event log matrix L
[n,t]=size(unique(L));     % to find the unique activites in event log and storing it in variable n
if ismember(0,L) == 1
    n=n-1;
end
count=0;
run=9;
popSize=30;
iter=100;
iterArray=zeros(1,run);
timeArray=zeros(1,run);
comptimeArray=zeros(1,run);
genArray1=zeros(1,run);
comArray=zeros(1,run);
simArray1=zeros(1,run);
simArray2=zeros(1,run);
precArray1=zeros(1,run);
for r=1:run
    PopFitF=zeros(iter,popSize);
    runtime=tic;
    [A,compArray,comtime2,alpha,beta]= Initialization(L,row,col,n,popSize); % population is the initial population used for genetic algorithm
    comtime1=0;
    for a=1:iter
        [A1,compArray1,comtime,bst1,compbst1] = init1(n,beta,popSize,L,row,col);
        %compArray1
        [alpha1,beta1]=rotation(A1,compArray1,bst1,compbst1,alpha,beta,n,popSize);
        comtime1=comtime1+comtime;
        alpha=alpha1;
        beta=beta1;
        parfor t=1:popSize %If the candidate is better than the parent, the candidate replaces the parent. Otherwise, the candidate is discarded.
            if (compArray(t)>compArray1(t))
                childpop(:,:,t)=A(:,:,t);
                childFitness(t)=compArray(t);
            else
                childpop(:,:,t)=A1(:,:,t);
                childFitness(t)=compArray1(t);
            end
        end
        oldFitness=compArray;
        childcomp=childFitness; %just to sort Fitness and childcompArray we stored them in a different array
        A=childpop;
        compArray=childFitness;
        [childcomp]=sort(childcomp,'descend');
        [oldFitness]=sort(oldFitness,'descend');
        PopFitF(a,:)=childcomp;
        if isequal(oldFitness,childcomp)== 1%isequal(currentComp,prevComp) == 1 && isequal(currentGen,prevGen) == 1 && isequal(currentPrec,prevPrec) == 1
            count = count+1;
        else
            count=0;
        end
        if count>=5
            break
        end
    end
    [compArray1,sortIdx] = sort(childFitness,'descend');
    r
    % sort B using the sorting index
    B1 = childpop(:,:,sortIdx);
    bst=B1(:,:,1)
    compbst=compArray1(:,1);
    genArray=generalization(bst,L,row,col,n);
    precArray=preciseness(L,row,col,bst,n);
    %simArray = simplicity1(bst,n,row,col,L);
    sim=simplicity(bst,n);
    PopFitF
    iterArray(r)=a
    timeArray(r)=toc(runtime)
    comArray(r)=compbst
    genArray1(r)=genArray
    %simArray1(r)=simArray
    simArray2(r)=sim
    precArray1(r)=precArray
    comptimeArray(r)=comtime2+comtime1
end
iterArray
comArray
genArray1
simArray2
precArray1
comptimeArray
timeArray

end

%{
      if compbst1>compbst
         compbst=compbst1;
         bst=bst1;
     end
     alpha2
     beta2
     oldFitness=compArray;
        childcomp=comp1Array; %just to sort Fitness and childcompArray we stored them in a different array
         [childcomp]=sort(childcomp,'descend');
         [oldFitness]=sort(oldFitness,'descend');
     A=C1;
     compArray=comp1Array
     alpha=alpha2;
     beta=beta2;
%}

