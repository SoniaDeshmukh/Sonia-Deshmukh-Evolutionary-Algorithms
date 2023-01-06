function b = qOR(a,b,n,D,b1)
%{
b=[0    1.0000    0.6845         0    0.7071;
         0         0    0.7071    0.7071         0;
         0    0.7071         0    0.7290         0;
         0         0         0         0         0;
         0         0         0    0.7290         0]
 a=    [0     0     0     0     1;
     0     0     1     1     0;
     0     1     0     1     0;
     0     0     0     0     0;
     0     0     0     1     0]
 n=5
 D= [0     1    1     0     1;
     0     0     1     1     0;
     0     1     0     1     0;
     0     0     0     0     0;
     0     0     0     1     0]
%}
for i=1:n
    for j=1:n
        if D(i,j)~=0 && a(i,j)==0
            b(i,j)=b(i,j);
        elseif D(i,j)~=0 && a(i,j)==1
            b(i,j)=b1(i,j);% we replace with the decimal value not with the casual matrix value. a is causal matrix individual of b1, so we are putting b1 here.
        else
            b(i,j)=0;
        end         

    end
end

end