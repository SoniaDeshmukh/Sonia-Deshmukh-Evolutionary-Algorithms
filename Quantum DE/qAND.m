function b = qAND(a,b,n,D,a1)
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
%a=zeros(n,n);
%b=zeros(n,n);

for i=1:n
    for j=1:n
        if D(i,j)~=0 && a(i,j)==0
            b(i,j)=a1(i,j);% we have to put the decimal value which is a1 , a is the causal matrix individual of a1, used for binary comparison only.
        elseif D(i,j)~=0 && a(i,j)==1
            b(i,j)=b(i,j);
        else
            b(i,j)=0;
        end         

    end
end

end