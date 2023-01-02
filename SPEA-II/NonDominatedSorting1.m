function [archive,fit1,Com1,archiveup,fit4,Com4,population,populationgeneralization,populationcompleteness]=NonDominatedSorting1(population1,oldarchive,archiveSize,PopSize1,L,row,col,n)
fit1=zeros(1,archiveSize);
Com1=zeros(1,archiveSize);
[t,y,w]=size(oldarchive);
[h,f,g]=size(population1);
indexc=1;
if h==t && f==y
    PopSize=g+w;
    population=zeros(n,n,PopSize);
    for u=1:g
        population(:,:,indexc)=population1(:,:,u);
        indexc=indexc+1;
    end
    for v=1:w
        population(:,:,indexc)=oldarchive(:,:,v);
        indexc=indexc+1;
    end
else
    PopSize=g;
    population=population1;
end
count=0;
populationgeneralization=zeros(1,PopSize);
populationcompleteness=zeros(1,PopSize);
indexr=1;
parfor i=1:PopSize
    populationgeneralization(i)=generalization(population(:,:,i),L,row,col,n);
    populationcompleteness(i)=completeness(population(:,:,i),n,L,row,col);
end
array2=[];
indexa=1;
strength=[];
whomdominates=zeros(PopSize,PopSize);
distancs2=zeros(PopSize,PopSize);
for i = 1:PopSize
    % Number of individuals that dominate this individual
    individual.n = 0;
    % Individuals which this individual dominate
    individual.p = [];
    individual.n1=[];
    for j = 1: PopSize
        if populationcompleteness(i) >= populationcompleteness(j)&& populationgeneralization(i)>= populationgeneralization(j)
            individual.p = [individual.p j];
        elseif populationcompleteness(i) <= populationcompleteness(j)&& populationgeneralization(i)<= populationgeneralization(j)
            individual.n = individual.n + 1;% number of individuals that dominate this individual
            individual.n1=[individual.n1 j];% index of individual that dominate this individual
        end
        distancs2(j)=sqrt(((populationcompleteness(i))-(populationcompleteness(j)))^2+((populationgeneralization(i))-( populationgeneralization(j)))^2);% distance of a individual from all the other individuals
    end
    dominates(i)=individual.n;
    strength(i)=length(individual.p);
    parfor k=1:individual.n
        whomdominates(i,k)=individual.n1(k);% each row containing the array for the individual ,which dominates it.
    end
    for l=1:PopSize
        distancs2(i,l)=distancs2(l);% each row of this matrix contains the distance of the individual from all other individual
    end
    if individual.n == 0
        array2(indexa)=i;
        indexa=indexa+1;
        count=count+1;
    end
end
kthelement=round(sqrt(PopSize+archiveSize));% the kthelement is selected to take the distance from a element to kthelement
for m=1:PopSize
    distance11(m,:)=sort(distancs2(m,:));
    density1(m)=distance11(m,kthelement);
    density1(m)=1/(density1(m)+2);%fitness value should be greater than 0 and less than 1
end
strength1=strength(array2);
parfor k=1:PopSize
    rawfitness=0;
    if dominates(k)==0
        rawfitness1(k)=0;
    else
        for l=1:dominates(k)
            rawfitness=rawfitness+sum(strength(whomdominates(k,l)));% raw fitness is sum of strength of all those individuals which dominates it
            rawfitness1(k)=rawfitness;
        end
    end
end
fitness=rawfitness1 + density1;% final fitness for each individual is sum of raw fitness and kthelement distance
[fitness1,indices]=sort(fitness);
% to find unique elements in archive
ind=1;
    for l=1:length(array2)
        fit(ind)=populationgeneralization(array2(l));
        Com(ind)=populationcompleteness(array2(l));
        ind=ind+1;
    end
[Com2,ind]=sort(Com,'descend');
indexs=1;
fit2=[];
for k=1:length(array2)
    fit2(indexs)=fit(ind(k));
    indexs=indexs+1;
end             
    indx=1;
    Com3=[];
    fit3=[];
    for j=1:length(array2)        
        if  ~ismember(Com2(j), Com3(:)) && ~ismember(fit2(j), fit3(:))
            Com3(indx)=Com2(j);
            fit3(indx)=fit2(j);
            indices1(indx)=ind(j);
            indx=indx+1;            
        end        
    end
