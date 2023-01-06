function main
   diary('E:\Paper6 multi-objective DE\DE & NSGA-II results\DEnew results for function computation\BPI2012run23.txt');
    clc;                       % clears the window screen
    clear all;                 % clears the workspace and variables
    L=csvread('converted_2012.csv');
    [row,col]=size(L);         % dimensions of Event log matrix L
    [n,t]=size(unique(L));     % to find the unique activites in event log and storing it in variable n
    if ismember(0,L) == 1
        n=n-1;
    end
    popSize=100;
    run=2;
    iterArray=zeros(1,run);
    timeArray=zeros(1,run);
    gentimeArray1=zeros(1,run);
    comtimeArray1=zeros(1,run);
    geniterArray1=zeros(1,run);
    comiterArray1=zeros(1,run);
    for r=1:run
        runtime=tic;
        %tic
        %disp('......... initialization ............');
        [population,genArray,compArray,D,follow,comiter1,geniter1,comtime1,gentime1] = Initialization(L,row,col,n,popSize);    % population is the initial population used for genetic algorithm
        %toc     
                
        prevGen=zeros(1,2*popSize);
            prevComp=zeros(1,2*popSize);
            %prevPrec=zeros(1,2*popSize);
            %prevSim=zeros(1,2*popSize);
        count=0;  
        oldfront=zeros(n,n,popSize);
        count1=0;
         indexa=1;
         array1=[];
         iter=100;
         gentimeArray=zeros(1,iter);
    comtimeArray=zeros(1,iter);
    geniterArray=zeros(1,iter);
    comiterArray=zeros(1,iter);
       for m=1:iter   
        
        %tic
       % disp('.........Differencial evolution ............');
        [pool,gen1Array,comp1Array,comiter2,geniter2,comtime2,gentime2] = DE1(population,popSize,L,row,col,n,follow);        
        %toc
         gentimeArray(m)=gentime2;
    comtimeArray(m)=comtime2;
    geniterArray(m)=geniter2;
    comiterArray(m)=comiter2;
         %tic
       % disp('.........recombination ............');
        [childpop,childgenArray,childcompArray,popSize1] = recombination(population,genArray,compArray,pool,gen1Array,comp1Array,popSize,n);
        
       %toc
       
        %tic
        %disp('......... nonDominatedSort ............');
       [Childpopulation,fit1,Com1,finalfront,fit2,Com2]=NonDominatedSorting(childpop,n,popSize1,popSize,childcompArray,childgenArray);% find non dominated solutions from this population using NSGA-II
    
    Com2;
    fit2; 
    prevComp;
    prevGen;
     for i=1:15      
          Com21(i)=Com2(i);
          prevComp1(i)=prevComp(i);
     end
     Com21;
     prevComp1;
    % stopping criteria if non-dominated solution of previous iteration is
    % same as current iteration and coutn>5 stop iterations.
    isequalAbs = @(x,y,tol) ( abs(x-y) <= tol );
    
    if isequalAbs(Com21, prevComp1, 0.015)  
                    count = count+1;
                else
                    count=0;
                end
 if count>=5
       break
  end               
    %{
     if isequal(Com2,prevComp) == 1 && isequal(fit2,prevGen) == 1  
                    count = count+1;
                else
                    count=0;
                end
                if count>=5
                      break
                end
            %}
            %prevFront=currentFront;
            prevGen=fit2;
            prevComp=Com2;
            %prevPrec=currentPrec;
            %prevSim=currentSim; 
     %PplusCFitness;
    %[elitism,fitness] = Elitism(PplusC,PplusCFitness,Totalsize,PopSize,n);   % elitism will contain fittest individuals(causality matrices)
    population=Childpopulation;
   genArray=fit1;
   compArray=Com1;
  
    
    %fitnessArr(i,:)=fitness;
    %fitness;
    %m
    %disp('-------------------------------------------------------------------------------');
    %sz=10;
    %fig1= scatter(Com1,fit1,sz,'filled','blue');% to plot the points of each iterations
    hold on % to hold the output till last iteration
    xlabel('Completeness')
    ylabel('generalization')
    m;
    %saveas(fig1,'E:\Paper6 multi-objective DE\2013BPI2.jpg')  
       end
   
    
   for i=1:popSize       
       if Com2(:,i)==0 && fit2(:,i)==0
           array1(indexa)=i;
            indexa=indexa+1;
       end       
   end
    finalfront(:,:,array1)=[];
   Com2(:,array1)=[] 
   fit2(:,array1)=[]
   sz=20;
   scatter(Com2,fit2,sz,'filled','red')
   plot(Com2,fit2) % display only the last firstfront on line graph
   
   length(Com2);
   SimplicityArr=zeros(1,length(Com2));
   PrecisenessArr=zeros(1,length(Com2));
   parfor d =1:length(Com2)        
        SimplicityArr(d)=simplicity(finalfront(:,:,d),n);
        PrecisenessArr(d) = preciseness(L,row,col,finalfront(:,:,d),n); 
        
    end
   SimplicityArr
   PrecisenessArr
   
    iterArray(r)=m 
        timeArray(r)=toc(runtime) 
         gentimeArray1(r)=gentime1+sum(gentimeArray)
    comtimeArray1(r)=comtime1+sum(comtimeArray)
    geniterArray1(r)=geniter1+sum(geniterArray)
    comiterArray1(r)=comiter1+sum(geniterArray)
      
    end
     gentimeArray1
    comtimeArray1
    geniterArray1
    comiterArray1
   
    iterArray
    timeArray 
    
      
    end
        
  
   