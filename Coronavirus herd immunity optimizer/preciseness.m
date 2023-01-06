function prec = preciseness(L,row,col,C,n)
%{
     We calculate precision as :
          Qp =  1 - ∑ [ visited markings * (no of outgoing edges – no of edges used by replay ) ]
                    ------------------------------------------------------------------------------
                                      ∑ [ visited markings * (no of outgoing edges) ]


          no of edges used by replay = calculated using follows function
%}
    
    follow=follows(L,row,col,n);
    visited2 = zeros(n,1);                                      %
    for x=1:n                                                   %
        visited2(x) = nnz(L == x);                              %
    end                                                         %
                                                                %
    outgoing2 = sum(follow>0,2);                                %
    edges_replay2 = sum(double(C==1) .* double(follow>0),2);    %
    numerator2 = sum(visited2 .* (outgoing2 - edges_replay2)) ; %
    denominator2 = sum(visited2 .* outgoing2) ;                 % SJ - This code replaes the loop above and provides the same result.
    
    prec = 1 - (numerator2 / denominator2);
%     prec = 1 - (numerator / denominator);

end