ind1=1;
    for i=1:length(indices1)
        archiveup(:,:,ind1)=population(:,:,(array2(indices1(i))));
        fit4(ind1)=populationgeneralization(array2(indices1(i)));
        Com4(ind1)=populationcompleteness(array2(indices1(i)));
        array1(i)=array2(indices1(i)); 
        ind1=ind1+1;
    end
array=array1;
% comparing array size with archive Size
if length(array)==archiveSize
    %disp('-----r')
    for r=1:length(array)
        archive(:,:,indexr)=population(:,:,array(r));%concatenating three dimensional matrix
        fit1(indexr)= populationgeneralization(array(r));
        Com1(indexr)=populationcompleteness(array(r));
        indexr=indexr+1;
    end
elseif length(array)<archiveSize
    numberAdded=archiveSize-length(array);
    for r=1:length(array)
        %disp('-----s')
        archive (:,:,indexr)=population(:,:,array(r));%concatenating three dimensional matrix
        fit1(indexr)= populationgeneralization(array(r));
        Com1(indexr)=populationcompleteness(array(r));
        indexr=indexr+1;
    end
    parfor u=1:length(array2)
        for v=1:length(indices)
            if array2(u)==indices(v)
                array3(u)=v;
            end
        end
    end
    [a,s,d]=size(archive);
    indices(array3)=[];
    fitness1(array3)=[];
    indices1=[];
    inds=1;
    counts=0;
    while d<archiveSize
        for s=1:numberAdded
            %disp('-----t')
            if  ~ismember(populationcompleteness(indices(s)), Com1(:)) && ~ismember(populationgeneralization(indices(s)), fit1(:))
                archive (:,:,indexr)=population(:,:,indices(s));%concatenating three dimensional matrix
                fit1(indexr)= populationgeneralization(indices(s));
                Com1(indexr)=populationcompleteness(indices(s));
                indices1(inds)=indices(s);
                inds=inds+1;
                indexr=indexr+1;
                counts=counts+1;
                if length(archive)==archiveSize
                    break
                end
            else
                numberAdded=numberAdded+1;
                %indices1(s)=indices(s+1)
                s=s+1;
            end
        end
        [a,s,d]=size(archive);
    end
    array=[array indices1];
elseif length(array)>archiveSize
    f=length(array);
    while f>archiveSize
        distance3=zeros(f,f);
        parfor p=1:f
            for z=1:f
                distance3(p,z)=sqrt(((populationcompleteness(p))-(populationcompleteness(z)))^2+((populationgeneralization(p))-( populationgeneralization(z)))^2);
            end
        end
        distance31=[];
        indexc=1;
        for n=1:f
            for m=n+1:f
                distance31(indexc)=sqrt(((populationcompleteness(n))-(populationcompleteness(m)))^2+((populationgeneralization(n))-( populationgeneralization(m)))^2);
                indexc=indexc+1;
            end
        end
        distance311=sort(distance31)
        minimum=min(distance311)
        parfor s=1:f
            for t=s+1:f
                if distance3(s,t)==minimum
                    s1=s;
                    t1=t;
                end
            end
        end
        density1(array(s1));
        density1(array(t1));
        if density1(array(s1))>density1(array(t1))
            array(s1)=[];
        else
            array(t1)=[];
        end
        f1=f-1;
        array=array;
        f=f1
    end
    disp('-----u')
    for b=1:f
        archive(:,:,indexr)=population(:,:,array(b));%concatenating three dimensional matrix
        fit1(indexr)= populationgeneralization(array(b));
        Com1(indexr)=populationcompleteness(array(b));
        indexr=indexr+1;
    end
end
[fitness2,indices]=sort(fitness);
parfor w=1:length(array)
    for y=1:length(indices)
        if array(w)==indices(y)
            array4(w)=y;
        end
    end
end
fitness2(array4)=[];
indices(array4)=[];
PopSize2=PopSize1-archiveSize;
for t=1:PopSize2
    population2(:,:,t) =population(:,:,indices(t));
    populationgeneralization2(:,t)=populationgeneralization(:,indices(t));
    populationcompleteness2(:,t)= populationcompleteness(:,indices(t));
end
population=population2;
populationgeneralization=populationgeneralization2;
populationcompleteness=populationcompleteness2;
end


