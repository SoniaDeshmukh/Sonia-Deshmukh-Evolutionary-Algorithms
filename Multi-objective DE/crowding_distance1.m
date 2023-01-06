[nextPopulation,nextRank,crowdingDistance,nextGen,nextComp,nextPrec,nextSim] = crowding_distance1(Front,frontGen,frontComp,frontPrec,frontSim,frontCount,frontCountArr,popSize,childpop,n);
while i<popSize

distancs2(j)=sqrt(((populationcompleteness(i))-(populationcompleteness(j)))^2+((populationgeneralization(i))-( populationgeneralization(j)))^2);% distance of a individual from all the other individuals
        end
       
        for l=1:popSize
            distancs2(i,l)=distancs2(l);% each row of this matrix contains the distance of the individual from all other individual
        end