function [Childpopulation,fit1,Com1,finalfront,fit2,Com2]=NonDominatedSorting(PplusC,n,Totalsize,PopSize,PplusCcompleteness,PplusCgeneralization)

individual = [];

fit1=[];
Com1=[];
count=0;
Childpopulation=[];
fit2=[];
Com2=[];
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
    individual;
    count1=count1+1;
    array;
    
    if count>PopSize
        [values,indices] = sort(PplusCcompleteness(array),'descend');
        for i=1:length(indices)
            %disp('......... 1 ............');
            Childpopulation=cat(3,Childpopulation, PplusC(:,:,array(indices(i))));   % finally taking out top popSize matrices
            fit1=[fit1 PplusCgeneralization(array(indices(i)))];
            Com1=[Com1 PplusCcompleteness(array(indices(i)))];
            if  length(Childpopulation)==PopSize
                break
            end
        end
    else
        %disp('......... 2 ............');
        Childpopulation =cat(3,Childpopulation, cat(3,PplusC(:,:,array)));%concatenating three dimensional matrix
        fit1=[fit1 PplusCgeneralization(array)];
        Com1=[Com1 PplusCcompleteness(array)];
    end 
   Childpopulation;
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
               % disp('......... 3 ............');
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


























%{
%fit=zeros(1,PopSize);
%Com=zeros(1,PopSize);
fit1=zeros(1,PopSize);
Com1=zeros(1,PopSize);

%Rank2=zeros(n,n,Totalsize);
%Rank1=zeros(n,n,Totalsize);
indexr=1;
count=0;

%Childpopulation=zeros(n,n,PopSize);
                % maintain index of pool to be created
ind1=1;                 % index to count the final selected pool
while count<PopSize
    list1=1:Totalsize;% creating a list to maintain unused index
    count1=0;
    %Rank2=[]
    %fit=[]
    %Com=[]
    index=1;
    array=[];
    indexa=1;
    for i=1:floor(Totalsize/2)    % half the popsize becoz of each player will play once for each participation
        ind2=size(list1,2);      % index to count current size of list
        j1=randi([1,ind2]);      % randomly taking a no within the list size range
        a1=list1(j1)           % choosing that value of the index
        list1(j1)=[];            % reducing list by deleting the used index
        ind2=ind2-1;
        j2=randi([1,ind2]);
        a2=list1(j2)
        list1(j2)=[];
        
        %multiobjective selection
        if PplusCcompleteness(a1) >= PplusCcompleteness(a2)&& PplusCgeneralization(a1)>= PplusCgeneralization(a2)%checking which one has better fitness
            Rank2(:,:,index) = PplusC(:,:,a1);    % store the one with better fitness in pool
            count1=count1+1;
            %fit(index)=PplusCgeneralization(a1);
            %Com(index)=PplusCcompleteness(a1);
            index=index+1;
            
        elseif PplusCcompleteness(a1) <= PplusCcompleteness(a2)&& PplusCgeneralization(a1)<= PplusCgeneralization(a2)
            Rank2(:,:,index) = PplusC(:,:,a2);
            count1=count1+1;
            %fit(index)=PplusCgeneralization(a2);
            %Com(index)=PplusCcompleteness(a2);
            index=index+1;
            
        else
            
            array(indexa)=a1
            Rank1(:,:,indexr) = PplusC(:,:,a1);
            fit1(indexr)=PplusCgeneralization(a1);
            Com1(indexr)=PplusCcompleteness(a1);
            indexr=indexr+1;
            indexa=indexa+1;
            count=count+1
            
            
            if count>=PopSize
                break
            end
            array(indexa)=a2
            Rank1(:,:,indexr) = PplusC(:,:,a2);
            fit1(indexr)=PplusCgeneralization(a2);
            Com1(indexr)=PplusCcompleteness(a2);
            indexr=indexr+1;
            count=count+1
            indexa=indexa+1;
        end
        ind1=ind1+1;
        ind2=ind2-1;
        if count>=PopSize
            break
        end
        
    end
    array
    
    count
    PplusC(:,:,array)=[]
    Totalsize=length(PplusC)
    PplusCgeneralization(:,array)=[]
    PplusCcompleteness(:,array)=[]
    
    
end
Childpopulation=Rank1
PplusCgeneralization1=fit1
PplusCcompleteness1=Com1

end

%{
    for j=2:Totalsize
        if PplusCcompleteness(i) >= PplusCcompleteness(j)&& PplusCgeneralization(i)>= PplusCgeneralization(j)%checking which one has better fitness
            Rank2(:,:,index) = PplusC(:,:,i);      % store the one with better fitness in pool
            %individual(index) = j
            fit(index)=PplusCgeneralization(i);
            Com(index)=PplusCcompleteness(i);
            index=index+1;
        elseif PplusCcompleteness(i) <= PplusCcompleteness(j)&& PplusCgeneralization(i)<= PplusCgeneralization(j)%checking which one has better fitness
            Rank2(:,:,index) = PplusC(:,:,j) ;     % store the one with better fitness in pool
            %a=[j]
            fit(index)=PplusCgeneralization(j);
            Com(index)=PplusCcompleteness(j);
            index=index+1;
        else
            i
            %individual(i)(indexr)=[j]
            Rank1(:,:,index) =(PplusC(:,:,j);
            index=index+1;
            %Rank1=(Rank1 PplusC(:,:,i))
        end
        Rank1
    end
%end
end
%}
%{
are assigned rank 2 and so on. After assigning the rank the crowding in each front is calculated.

%[N, m] = size(x);
%clear m

% Initialize the front number to 1.
end
%{
%This function sort the current popultion based on non-domination. All the individuals in the first front are given a rank of 1, the second front individual

%Non-Dominated sort.

%The initialized population is sorted based on non-domination. The fast sort algorithm [1] is described as below for each

% � for each individual p in main population P do the following
%   � Initialize Sp = []. This set would contain all the individuals that is
%     being dominated by p.
%   � Initialize np = 0. This would be the number of individuals that domi-
%     nate p.
%   � for each individual q in P
%       * if p dominated q then
%           � add q to the set Sp i.e. Sp = Sp ? {q}
%       * else if q dominates p then
%           � increment the domination counter for p i.e. np = np + 1
%   � if np = 0 i.e. no individuals dominate p then p belongs to the first
%     front; Set rank of individual p to one i.e prank = 1. Update the first
%     front set by adding p to front one i.e F1 = F1 ? {p}
% � This is carried out for all the individuals in main population P.
% � Initialize the front counter to one. i = 1
% � following is carried out while the ith front is nonempty i.e. Fi != []
%   � Q = []. The set for storing the individuals for (i + 1)th front.
%   � for each individual p in front Fi
%       * for each individual q in Sp (Sp is the set of individuals
%         dominated by p)
%           � nq = nq?1, decrement the domination count for individual q.
%           � if nq = 0 then none of the individuals in the subsequent
%             fronts would dominate q. Hence set qrank = i + 1. Update
%             the set Q with individual q i.e. Q = Q ? q.
%   � Increment the front counter by one.
%   � Now the set Q is the next front and hence Fi = Q.
%
% This algorithm is better than the original NSGA ([2]) since it utilize
% the informatoion about the set that an individual dominate (Sp) and
% number of individuals that dominate the individual (np).

%
%}
%{

% Initialize the front number to 1.
front = 1;
F(front).f = [];
individual = [];
pool=zeros(1,Totalsize)
%count=0
for i = 1 : Totalsize
    % Number of individuals that dominate this individual
    individual(i).n = 0
    % Individuals which this individual dominate
    individual(i).p = []
    for j = 2: Totalsize
        PplusCcompleteness(i);
        PplusCcompleteness(j);
        i;
        j
        PplusCgeneralization(i);
        PplusCgeneralization(j);
        if PplusCcompleteness(i) >= PplusCcompleteness(j)&& PplusCgeneralization(i)>= PplusCgeneralization(j)
            individual(i).p = [j]
        else
            individual(i).n = individual(i).n + 1;
        end
    end
end
end
%}
%}
%}
