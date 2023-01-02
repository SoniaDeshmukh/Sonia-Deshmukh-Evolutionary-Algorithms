function [PplusC,PplusCcompleteness,comiter2,comtime2] = PopsPlusChild(pool,CompletenessArr,PopSize,Filterpopulation,x,n,L,row,col)
Totalsize=PopSize+x;
PplusC=zeros(n,n,Totalsize);
PplusCcompleteness=zeros(1,Totalsize);
comtime2=zeros(1,x);
index=1;
for i=1:PopSize
    PplusC(:,:,index)=pool(:,:,i);
    PplusCcompleteness(index)=CompletenessArr(i);
    index=index+1;
end
for i=1:x
    PplusC(:,:,index)=Filterpopulation(:,:,i);
    comptime=tic;
    PplusCcompleteness(index)=completeness(Filterpopulation(:,:,i),n,L,row,col);
    comtime2(i)=toc(comptime);
    index=index+1;
end
comtime2=sum(comtime2);
comiter2=x;
end