Function  [alpha1]=update(A,compArray,bst,compbst,alpha,beta,n,popSize)
alpha1=zeros(n,n,popSize);
beta1=zeros(n,n,popSize);
[angle] = look(A,compArray,bst,compbst,n,popSize)
for k=1:popSize
    for  i=1:n
        for j=1:n
            G=[cos(angle(i,j,k),-sin(angle(i,j,k);sin(angle(i,j,k),cos(angle(i,j,k)]
            H=[alpha(i,j,k);beta(i,j,k)]
            G*H
        end
    end
    
end
end