function  [PplusC,Totalsize,PplusCcompleteness,PplusCgeneralization] = PopsPlusChild(population,archive,fit1,Com1,populationgeneralization,populationcompleteness,n,L,row,col);
    Totalsize=length(populationgeneralization)+length(fit1);
    PplusC=zeros(n,n,Totalsize);
    PplusCgeneralization=zeros(1,Totalsize);
    PplusCcompleteness=zeros(1,Totalsize);
    index=1;
    for i=1:length(populationgeneralization)
        PplusC(:,:,index)=population(:,:,i);
        PplusCgeneralization(index)=populationgeneralization(i);
        PplusCcompleteness(index)=populationcompleteness(i);
        index=index+1;
    end
    for i=1:length(fit1)
        PplusC(:,:,index)=archive(:,:,i);
        PplusCgeneralization(index)=fit1(i);
        PplusCcompleteness(index)=Com1(i);
        index=index+1;
    end
end   