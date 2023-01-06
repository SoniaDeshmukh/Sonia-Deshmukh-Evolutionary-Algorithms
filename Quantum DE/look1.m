function [angle] = look1(A1,D,n,popSize)
angle=zeros(n,n,popSize);
for k=1:popSize
    for i=  1:n
        for j=1:n
            if(A1(i,j,k)==0 && D(i,j)==0);
                   angle(i,j,k)=0;    %if true
            elseif (A1(i,j,k)==0 && D(i,j)>0);%if D is + or - we move in positive direction
                   angle(i,j,k)=0.05*pi; 
           elseif (A1(i,j,k)==0 && D(i,j)<0);%if D is + or - we move in positive direction
                   angle(i,j,k)=-0.001*pi;
            %elseif (A(i,j,k)==1 && D(i,j)==0);% this case will not occur
                   %angle(i,j,k)=-0.01*pi;
             else (A1(i,j,k)==1 && D(i,j)>0);
                     angle(i,j,k)=0;
             end
        end
    end    
end
end