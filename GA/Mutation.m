function mutation = Mutation(poolNew,n,x)
    %tic
    %disp(' mutation ')
     mutationRate=0.2;
    mutation=poolNew;                 % initially store the original matrices
    elements = n*n*mutationRate;  % calculate number of elements on which mutation is to be performed
    parfor i=1:x                        % for each causality matrix obtained after crossover
       M=mutation(:,:,i);
       for j=1:elements                                      
           row=randi(n);             % generate random number in range 1 to n for row
           col=randi(n);             % generate random number in range 1 to n for column
           M(row,col)=1-M(row,col);   % flipping the values at mutation points obtained by random number
       end
       mutation(:,:,i)=M;             % finally storing matrix again at its location
    end
   % toc   
end
    