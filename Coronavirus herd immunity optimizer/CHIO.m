%=======================================================================
%            Coronavirus herd immunity optimizer (CHIO)

% This work is published in Journal of "Neural Computing and Applications"
% https://rd.springer.com/article/10.1007%2Fs00521-020-05296-6
% DOI: https://doi.org/10.1007/s00521-020-05296-6

% Copyright (c) 2020, Mohammed Azmi Al-betar (mohbetar@bau.edu.jo),
%       Zaid Abdi Alkareem Alyasseri (zaid.alyasseri@uokufa.edu.iq),
%       Mohammed A. Awadallah (ma.awadallah@alaqsa.edu.ps), and
%       Iyad Abu Doush (idoush@auk.edu.kw).
% All rights reserved.
%=======================================================================
diary('E:\Paper8Coronavirusherdimmunity\CHIOPM code\results\final results30pop100iter0.6324\sepsis2run.txt');
clear all
close all
clc
PopSize=30; %/* The number of Solutions*/
%MaxAge = 100;
C0 = 1; % number of solutions have corona virus
Max_iter=100; %/*The number of cycles for foraging {a stopping criteria}*/
SpreadingRate = 0.6324;   % Spreading rate parameter
runs = 2;%/*Algorithm can be run many times in order to see its robustness*/
ObjVal = zeros(1,PopSize);
Age = zeros(1,PopSize);
BestResults = zeros(runs,1); % saving the best solution at each run
L=csvread('converted_sepsis.csv');
[row,col]=size(L) ;       % dimensions of Event log matrix L
[n,t]=size(unique(L)) ;   % to find the unique activites in event log and storing it in variable n
if ismember(0,L) == 1
    n=n-1;
