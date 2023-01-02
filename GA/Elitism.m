function [elitism,fitness] = Elitism(PplusC,PplusCFitness,PopSize,n)
elitism=zeros(n,n,PopSize);               % for storing top n (populationSize) matrices
fitness=zeros(1,PopSize);
[values,indices] = sort(PplusCFitness,'descend');                          % sort the fitness array
parfor i=1:PopSize
    indices(i);
    elitism(:,:,i)= PplusC(:,:,indices(i)) ;    % finally taking out top popSize matrices
    fitness(i) = values(i);
end
end




