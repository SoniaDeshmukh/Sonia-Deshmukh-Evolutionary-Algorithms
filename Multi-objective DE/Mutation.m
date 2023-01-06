function mutation = Mutation(population,n,mutationRate,popSize,D)
    mutation=population;                 % initially store the original matrices
    elements = n*n*mutationRate;      % calculate number of elements on which mutation is to be performed
    parfor i=1:popSize                        
       M=mutation(:,:,i);
       flag=0;
       %disp('.... for .....');
       while(flag==0)
           %disp('.... while .....');
           for j=1:elements                         
               row=randi(n);              % generate random number in range 1 to n for row
               col=randi(n);              % generate random number in range 1 to n for column
               M(row,col)=1-M(row,col);   % flipping the values at mutation points obtained by random number
           end
                       
           M = filterFun(M,D,n);          % filter out extra behaviour
      
           if M==0
           elseif simplicity(M,n) == Inf
           else
               mutation(:,:,i)=M;          % finally storing matrix again at its location
               flag=1;
           end
       end
    end 
end
    