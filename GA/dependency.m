function D = dependency(follow,ltl,n)
%{
    Dependency relation distinguishes between tasks in short
    loops (length-one and length-two loops) and tasks in parallel. 
    Once the dependency relations are set for the input event log, the genetic
    algorithm uses it to randomly build the causality relations for every individual
    in the initial population. 
%}
%tic
%disp('.. dependency ..')    
    D=zeros(n);
    for t1=1:n
        for t2=1:n
            if t1 == t2
                D(t1,t2)=follow(t1,t2)/(follow(t1,t2)+1);
            elseif ltl(t1,t2) > 0
                D(t1,t2)=(ltl(t1,t2)+ltl(t2,t1))/(ltl(t1,t2)+ltl(t2,t1)+1);
            elseif follow(t1,t2) ~= 0 && follow(t2,t1) ~= 0 
                D(t1,t2)=0.5;
                D(t2,t1)=0.5;
            else
                D(t1,t2)=(follow(t1,t2)-follow(t2,t1))/(follow(t1,t2)+follow(t2,t1)+1);
            end
        end
    end    
    %toc
end