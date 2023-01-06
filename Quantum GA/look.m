function [angle] = look(A1,compArray1,bst1,compbst1,n,popSize)
angle=zeros(n,n,popSize);
for k=1:popSize
    for i=  1:n
        for j=1:n
            if(A1(i,j,k)==0 && bst1(i,j)==0);
                if (compArray1(k)>=compbst1)
                    angle(i,j,k)=0;    %if true
                else
                    angle(i,j,k)=0;   %if false
                end
            elseif (A1(i,j,k)==0 && bst1(i,j)==1);
                if (compArray1(k)>=compbst1)
                    angle(i,j,k)=0;
                else
                    angle(i,j,k)=0.0482*pi; %if false
                end
            elseif (A1(i,j,k)==1 && bst1(i,j)==0);
                if compArray1(k)>=compbst1
                    angle(i,j,k)=0;
                else
                    angle(i,j,k)=-0.0027*pi;
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