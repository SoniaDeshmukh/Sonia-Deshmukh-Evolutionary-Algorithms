function [C,alpha,beta] = causality(D,n,populationSize)
    %tic 
    %disp('... causality ...')
    C=zeros(n,n,populationSize);
    alpha=zeros(n,n,populationSize);
    beta=zeros(n,n,populationSize);
    parfor k=1:populationSize
         betasq(:,:,k)=D;
         alphasq(:,:,k)=(1-betasq(:,:,k));
         alpha(:,:,k)=sqrt(alphasq(:,:,k));
         beta(:,:,k)=sqrt(betasq(:,:,k));
          r=rand(n,n)
          C(:,:,k)= (r< betasq(:,:,k));         
    end   
end
%{  
%SEED STORAGE
    rstates=cell(populationSize,1);
      filename = sprintf('g4run%02d_causality.csv',run);
      parfor k=1:populationSize
         betasq(:,:,k)=D;
         alphasq(:,:,k)=(1-betasq(:,:,k));
         alpha(:,:,k)=sqrt(alphasq(:,:,k));
         beta(:,:,k)=sqrt(betasq(:,:,k));
         s=rng()
         %s.State
         rstates{k} =s;
         r=rand(n,n)       
         %csvwrite(filename,s.Seed)
         %struct2csv(s,filename);
         dlmwrite(filename,rstates{k}.Type,'delimiter',',','-append');
         dlmwrite(filename,rstates{k}.State,'delimiter',',','-append');
         dlmwrite(filename,r,'delimiter',',','-append');
         %rstates{k}.Type
         %rstates{k}.Seed         
         %qde_theta1_theta2_F_Cr_g1_run1.txt       
         C(:,:,k)= (r< betasq(:,:,k));         
      end      
     %rng(rstates{2})
 %r=rand(n,n)
end
%}
%{
        % case 1: when both are given equal probability
        %  ( With Repair - means according to D we are putting 0 and initializing 
        beta(:,:,k)=ones(n,n)*1/sqrt(2);
        for i=1:n
            for j=1:n
                if D(i,j)==0
                    beta(i,j,k)=0;
                end
            end
        end
       alphasq(:,:,k)=(1-beta(:,:,k).^2);
       alpha(:,:,k)=sqrt(alphasq(:,:,k));
        r=rand(n,n);
        C(:,:,k)= (r< beta(:,:,k).^2);   % if (r < D^p)  , then  1 otherwise 0(here we used square as betasq gives us 0.5 value as probability) 
         %}
         %{
        % case 1: when both are given equal probability
        %  ( Without Repair -random initialization 
        beta(:,:,k)=ones(n,n)*1/sqrt(2);
        alphasq(:,:,k)=(1-beta(:,:,k).^2);
       alpha(:,:,k)=sqrt(alphasq(:,:,k));
        r=rand(n,n);
        C(:,:,k)= (r< beta(:,:,k).^2);   % if (r < D^p)  , then  1 otherwise 0(here we used square as betasq gives us 0.5 value as probability) 
        
         % Case 3: 
          beta(:,:,k)=abs(D);
       alphasq(:,:,k)=(1-beta(:,:,k).^2);
       alpha(:,:,k)=sqrt(alphasq(:,:,k));
        r=rand(n,n);
        C(:,:,k)= (r< beta(:,:,k));   % if (r < D^p)  , then  1
                               % otherwise 0
         
          % Case 4:
        
          betasq(:,:,k)=D;
          alphasq(:,:,k)=(1-betasq(:,:,k));
          alpha(:,:,k)=sqrt(alphasq(:,:,k));
          beta(:,:,k)=sqrt(betasq(:,:,k));
          r=rand(n,n);
          C(:,:,k)= (r< betasq(:,:,k));
      
         %{
        % case 5: when both are given equal probability
        %  ( With Repair - means according to D we are putting 0 where D<=0 and initializing 
        beta(:,:,k)=ones(n,n)*1/sqrt(2);
        for i=1:n
            for j=1:n
                if D(i,j)<=0
                    beta(i,j,k)=0;
                end
            end
        end
       alphasq(:,:,k)=(1-beta(:,:,k).^2);
       alpha(:,:,k)=sqrt(alphasq(:,:,k));
        r=rand(n,n);
        C(:,:,k)= (r< beta(:,:,k).^2); 
          %}               
  
    
    for i=1:n
        for j=1:n
            if D(i,j)>0
                D(i,j)=1;
            else
                D(i,j)=0;
            end
        end
    end
    parfor k=1:populationSize        
        C(:,:,k)= and(C(:,:,k),D);   % if (r < D^p)  , then  1
                       % otherwise 0
    end
    %toc
    %}

