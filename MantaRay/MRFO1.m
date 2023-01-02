function [BestX,BestF,HisBestFit,PopFitF,completenesstime,It]=MRFO1(n,Low,Up,MaxIt,nPop,L,row,col,D)
parfor i=1:nPop
    PopPos(:,:,i)= rand(n,n)<D;%C(:,:,i)= Low + rand(n,n).*(Up-Low);%PopPos(:,:,i) = Repair(C(:,:,i),D,n);%Pop(:,:,i)=sigmoid(PopPos(:,:,i),n);
    comptime1=tic;
    PopFit(i)=completeness(PopPos(:,:,i),n,L,row,col);
    comtime(i)=toc(comptime1);
end
comtime=sum(comtime);
BestF=0;
BestX=[];
for i=1:nPop
    if PopFit(i)>=BestF
        BestF=PopFit(i);
        BestX=PopPos(:,:,i);
    end
end
completenesstime=zeros(MaxIt,1);
HisBestFit=zeros(MaxIt,1);
PopFitF=zeros(MaxIt,nPop);
count=0;
for It=1:MaxIt
    Coef=It/MaxIt;
    a=rand;
    if a<0.5
        r1=rand;
        Beta=2*exp(r1*((MaxIt-It+1)/MaxIt))*(sin(2*pi*r1));
        if  Coef<rand
            %disp('......... cyclone random ............')
            IndivRand=rand(n,n)<D;
            newPopPos(:,:,1)=IndivRand+rand(n,n).*(IndivRand-PopPos(:,:,1))+Beta*(IndivRand-PopPos(:,:,1)); %Equation (7)
            
        else
            %disp('......... cyclone best ............')
            newPopPos(:,:,1)=BestX+rand(n,n).*(BestX-PopPos(:,:,1))+Beta*(BestX-PopPos(:,:,1)); %Equation (4)
        end
    else
        %disp('......... chain foraging ............')
        r2=rand(n,n);
        Alpha=2*r2.*(-log(r2)).^0.5;
        newPopPos(:,:,1)=PopPos(:,:,1)+rand(n,n).*(BestX-PopPos(:,:,1))+Alpha.*(BestX-PopPos(:,:,1)); %Equation (1)
    end
    parfor i=2:nPop
        if rand<0.5
            r1=rand;
            Beta=2*exp(r1*((MaxIt-It+1)/MaxIt))*(sin(2*pi*r1));
            if  Coef<rand
                %disp('......... cyclone best ............')
                IndivRand=rand(n,n)<D;
                newPopPos(:,:,i)=IndivRand+rand(n,n).*(PopPos(:,:,i-1)-PopPos(:,:,i))+Beta*(IndivRand-PopPos(:,:,i));  %Equation (7)
            else
                % disp('......... cyclone random 2............')
                newPopPos(:,:,i)=BestX+rand(n,n).*(PopPos(:,:,i-1)-PopPos(:,:,i))+Beta*(BestX-PopPos(:,:,i)); %Equation (4)
            end
        else
            %disp('......... chain foraging 2............')
            r2=rand(n,n);
            Alpha=2*r2.*(-log(r2)).^0.5;
            newPopPos(:,:,i)=PopPos(:,:,i)+rand(n,n).*(PopPos(:,:,i-1)-PopPos(:,:,i))+Alpha.*(BestX-PopPos(:,:,i)); %Equation (1)
        end
    end
    parfor i=1:nPop
        newPopPos(:,:,i)=SpaceBound(newPopPos(:,:,i),Up,Low);
        Pop1(:,:,i)=sigmoid(newPopPos(:,:,i),n);
        comptime2=tic;
        newPopFit(i)=completeness(Pop1(:,:,i),n,L,row,col);
        comtime1(i)=toc(comptime2);
        if newPopFit(i)>PopFit(i)
            PopFit(i)=newPopFit(i);
            PopPos(:,:,i)=newPopPos(:,:,i);
        end
    end
    comtime1=sum(comtime1);
    S=2;
    parfor i=1:nPop
        % disp('......... somersault foraging 2............')
        newPopPos(:,:,i)=PopPos(:,:,i)+S*(rand(n,n).*BestX-rand(n,n).*PopPos(:,:,i)); %Equation (8)
    end
    parfor i=1:nPop
        newPopPos(:,:,i)=SpaceBound(newPopPos(:,:,i),Up,Low);
        Pop2(:,:,i)=sigmoid(newPopPos(:,:,i),n);
        comptime3=tic;
        newPopFit(i)=completeness(Pop2(:,:,i),n,L,row,col);
        comtime2(i)=toc(comptime3);
        if newPopFit(i)>PopFit(i)
            PopFit(i)=newPopFit(i);
            PopPos(:,:,i)=newPopPos(:,:,i);
        end
    end
    comtime2=sum(comtime2);
    for i=1:nPop
        if PopFit(i)>BestF
            BestF=PopFit(i);
            BestX=PopPos(:,:,i);
        end
    end
    PopFitF(It,:)=sort(PopFit,'descend');
    if It>=2
        if PopFitF(It,:)== PopFitF(It-1,:)
            count = count+1;
        else
            count=0;
        end
        if count>=5
            break
        end
    end
    completenesstime(It)=comtime1+comtime2;
    HisBestFit(It)=BestF;
end
ctime=sum(completenesstime);
completenesstime=ctime+comtime;
end


