function [FitnessArray] = Fitness(C,n,L,row,col)
FitnessArray=(10*completeness(C,n,L,row,col)+ generalization(C,L,row,col,n)+ preciseness(L,row,col,C,n)+ simplicity(C,n))/4;
end