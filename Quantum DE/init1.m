function [C,compArray1,comtime2,bst1,compbst1] = init1(n,beta,populationSize,L,row,col)
    %tic 
    %disp('... causality ...')
    C=zeros(n,n,populationSize);
     parfor k=1:populationSize
         % Case 4:        
         %beta(:,:,k)=D;
          r=rand(n,n);
          C(:,:,k)= (r< (beta(:,:,k).^2));          
     end
    compArray=zeros(1,populationSize);
    comptime=tic;
    parfor i=1:populationSize
        compArray(i)=completeness(C(:,:,i),n,L,row,col);
    end
    comtime2=toc(comptime);
   [compArray1,sortIdx] = sort(compArray,'descend');
   
% sort B using the sorting index
A1 = C(:,:,sortIdx);
bst1=A1(:,:,1);
compbst1=compArray1(:,1);     
     %toc
end
  
    
    
    
    %{
    SEED STORAGE
    rstates3=cell(populationSize,1);
     filename = sprintf('g4run%02d_inititer%03d.csv',run,iter);
    parfor k=1:populationSize
         % Case 4:        
         %beta(:,:,k)=D;
          s3=rng();
         rstates3{k} =s3;
         r=rand(n,n);
          dlmwrite(filename,rstates3{k}.Type,'delimiter',',','-append');
         dlmwrite(filename,rstates3{k}.State,'delimiter',',','-append');
         dlmwrite(filename,r,'delimiter',',','-append');
        C(:,:,k)= (r< (beta(:,:,k).^2));          
    end
    
    %genArray=zeros(1,populationSize);
    compArray=zeros(1,populationSize);
    %precArray=zeros(1,populationSize);
    %simArray=zeros(1,populationSize);
    comptime=tic;
    parfor i=1:populationSize
        %C=A(:,:,i);
        %genArray(i)=generalization(C,L,row,col,n);
        compArray(i)=completeness(C(:,:,i),n,L,row,col);
        %precArray(i)=preciseness(L,row,col,C,n);
        %simArray(i)=simplicity(C,n);
    end
    comtime2=toc(comptime);
   [compArray1,sortIdx] = sort(compArray,'descend');
   
% sort B using the sorting index
A1 = C(:,:,sortIdx);
bst1=A1(:,:,1);
compbst1=compArray1(:,1); 
    
     %toc
end
%}  
   