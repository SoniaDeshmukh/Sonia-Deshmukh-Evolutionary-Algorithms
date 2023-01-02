function  X=SpaceBound(X,Up,Low)
Dim=length(X);
S=(X>Up)+(X<Low) ;
X=(rand(Dim,Dim).*(Up-Low)+Low).*S+X.*(~S);
end
