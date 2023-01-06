function allEnabledActivities = enabledactivities(L,row,col,C,n)
%{ 
    This function counts the number of enabled activites.
%}

%{
clc;
clear all;
C=[0 1 0 0 1;0 0 1 1 0;0 0 0 1 0;0 0 0 0 0;0 0 0 1 0]
L=[1 2 3 4;1 3 2 4;1 2 3 4;1 3 2 4;1 2 3 4;1 5 4 0]
row=6;
col=4;
n=5;
%}
%tic
%disp('.. enabled activities ..')

allEnabledActivities=0;

parfor i=1:row
    for j=2:col
        if L(i,j) ~= 0
            if C(L(i,1),L(i,j)) == 1
                allEnabledActivities=allEnabledActivities+1;
            end
            if  C(L(i,1),L(i,j)) ~= 1 & sum(C(:,L(i,j)))==1 & C(L(i,j-1),L(i,j)) == 1
                allEnabledActivities=allEnabledActivities+1;
                
            end
            if  C(L(i,1),L(i,j)) ~= 1 & sum(C(:,L(i,j))) > 1
                C1=[];
                x=1;             % x is the index of row in C1
                for p=1:n        % for all the rows in C
                    if C(p,L(i,j))==1
                        if any(L(i,1:j-1) == p)
                            C1=[C1;C(p,:)];
                            C1(x,L(i,j))=0;
                            x=x+1;
                        end
                    end
                end
                m=zeros(1,n);
                for p=1:n
                    if size(C1)>0 & sum(C1(:,p))>=1
                        m(p)=1;
                    end
                end
                if sum(m)==0
                    allEnabledActivities=allEnabledActivities+1;
                    
                else
                    for p=1:n
                        if m(p)==1 & j-2 >= 1 & C(L(i,j-2),L(i,j-1))==1
                            allEnabledActivities=allEnabledActivities+1;
                            break;
                        end
                    end
                end
                
            end
            
        end
    end
end
allEnabledActivities=allEnabledActivities+row;
%toc
end