function  [alpha1,beta1]=rotation(A1,compArray1,bst1,compbst1,alpha,beta,n,popSize)
alpha1=zeros(n,n,popSize);
beta1=zeros(n,n,popSize);
[angle] = look(A1,compArray1,bst1,compbst1,n,popSize); % original Han&Kim
parfor k=1:popSize
    for  i=1:n
        for j=1:n
            G=[cos(angle(i,j,k)),-sin(angle(i,j,k));sin(angle(i,j,k)),cos(angle(i,j,k))];
            L1=[cos(-angle(i,j,k)),-sin(-angle(i,j,k));sin(-angle(i,j,k)),cos(-angle(i,j,k))];
            H=[alpha(i,j,k);beta(i,j,k)];
            if ((alpha(i,j,k)>0)&&beta(i,j,k)>0)|| ((alpha(i,j,k)<0)&&beta(i,j,k)<0)% first and third quadrant
                positions=G*H;
            else
                positions= L1*H;% if in second and fourth quadrant
            end
            positionsc = mat2cell(positions,[1 1],1); %[1x1 double]    [1x1 double], creates cell array one row each
            [alpha1(i,j,k), beta1(i,j,k)]    = deal(positionsc{:});% deal is used to assign different elements of r.h.s into different variables in l.h.s
        end
    end  
end

end
