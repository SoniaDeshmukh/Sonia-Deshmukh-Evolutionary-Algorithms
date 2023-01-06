function [nextPopulation,nextRank,crowdingDistance,nextGen,nextComp,nextPrec,nextSim] = crowding_distance(front,frontGen,frontComp,frontPrec,frontSim,frontCount,frontCountArr,popSize,childpop,n)
 % Here, popSize is twice the size of the population,ie, 2N.
 % So we need to do popSize/2 which will give us size N.
 
    crowdingDistance=zeros(1,popSize);
    nextPopulation=zeros(n,n,popSize);
    nextRank=zeros(1,popSize);
    nextGen=zeros(1,popSize);
    nextComp=zeros(1,popSize);
    nextPrec=zeros(1,popSize);
    nextSim=zeros(1,popSize);
    size=0;
    i=1;
    while(size<popSize/2 && i<=frontCount)
        n=frontCountArr(i);
        distance=zeros(1,n);
        distance1=zeros(1,n);
        objective=zeros(4,n);
        %distancs2=zeros(n,n);
        for p=1:n
            objective(1,p)=frontGen(i,p);
            objective(2,p)=frontComp(i,p);
            objective(3,p)=frontPrec(i,p);
            objective(4,p)=frontSim(i,p);
        end
        for m=1:4
            %{
            for j=1:n
             distancs2(i,j)=sqrt(((objective(1,i))-(objective(1,j)))^2+((objective(2,i))-(objective(2,j)))^2+((objective(3,i))-(objective(3,j)))^2+((objective(4,i))-(objective(4,j)))^2)
            end
            %}
             [a,ind]=sort(objective(m,:));            
            objective(:,:)=objective(:,ind);
            front(i,1:n)=front(i,ind);           
            distance(1)=Inf(1,1);
            distance(n)=Inf(1,1);
            for j=2:n-1
                distance(j)=distance1(j-1)+objective(m,j+1)-objective(m,j-1);
                distance1(j)=distance(j);
                
            end
            
        end
        
        for j=1:n
            
            nextPopulation(:,:,size+1)=childpop(:,:,front(i,j));
            nextRank(size+1)=i;
            crowdingDistance(size+1)=distance(j);
            nextGen(size+1)=frontGen(i,j);
            nextComp(size+1)=frontComp(i,j);
            nextPrec(size+1)=frontPrec(i,j);
            nextSim(size+1)=frontSim(i,j);
            size=size+1 ;
        end
         
        i=i+1;
    end
    %disp('... crowding ....');
   % nextPopulation
    crowdingDistance(size+1:popSize)=[];
    nextPopulation(:,:,size+1:popSize)=[];
    nextRank(size+1:popSize)=[];
    nextGen(size+1:popSize)=[];
    nextComp(size+1:popSize)=[];
    nextPrec(size+1:popSize)=[];
    nextSim(size+1:popSize)=[];
    if size > popSize/2
        a=size;
        while(a>=2 && (nextRank(a) == nextRank(a-1)))
            a=a-1;
        end
        [sortDist,index]=sort(crowdingDistance(a:size));
        extra=size-(popSize/2);
        nextPopulation(:,:,index(1:extra))=[];
        nextRank(index(1:extra))=[];
        crowdingDistance(index(1:extra))=[];
         nextGen(index(1:extra))=[];
        nextComp(index(1:extra))=[];
         nextPrec(index(1:extra))=[];
        nextSim(index(1:extra))=[];
    end
end