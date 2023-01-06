function [angle] = look3(A1,compArray1,bst1,compbst1,n,popSize,D)
angle=zeros(n,n,popSize);
for k=1:popSize
    for i=  1:n
        for j=1:n
            if(A1(i,j,k)==0)
                if D(i,j)>0 || (bst1(i,j)==1 && compArray1(k)<=compbst1)
                     angle(i,j,k)=0.05*pi;
                end
            elseif (A1(i,j,k)==1 && bst1(i,j)==0);
                if compArray1(k)>=compbst1
                    angle(i,j,k)=0;
                else
                    angle(i,j,k)=-0.001*pi;
                end
            else (A1(i,j,k)==1 && bst1(i,j)==1);
                if compArray1(k)>=compbst1
                    angle(i,j,k)=0;
                else
                    angle(i,j,k)=0;
                end
            end
        end
    end    
end
end