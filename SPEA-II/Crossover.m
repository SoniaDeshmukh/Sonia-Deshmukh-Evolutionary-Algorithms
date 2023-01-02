function [list1,poolNew , x] = Crossover(pool,n,Totalsize)
%{
    This function calculates crossover for two matrices - C1 and C2 .
    The offsprings Child_1 and Child_2 are returned.
%}
crossoverRate=0.8;
x =  crossoverRate * Totalsize;   % number of matrices on which we'll perform crossover
x=floor(x);
poolNew=zeros(n,n,x);
PoolNew=zeros(n,n,x);
list1=1:Totalsize;      % creatin a list to maintain unused index
for i=1:x    % half the popsize becoz of each player will play once for each participation
    ind2=size(list1,2);      % index to count current size of list
    j1=randi([1,ind2]);      % randomly taking a no within the list size range
    a1=list1(j1);
    list1(j1)=[];            % reducing list by deleting the used index
    PoolNew(:,:,i)= pool(:,:,a1);
end
a=1;
for b=1:x/2
    r1 = randi(x);
    r2 = randi(x);
    C1=PoolNew(:,:,r1);
    C2=PoolNew(:,:,r2);
    crossOverPoint = randi(n);          % to generate random numbers between 1 to n
    % this will be our crossover point
    Child_1=C1;
    Child_2=C2;
    for i=1:n
        if Child_1(crossOverPoint,i) ~= Child_2(crossOverPoint,i)     % swapping of outputs
            temp=Child_1(crossOverPoint,i);
            Child_1(crossOverPoint,i)=Child_2(crossOverPoint,i);
            Child_2(crossOverPoint,i)=temp;
        end
        
        if Child_1(i,crossOverPoint) ~= Child_2(i,crossOverPoint)     %swapping of inputs
            temp=Child_1(i,crossOverPoint);
            Child_1(i,crossOverPoint)=Child_2(i,crossOverPoint);
            Child_2(i,crossOverPoint)=temp;
        end
    end
    poolNew(:,:,a)= Child_1;
    a=a+1;
    poolNew(:,:,a)= Child_2;
    a=a+1;
end
end
