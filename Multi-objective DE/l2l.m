function ltl = l2l(L,row,col,n) 
%{
    This function returns a 2D matrix of size (n X n) which 
    gives the number of times that the substring of the form
    "ltl" occurs in the event log L .
%}
    ltl=zeros(n);
    for x=1:row
  
        for y=1:col-2
            if (L(x,y) ~= 0) && (L(x,y+2) ~= 0) && (L(x,y) == L(x,y+2)) && (L(x,y) ~= L(x,y+1))
                ltl(L(x,y),L(x,y+1))=ltl(L(x,y),L(x,y+1))+1;
            end
        end
    end
   
end
