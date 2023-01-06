function follow = follows(L,row,col,n)
%{
  This function returns a 2D matrix of size (n X n) which 
  stores the number of times that a task is directly followed by another one. 
  That is, how often the substring "t1t2" occurs in the log L.
%}
    follow=zeros(n,n);
    for x=1:row
        for y=1:col-1
            if (L(x,y) ~= 0) && (L(x,y+1) ~= 0)
                follow(L(x,y),L(x,y+1))= follow(L(x,y),L(x,y+1))+1;
            end
        end
    end
    
end

        
