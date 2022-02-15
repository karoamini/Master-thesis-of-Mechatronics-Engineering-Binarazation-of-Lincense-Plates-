function PicHEt=FuncHE(PicGray,PicHEt,row,col,h,min,max,m,n)

pix=size(col,1);
% PZ=zeros(1,Xm(2)-1); 
PZ=zeros(1,max-min+1);

for i=min+1:max+1 
    PZ(i-min)=h(i)/pix;	 
end

% S=zeros(1,Xm(2)-1); S=zeros(1,max+1);
S(min+1)=PZ(1); 

for i=min+2:max+1 
    S(i)=PZ(i-min)+S(i-1);	 
end

FuncHE=min+(max-min)*S;

for k=1:pix 
PicHEt(row(k),col(k))=floor(FuncHE(PicGray(row(k),col(k))+1)); 
end