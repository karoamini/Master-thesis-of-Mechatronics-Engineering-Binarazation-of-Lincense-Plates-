clear;
clc;

PicOri=imread('F:\6.bmp');
% if isgray(PicOri)==0		
% 	PicGray=rgb2gray(PicOri);
% else
% 	PicGray=PicOri;
% end
PicGray=rgb2gray(PicOri);
figure(1),imshow(PicGray),title('Original image');

h=imhist(PicGray);
figure(2),imhist(PicGray),title('Histogram of original image');

[m,n]=size(PicGray);
PicHEt=zeros(m,n);
N=m*n;

max=double(max(PicGray(:)));		% maximum Level
min=double(min(PicGray(:)));		% Minimum Level

r=2;
length=2^r+1;
Xm=zeros(1,length);
Xm(1)=max+1;
Xm(2)=min+1;

for i=3:length
	divarea=((i-2)*N)/(2^r);
	Xm(i)=cdfdivcal(h,divarea);
end
Xm=sort(Xm);

for i=2:2^r
	[row,col]=find((PicGray>=Xm(i-1)-1)&(PicGray<=Xm(i)-2)); %[0:Xm(2)-2]
	PicHEt=FuncHE(PicGray,PicHEt,row,col,h,Xm(i-1)-1,Xm(i)-2);
end
[row,col]=find((PicGray>=Xm(2^r)-1)&(PicGray<=Xm(2^r+1)-1));
PicHEt=FuncHE(PicGray,PicHEt,row,col,h,Xm(2^r)-1,Xm(2^r+1)-1);

PicHE=uint8(PicHEt);
h1=imhist(PicHE);
figure(3),imshow(PicHE),title('RSIHE');
figure(4),imhist(PicHE),title('Histogram of RSIHE');
