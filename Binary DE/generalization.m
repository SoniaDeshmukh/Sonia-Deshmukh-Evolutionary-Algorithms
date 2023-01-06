function Generalization = generalization(C,L,row,col,n)
%{
clc;
clear all;
%C=[0 1 0 0 1;0 0 1 1 0;0 0 0 1 0;0 0 0 0 0;0 0 0 1 0]
%C=[0 1 1 0 1;0 0 1 1 0;0 1 0 1 0;0 0 0 0 0;0 0 0 1 0]
%{
C=[0 0     1     0     1;
     0     0     1     1     0;
     0     1     0     1     0;
     0     0     0     0     0;
     0     0     0     0     0]
%}
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
     
L=[1 2 3 4;1 3 2 4;1 2 3 4;1 3 2 4;1 2 3 4;1 5 4 0]
row=6;
col=4;
n=5;
%}
execution=zeros(n,n);
for x=1:row
    for y=1:col-1      
        if L(x,y) ~= 0 && L(x,y+1) ~= 0 && C(L(x,y),L(x,y+1))==1
            execution(L(x,y),L(x,y+1))= execution(L(x,y),L(x,y+1))+1; % frequency of each (i,j)
        end
    end
end
a=sum(execution);% sum of all columns of a matrix
a(1)=row;% a(1) will be start state in all the rows
b=sqrt(a(a~=0).^-1);     % SJ - replaces for loop.
executionfrequency=sum(b);% again sum means sum of whole matrix
Generalization=(1-(executionfrequency/n));
end



   