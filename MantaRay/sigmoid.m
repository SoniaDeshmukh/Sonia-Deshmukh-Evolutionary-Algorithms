function C=sigmoid(C,n)
parfor p=1:n
    for q=1:n
        if C(p,q) > 0.5
            C(p,q) = 1;
        else
            C(p,q) = 0;
        end
    end
end        
end