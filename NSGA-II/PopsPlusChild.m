function [PplusC,Totalsize,PplusCcompleteness,PplusCgeneralization] = PopsPlusChild(pool,GeneralizationArr,CompletenessArr,PopSize,Filterpopulation,x,n,L,row,col)
    Totalsize=PopSize+x;
    PplusC=zeros(n,n,Totalsize);
    PplusCgeneralization=zeros(1,Totalsize);
    PplusCcompleteness=zeros(1,Totalsize);
    index=1;
    for i=1:PopSize
        PplusC(:,:,index)=pool(:,:,i);
        PplusCgeneralization(index)=GeneralizationArr(i);
        PplusCcompleteness(index)=CompletenessArr(i);
        index=index+1;
    end
    for i=1:x
        PplusC(:,:,index)=Filterpopulation(:,:,i);
        PplusCgeneralization(index)=generalization(Filterpopulation(:,:,i),L,row,col,n);
        PplusCcompleteness(index)=completeness(Filterpopulation(:,:,i),n,L,row,col);
        index=index+1;
    end
end   