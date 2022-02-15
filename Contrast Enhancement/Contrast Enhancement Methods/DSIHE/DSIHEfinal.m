clear;
clc;
tic,
PicGray=imread('F:\hands.jpg');
PicGray=rgb2gray(PicGray);
% if isgray(PicOri)==0		
% 	PicGray=rgb2gray(PicOri);
% else
% 	PicGray=PicOri;
% end
figure(1),imshow(PicGray),title('original gray image');

h=imhist(PicGray);
figure(2),plot(h),title('histogram of original image');

[m,n]=size(PicGray);

halfarea=floor(m*n/2);

SUM(1)=h(1);
for i=2:256
	SUM(i)=h(i)+SUM(i-1);
end

index=find(SUM>=halfarea);
Xm=index(1);

max=double(max(PicGray(:)));		%maximum value
min=double(min(PicGray(:)));		%minimum value

[rowl,coll]=find(PicGray<=Xm);
pixl=size(coll,1);

PZL=zeros(1,Xm+1);
for i=1:Xm+1
	PZL(i)=h(i)/pixl;				%Low level PDF
end

SL=zeros(1,Xm+1);
SL(1)=PZL(1);
for i=2:Xm+1
	SL(i)=PZL(i)+SL(i-1);		%Low level CDF
end

FuncHEL=min+(Xm-min)*SL;			%tabe tabdil

PicHE1=zeros(m,n);

for k=1:pixl
	PicHE1(rowl(k),coll(k))=floor(FuncHEL(PicGray(rowl(k),coll(k))+1));
end

[rowu,colu]=find(PicGray>Xm);
pixu=size(colu,1);

PZU=zeros(1,max-Xm-1);
for i=Xm+2:max
	PZU(i-Xm-1)=h(i)/pixu;				%UP level PDF
end

%SU=zeros(1,max-Xm-1);
SU=zeros(1,max);
SU(Xm+2)=PZU(1);
for i=Xm+3:max
	SU(i)=PZU(i-Xm-1)+SU(i-1);		%Up level CDF
end

FuncHEU=Xm+(max-Xm)*SU;			%tabe tadil

for k=1:pixu
	PicHE1(rowu(k),colu(k))=floor(FuncHEU(PicGray(rowu(k),colu(k))));
end


PicHE=uint8(PicHE1);
h1=imhist(PicHE);
figure(3),plot(h1),title('Histoogram of Enhanced image');
figure(4),imshow(PicHE),title('DSIHE');

toc,
