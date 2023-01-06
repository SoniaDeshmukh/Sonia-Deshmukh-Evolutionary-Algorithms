function [rank,Front,frontGen,frontComp,frontPrec,frontSim,frontCountArr,frontCount] = nonDominatedSort(childpop,childgenArray,childcompArray,childprecArray,childsimArray,popSize1,L,row,col,n)
    
    dominate=zeros(popSize1,popSize1);
    dominatedCount=zeros(1,popSize1);
    rank=zeros(1,popSize1);
    Front=zeros(popSize1,popSize1);
    frontGen=zeros(popSize1,popSize1);
    frontComp=zeros(popSize1,popSize1);
    frontPrec=zeros(popSize1,popSize1);
    frontSim=zeros(popSize1,popSize1);
    frontCountArr=zeros(1,popSize1);
     
    ind2=1;       % column no for front array
    count=0;
    %distancs2=zeros(popSize1,popSize1);
    for i=1:popSize1
        ind1=1;       % column no for dominate array
        for j=1:popSize1
            if i~=j
                flag=evalObjective(childgenArray(j),childcompArray(j),childprecArray(j),childsimArray(j),childgenArray(i),childcompArray(i),childprecArray(i),childsimArray(i));
                if flag == 0             %  i dominates j
                    %disp('...... flag = 0 ....................');
                    dominate(i,ind1)=j;
                    ind1=ind1+1;
                elseif flag==1
                    dominatedCount(i)=dominatedCount(i)+1;
                end
            end
            % distancs2(i,j)=sqrt(((childgenArray(i))-(childgenArray(j)))^2+((childcompArray(i))-(childcompArray(j)))^2+((childprecArray(i))-(childprecArray(j)))^2+((childsimArray(i))-(childsimArray(j)))^2);
             
        end                 
         %distance11(i,:)=sort(distancs2(i,:));         
     
    end
    
    %min(distance11)
   % dominate
   % dominatedCount
    for i = 1:popSize1
        if dominatedCount(i)==0
            Front(1,ind2)=i;
            frontGen(1,ind2)=childgenArray(i);
            frontComp(1,ind2)=childcompArray(i);
            frontPrec(1,ind2)=childprecArray(i);
            frontSim(1,ind2)=childsimArray(i);
            ind2=ind2+1;
            rank(i)=1;
            count=count+1;
        end
        %{
        Front(1,i)            
            nextPopulation(:,:,i)=childpop(:,:,Front(1,i))          
            %crowdingDistance(i)=distance(j);
            nextGen(i)=frontGen(1,i)
            nextComp(i)=frontComp(1,i)
            nextPrec(i)=frontPrec(1,i)
            nextSim(i)=frontSim(1,i)            
        %}
    end
    
    frontCountArr(1)=count;
    frontCount=1;
    while count > 0
        countNew=0;
        col=1;
        for i=1:count
            j=1;
            while dominate(Front(frontCount,i),j) ~= 0
                %disp('..... while.........');
                dominatedCount(dominate(Front(frontCount,i),j))=dominatedCount(dominate(Front(frontCount,i),j))-1;
                if dominatedCount(dominate(Front(frontCount,i),j)) == 0
                    %disp('.... next front.....');
                    rank(dominate(Front(frontCount,i),j))=frontCount+1;
                    Front(frontCount+1,col)=dominate(Front(frontCount,i),j);
                    frontGen(frontCount+1,col)=childgenArray(dominate(Front(frontCount,i),j));
                    frontComp(frontCount+1,col)=childcompArray(dominate(Front(frontCount,i),j));
                    frontPrec(frontCount+1,col)=childprecArray(dominate(Front(frontCount,i),j));
                    frontSim(frontCount+1,col)=childsimArray(dominate(Front(frontCount,i),j));
                    col=col+1;
                    countNew=countNew+1;
                 
                end
                j=j+1;
            end
        end
       
        frontCount=frontCount+1;
        count=countNew;
        frontCountArr(frontCount)=countNew;
    end
    m=max(frontCountArr);
    frontCountArr(frontCount:popSize1)=[];
    Front(frontCount:popSize1,:)=[];
    frontGen(frontCount:popSize1,:)=[];
    frontComp(frontCount:popSize1,:)=[];
    frontPrec(frontCount:popSize1,:)=[];
    frontSim(frontCount:popSize1,:)=[];
    
    Front(:,m+1:popSize1)=[];
    frontGen(:,m+1:popSize1)=[];
    frontComp(:,m+1:popSize1)=[];
    frontPrec(:,m+1:popSize1)=[];
    frontSim(:,m+1:popSize1)=[];
    
    frontCount=frontCount-1;
    %disp('............ nd sort .........................')
    B=zeros(n,n,populationSize);
    parfor k=1:populationSize
       
        B(:,:,k)= ;   % if (r < D^p)  , then  1
                               % otherwise 0
    end
    %Front
    
end