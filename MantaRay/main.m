function main
    %diary('E:\Mantarays\SOMantaray\Processminingmantarayscode\finalresults30pop100iter30runs\2012BPI1,.txt');    
    clc;                       % clears the window screen
    clear all;                 % clears the workspace and variables
    L=csvread('2013BPI.txt');
    [row,col]=size(L) ;       % dimensions of Event log matrix L
    [n,t]=size(unique(L)) ;   % to find the unique activites in event log and storing it in variable n
    if ismember(0,L) == 1
        n=n-1;
    end
    Dim=n;
    Low=zeros(n,n);
    Up=ones(n,n);
    MaxIteration=100;
    PopSize=30;
    run=30;
    iterArray=zeros(1,run);
    timeArray=zeros(1,run);
    comptimeArray=zeros(1,run);    
    for r=1:run
         tStart=tic;                
        [D] = Initialization(L,row,col,n);            
        [bst,BestF,HisBestF,PopFitF,completenesstime,It]=MRFO1(Dim,Low,Up,MaxIteration,PopSize,L,row,col,D);
        HisBestF
        PopFitF
        genArray=generalization(bst,L,row,col,n);
        precArray=preciseness(L,row,col,bst,n);
        sim=simplicity(bst,n);        
        timeArray(r)=toc(tStart)
        iterArray(r)=It 
        comArray(r)=BestF
        genArray1(r)=genArray
        simArray2(r)=sim 
        precArray1(r)=precArray
        comptimeArray(r)=completenesstime
    end 
    iterArray
    comArray
    genArray1
    simArray2
    precArray1
   comptimeArray    
    timeArray   
    end
        
  
   