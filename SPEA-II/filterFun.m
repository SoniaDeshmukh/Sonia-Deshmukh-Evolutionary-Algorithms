function Filterpopulation = filterFun(mutation,x,D,n)
%{
C=[0 1  1  0  0;
     0     0   0     1     1;
     0     0     0     1     0;
     0     1     1     0     0;
     0     1     0     1     0]
 n=5;
D=  [0,0.7500,0.6667,0,0.5000;-0.7500,0,0.5000,0.6667,0;-0.6667,0.5000,0,0.7500,0;0,-0.6667,-0.7500,0,-0.5000;-0.5000,0,0,0.5000,0]    
%}
parfor i=1:x
    C=mutation(:,:,i);
    for p=1:n
        for q=1:n
            if D(p,q) <= 0 && C(p,q) == 1
                C(p,q) = 0;
            end
        end
    end
    Filterpopulation(:,:,i)=C;
end
end
