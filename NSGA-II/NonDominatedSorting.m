function [Childpopulation,fit1,Com1,finalfront,fit2,Com2]=NonDominatedSorting(PplusC,n,Totalsize,PopSize,PplusCcompleteness,PplusCgeneralization)
individual = [];
fit1=[];
Com1=[];
count=0;
Childpopulation=[];
count1=0;
finalfront=zeros(n,n,PopSize);
fit2=zeros(1,PopSize);
Com2=zeros(1,PopSize);
while count<PopSize   
    array=[];
    indexa=1;    
    for i = 1 : Totalsize
        % Number of individuals that dominate this individual
        individual.n = 0;
        % Individuals which this individual dominate
        individual.p = [];        
        for j = 1: Totalsize            
            if PplusCcompleteness(i) >= PplusCcompleteness(j)&& PplusCgeneralization(i)>= PplusCgeneralization(j)                
                individual.p = [individual.p j];
            elseif PplusCcompleteness(i) <= PplusCcompleteness(j)&& PplusCgeneralization(i)<= PplusCgeneralization(j)                
                individual.n = individual.n + 1;
            end
        end
        if individual.n == 0
            array(indexa)=i;
            indexa=indexa+1;
            count=count+1;
        end        
    end
   count1=count1+1;   
    if count>PopSize
        [values,indices] = sort(PplusCcompleteness(array),'descend');
        for i=1:length(indices)
            Childpopulation=cat(3,Childpopulation, PplusC(:,:,array(indices(i))));   % finally taking out top popSize matrices
            fit1=[fit1 PplusCgeneralization(array(indices(i)))];
            Com1=[Com1 PplusCcompleteness(array(indices(i)))];
            if  length(Childpopulation)==PopSize
                break
            end
        end
    else
        Childpopulation =cat(3,Childpopulation, cat(3,PplusC(:,:,array)));%concatenating three dimensional matrix
        fit1=[fit1 PplusCgeneralization(array)];
        Com1=[Com1 PplusCcompleteness(array)];
    end 
    %to store the completeness and preciseness for  last iteration
    % this will store only first array (front)value then sort according to
    % one objective so that we can plot a line
    index=1;
    if count1==1
        front=array;
        PplusCgeneralization1=PplusCgeneralization;
        PplusCcompleteness1=PplusCcompleteness;
        Childpopulation1=PplusC;
        [values,indices] = sort(PplusCcompleteness1(front),'descend');
        if length(indices)>PopSize
            for i=1:PopSize
                finalfront(:,:,index)=Childpopulation1(:,:,front(indices(i)));    % finally taking out top popSize matrices
                fit2(index)=PplusCgeneralization1(front(indices(i)));
                Com2(index)=PplusCcompleteness1(front(indices(i)));
                index=index+1;
            end
        else
            for i=1:length(indices)
                finalfront(:,:,index)=Childpopulation1(:,:,front(indices(i)));    % finally taking out top popSize matrices
                fit2(index)=PplusCgeneralization1(front(indices(i)));
                Com2(index)=PplusCcompleteness1(front(indices(i)));
                index=index+1;
            end
        end        
        finalfront;
    end    
    PplusC(:,:,array)=[];
    PplusCgeneralization(:,array)=[];
    PplusCcompleteness(:,array)=[];
    Totalsize=length(PplusCgeneralization);
end
end


























