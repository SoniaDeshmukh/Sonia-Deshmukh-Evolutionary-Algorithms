function main
    %diary('E:\Paper3 single objective DE\singleobjectivePMDEcode\results\30pop100iterrlessthanD\g9.txt');
    tic
    clc;                       % clears the window screen
    clear all;                 % clears the workspace and variables
    L=csvread('converted_ETM.csv');
    [row,col]=size(L);         % dimensions of Event log matrix L
    [n,t]=size(unique(L));     % to find the unique activites in event log and storing it in variable n
    if ismember(0,L) == 1
        n=n-1;
    end
    popSize=30;
    run=30;
    iterArray=zeros(1,run);
    timeArray=zeros(1,run);
    comptimeArray=zeros(1,run);
    genArray1=zeros(1,run);
    comArray=zeros(1,run);
    simArray2=zeros(1,run);
    precArray1=zeros(1,run);
    childpop=zeros(n,n,popSize);
    childFitnessArray=zeros(1,popSize);
    for r=1:run
        tic;
        %tic
        %disp('......... initialization ............');
        [population,Fitness,comtime] = Initialization(L,row,col,n,popSize);     % population is the initial population used for genetic algorithm
        %toc       
        count=0;
        comtime1=0;
       for a=1:100       
        %tic
       % disp('.........Differencial evolution ............');        
        [pool,FitnessArray,comtime2] = DE1(population,popSize,L,row,col,n);
        comtime1=comtime1+comtime2;
        %toc        
        for t=1:popSize %If the candidate is better than the parent, the candidate replaces
       %sthe parent. Otherwise, the candidate is discarded.
            if (Fitness(t)>FitnessArray(t))
                childpop(:,:,t)=population(:,:,t);
                childFitnessArray(t)=Fitness(t);
            else
                childpop(:,:,t)=pool(:,:,t);
                childFitnessArray(t)=FitnessArray(t);
            end
        end        
        oldFitness=Fitness;
        childcomp=childFitnessArray;%just to sort Fitness and childcompArray we stored them in a different array
        population=childpop;
        Fitness=childFitnessArray;
         [childcomp]=sort(childcomp,'descend');
         [oldFitness]=sort(oldFitness,'descend');         
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
        sim=simplicity(bst,n)       
        toc;
        iterArray(r)=a 
        timeArray(r)=toc
        comArray(r)=compbst
        genArray1(r)=genArray
        simArray2(r)=sim 
        precArray1(r)=precArray
        comptimeArray(r)=comtime+comtime1
    end 
    iterArray
    comArray
    genArray1
    simArray2
    precArray1
   comptimeArray    
    timeArray
    end
        
  
   