end
comptimeArray=zeros(1,runs);
for run = 1:runs
    % Initializing arrays
    %swarm=zeros(PopSize,dim);
    
    % Initialize the population/solutions
    [swarm,Fitness,comtime,D]=initialization(L,row,col,n,PopSize);
    
    
    %% update the status of the swarms (normal, confirmed)
    %%the minmum C0 Immune rate will take 1 status which means
    %%infected by corona
    
    Status=zeros(1,PopSize);
    for i=1:C0,
        Status(fix(rand*(PopSize))+1)=1;
    end
    
    %===================== loop ===================================
    tic
    
    itr=0;   % Loop counter
    
    while itr<Max_iter
        comtime1=0;
        for i=1:PopSize,
            NewSol=swarm(:,:,i);
            CountCornoa = 0;
            % find the set of confirmed solutions
            confirmed = randperm(size(find(Status==1),2));
            confirmed1 = find(Status==1);
            %find(Status==1);
            % find the set of normal solutions
            normal = randperm(size(find(Status==0),2));
            normal1 = find(Status==0);
            % find the set of recovered solutions
            recovered = find(ObjVal & Status==2);
            [cost,Index3]=min(recovered);
            parfor j=1: n,
                for k=1: n,
                    r = rand();  % select a number within range 0 to 1.
                    if ((r < SpreadingRate/3)&&(size(confirmed1,2)>0))
                        % select one of the confirmed solutions
                        z=round(1+(size(confirmed1,2)-1)*rand);
                        zc= confirmed1(z);
                        
                        %{
                       v=swarm(j,k,i)+(swarm(j,k,i)-swarm(j,k,zc))*(rand-0.5)*2;
                           if (D(j,k) <= 0 && (v >0))
                               NewSol(j,k) = 0;
                           elseif (D(j,k) > 0 && (v >0))
                               NewSol(j,k) = 1;
                           end
                        %}
                        % modify the curent value
                        NewSol(j,k) = swarm(j,k,i)+(swarm(j,k,i)-swarm(j,k,zc))*(rand-0.5)*2;
                        % manipulate range between lb and ub
                        % NewSol(j,k)= min(max(NewSol(j),lb),ub);
                        CountCornoa = CountCornoa + 1;
                        %display([' confirmed#']);
                        
                    elseif ((r < SpreadingRate/2) &&size(normal1,2)>0)
                        % select one of the normal solutions
                        z=round(1+(size(normal1,2)-1)*rand);
                        zn= normal1(z);
                        %{
                      v=swarm(j,k,i)+(swarm(j,k,i)-swarm(j,k,zn))*(r-0.5)*2;
                           if (D(j,k) <= 0 && (v >0))
                               NewSol(j,k) = 0;
                           elseif (D(j,k) > 0 && (v >0))
                               NewSol(j,k) = 1;
                           end
                        %}
                        % modify the curent value
                        NewSol(j,k) =swarm(j,k,i)+(swarm(j,k,i)-swarm(j,k,zn))*(r-0.5)*2;
                        % manipulate range between lb and ub
                        %NewSol(j)= min(max(NewSol(j),lb),ub);
                        %display([' normal#']);
                    elseif (r < SpreadingRate && size(recovered,2)>0)
                        %{
                     v=swarm(j,k,i)+(swarm(j,k,i)-swarm(j,k,Index3))*(r-0.5)*2;
                           if (D(j,k) <= 0 && (v >0))
                               NewSol(j,k) = 0;
                           elseif (D(j,k) > 0 && (v >0))
                               NewSol(j,k) = 1;
                           end
                        %}
                        % modify the curent value
                        NewSol(j,k) =swarm(j,k,i)+(swarm(j,k,i)-swarm(j,k,Index3))*(r-0.5)*2 ;
                        % manipulate range between lb and ub
                        %NewSol(j)= min(max(NewSol(j),lb),ub);
                        %display([' modify current#']);
                    end
                end
            end
            NewSolf=NewSol;
            parfor j=1: n,
                for k=1: n,
                    if (D(j,k) <= 0 && (NewSol(j,k) >0))
                        NewSolf(j,k) = 0;
                    elseif (D(j,k) > 0 && (NewSol(j,k) >0))
                        NewSolf(j,k) = 1;
                    elseif  (NewSol(j,k) <0)
                        NewSolf(j,k) = 0;
                    end
                end
            end
            comptime1=tic;
            %evaluate new solution
            FitnessChild=completeness(NewSolf,n,L,row,col);
            comtime2=toc(comptime1);
            comtime1=comtime1+comtime2;
            % ObjValSol=fobj(NewSol);
            % FitnessSol=calculateFitness(ObjValSol);
            
            % Update the curent solution  & Age of the current solution
            if (Fitness(i)<FitnessChild)
                swarm(:,:,i)=NewSol;
                Fitness(i)=FitnessChild;
                %ObjVal(i)=ObjValSol;
            else
                if(Status(i)==1)
                    Age(i) = Age(i) + 1;
                end
            end
            % change the solution from normal to confirmed
            if ((Fitness(i) < mean(Fitness))&& Status(i)==0 && CountCornoa>0)
                Status(i) = 1;
                Age(i)=1;
            end            
            % change the solution from confirmed to recovered
            if ((Fitness(i) >= mean(Fitness))&& Status(i)==1)
                Status(i) = 2;
                Age(i)=0;
            end
        end        
        if(mod(itr,100)~=0)
            display([' Run#', num2str(run), ', Itr ', num2str(itr), ' Results ', num2str(max(Fitness))]);
        end
        [compArray1,sortIdx] = sort(Fitness,'descend');
        if  compArray1(:,1)==1 %isequal(currentComp,prevComp) == 1 && isequal(currentGen,prevGen) == 1 && isequal(currentPrec,prevPrec) == 1
            break
        end
        itr=itr+1 ;
    end
    
    %[compArray1,sortIdx] = sort(Fitness,'descend');
    
    % sort B using the sorting index
    A1 = swarm(:,:,sortIdx);
    bst=A1(:,:,1);
    parfor j=1: n,
        for k=1: n,
            if (D(j,k) <= 0 && (bst(j,k) >0))
                bst(j,k) = 0;
            elseif (D(j,k) > 0 && (bst(j,k) >0))
                bst(j,k) = 1;
            elseif  (bst(j,k) <0)
                bst(j,k) = 0;
            end
        end
    end
    compbst=compArray1(:,1);
    genArray=generalization(bst,L,row,col,n);
    precArray=preciseness(L,row,col,bst,n);
    simArray = simplicity1(bst,n,row,col,L);
    sim=simplicity(bst,n);
    iterArray(run)=itr ;
    comArray(run)=compbst;
    precArray1(run)=precArray;
    simArray2(run)=sim ;
    genArray1(run)=genArray;
    %simArray1(run)=simArray;
    comptimeArray(run)=comtime+comtime1;
    toc;
    % Save the best results at each iteration
    BestResults(run)=max(Fitness);
    
end % run
iterArray
comArray
genArray1
simArray2
precArray1
comptimeArray

fprintf(1, '\n\n Done \n\n');


