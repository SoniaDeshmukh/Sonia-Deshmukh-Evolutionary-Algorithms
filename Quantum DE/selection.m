function pool = selection(population,n,populationSize,rank,crowdingDistance,nextComp,nextSim)
    pool=zeros(n,n,populationSize);
    index=1;                % maintain index of pool to be created
    ind1=1;                 % index to count the final selected pool
    for phase=1:2           % each chromosome will play twice with each other
        list1=1:populationSize;       % creating a list to maintain unused index
        for i=1:round(populationSize/2)    % half the popsize becoz of each player will play once for each participation
            %flag=0;
            %while(flag==0)
                ind2=size(list1,2);      % index to count current size of list
                j1=randi([1,ind2]);      % randomly taking a no within the list size range
                a1=list1(j1);            % choosing that value of the index
                list1(j1)=[];            % reducing list by deleting the used index
                ind2=ind2-1;
                j2=randi([1,ind2]);
                a2=list1(j2);
                list1(j2)=[];
                if ((rank(a1)<rank(a2)) || (rank(a1)==rank(a2) && crowdingDistance(a1)>crowdingDistance(a2)))&&(nextComp(a1)~=0)&&(nextSim(a1)~=Inf)
                    pool(:,:,index) = population(:,:,a1);      % store the one with better fitness in pool
                    index=index+1;
              %      flag=1;
                elseif (nextComp(a2)~=0)&&(nextSim(a2)~=Inf)
                     pool(:,:,index) = population(:,:,a2);
                     index=index+1;
             %        flag=1;
                end                        
                ind1=ind1+1;
                ind2=ind2-1;
            %end
        end
    end
end