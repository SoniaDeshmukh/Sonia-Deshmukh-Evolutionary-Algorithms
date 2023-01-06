function Generalization = generalization(C,L,row,col,n,follow)
%{
clc;
clear all;
%C=[0 1 0 0 1;0 0 1 1 0;0 0 0 1 0;0 0 0 0 0;0 0 0 1 0]
%C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0]

C=[0 0     1     0     1;
     0     0     1     1     0;
     0     1     0     1     0;
     0     0     0     0     0;
     0     0     0     0     0]

 C=[0     1     1     0     0;
     0     0     1     1     0;
     0     1     0     1     0;
     0     0     0     0     0;
     0     0     0     0     0]

   C=[0     1     0     0     1;
     0     0     1     1     0;
     0     0     0     1     0;
     0     0     0     0     0;
     0     0     0     1     0]



    C=[ 0     1     1     0     0;
     0     0     0     1     0;
     0     1     0     0     0;
     0     0     0     0     0;
     0     0     0     0     0]
 follow=[ 0     3    2     0     1;
     0     0     3    2     0;
     0     2     0     3     0;
     0     0     0     0     0;
     0     0     0     1     0]
     
L=[1 2 3 4;1 3 2 4;1 2 3 4;1 3 2 4;1 2 3 4;1 5 4 0]
row=6;
col=4;
n=5;

%}
%n=n.f
%C=C.f
%L=L.f
%row=row.f
%col=col.f

% where C is 0, put zero in execution else put follows value in execution
%{
for x=1:row
    for y=1:col-1      
        if L(x,y) ~= 0 && L(x,y+1) ~= 0 && C(L(x,y),L(x,y+1))==1
            execution(L(x,y),L(x,y+1))= execution(L(x,y),L(x,y+1))+1; % frequency of each (i,j)
        end
    end
end
%}
execution=zeros(n,n);
for x=1:n
    for y=1:n 
        if  C(x,y)==0
            execution(x,y)=0;
        else
            execution(x,y)=follow(x,y);% frequency of each (i,j)
        end
    end
end

a=sum(execution);% sum of all columns of a matrix
a(1)=row;% a(1) will be start state in all the rows

b=sqrt(a(a~=0).^-1);     % SJ - replaces for loop.

% for i=1:n
%     if a(i)~=0
%         a(i)=(power(sqrt(a(i)),-1));%1/sqrt(frequency)
%     end
% end

executionfrequency=sum(b);% again sum means sum of whole matrix
Generalization=(1-(executionfrequency/n));

end

%function execution = execution_f(n,L,col)
%    execution=zeros(n,n);
%    for y=1:col-1      
%        if L(x,y) ~= 0 && L(x,y+1) ~= 0 && C(L(x,y),L(x,y+1))==1
%            execution(L(x,y),L(x,y+1))= execution(L(x,y),L(x,y+1))+1; % frequency of each (i,j)
%        end
%    end
%end

   