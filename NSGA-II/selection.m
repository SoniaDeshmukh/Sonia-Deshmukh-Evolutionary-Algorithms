function [pool,GeneralizationArr,CompletenessArr] = selection(population,n,L,row,col,populationSize)      
    GeneralizationArr=zeros(1,populationSize);
    CompletenessArr=zeros(1,populationSize);  
    parfor i =1:populationSize       
        GeneralizationArr(i) = generalization(population(:,:,i),L,row,col,n);% find the generalization and completeness of complete population
        CompletenessArr(i) = completeness(population(:,:,i),n,L,row,col);        
    end
    pool=zeros(n,n,populationSize);
    index=1;                % maintain index of pool to be created
    ind1=1;                 % index to count the final selected pool
    for phase=1:2           % each chromosome will play twice with each otherg
        list1=1:populationSize;       % creatin a list to maintain unused index
        for i=1:round(populationSize/2)    % half the popsize becoz of each player will play once for each participation
            ind2=size(list1,2);      % index to count current size of list
            j1=randi([1,ind2]);      % randomly taking a no within the list size range
            a1=list1(j1);           % choosing that value of the index
            list1(j1)=[];            % reducing list by deleting the used index
            ind2=ind2-1;
            j2=randi([1,ind2]);
            a2=list1(j2);
            list1(j2)=[];
            %multiobjective selection
            if CompletenessArr(a1) >= CompletenessArr(a2)&& GeneralizationArr(a1)>= GeneralizationArr(a2)%checking which one has better fitness
                pool(:,:,index) = population(:,:,a1); % store the one with better fitness in pool                
                index=index+1;               
            elseif CompletenessArr(a1) <= CompletenessArr(a2)&& GeneralizationArr(a1)<= GeneralizationArr(a2)
                 pool(:,:,index) = population(:,:,a2);           
                 index=index+1;              
            else % if no one is dominating means can be multiobjective than selection is done on the basis of higher completeness
                if CompletenessArr(a1) > CompletenessArr(a2)
                    pool(:,:,index) = population(:,:,a1);                    
                    index=index+1;
                else
                    pool(:,:,index) = population(:,:,a2);
                    index=index+1;
                end   
            end                        
            ind1=ind1+1;
            ind2=ind2-1;
        end
    end
end