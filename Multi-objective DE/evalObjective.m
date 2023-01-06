function flag = evalObjective(mutationGen,mutationComp,Gen,Comp)
parentObj(1)=Gen;
parentObj(2)=Comp;
%parentObj(3)=Prec;
%parentObj(4)=Sim;
childObj(1)=mutationGen;  
childObj(2)=mutationComp;
%childObj(3)=mutationPrec;
%childObj(4)=mutationSim;
difference=parentObj-childObj;
if difference >= 0
    flag=0;   % parent dominates
elseif difference <= 0
    flag=1;   % child dominates
else
    flag=-1;  % parent and child are non-dominating
end
end