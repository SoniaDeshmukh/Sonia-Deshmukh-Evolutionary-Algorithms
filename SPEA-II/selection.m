function [pool] = selection(PplusC,Totalsize,PplusCcompleteness,PplusCgeneralization,n)
    pool=zeros(n,n,Totalsize);
    index=1;                % maintain index of pool to be created
    ind1=1;                 % index to count the final selected pool
    for phase=1:2           % each chromosome will play twice with each otherg
        list1=1:Totalsize ;      % creatin a list to maintain unused index
        for i=1:round(Totalsize/2)    % half the popsize becoz of each player will play once for each participation
            ind2=size(list1,2);      % index to count current size of list
            j1=randi([1,ind2]);      % randomly taking a no within the list size range
            a1=list1(j1) ;         % choosing that value of the index
            list1(j1)=[];            % reducing list by deleting the used index
            ind2=ind2-1;
            j2=randi([1,ind2]);
            a2=list1(j2);
            list1(j2)=[];
            %multiobjective selection
            if PplusCcompleteness(a1) >= PplusCcompleteness(a2)&& PplusCgeneralization(a1)>= PplusCgeneralization(a2)%checking which one has better fitness
                pool(:,:,index) = PplusC(:,:,a1);      % store the one with better fitness in pool                
                index=index+1;               
            elseif PplusCcompleteness(a1) <= PplusCcompleteness(a2)&& PplusCgeneralization(a1)<= PplusCgeneralization(a2)
                 pool(:,:,index) = PplusC(:,:,a2);                 
                 index=index+1;              
            else
                if PplusCcompleteness(a1) > PplusCcompleteness(a2)
                    pool(:,:,index) = PplusC(:,:,a1);
                    index=index+1;
                else
                    pool(:,:,index) = PplusC(:,:,a2);
                    index=index+1;
                end   
            end                        
            ind1=ind1+1;
            ind2=ind2-1;
        end
    end
end