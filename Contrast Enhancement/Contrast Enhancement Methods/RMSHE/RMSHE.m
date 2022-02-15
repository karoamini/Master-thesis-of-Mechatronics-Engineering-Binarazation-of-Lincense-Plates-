clear;
clc;

PicOri=imread('C:\Users\karo\Desktop\RMSHE\girl.bmp');

PicGray=rgb2gray(PicOri);
figure(1),imshow(PicGray),title('original image');

h=imhist(PicGray);
figure(2),plot(h),title('Histogram of orginal image');

[m,n]=size(PicGray);
PicHEt=zeros(m,n);

max=double(max(PicGray(:)));		%Maximum value
min=double(min(PicGray(:)));		%Minimum value

r=1;
length=2^r+1;
Xm=zeros(1,length);
Xm(1)=max+1;
Xm(2)=min+1;

for i=1:r
	for j=1:2^(i-1)
		Xm(2^(i-1)+j+1)=averpixcal(h,Xm(2^(i-1)-j+2),Xm(2^(i-1)-j+1));
	end
	Xm=sort(Xm,'descend');
end
Xm=sort(Xm);

for i=2:2^r
	[row,col]=find((PicGray>=Xm(i-1)-1)&(PicGray<=Xm(i)-2));
    PicHEt=FuncHE(PicGray,PicHEt,row,col,h,Xm(i-1)-1,Xm(i)-2,m,n);
end
[row,col]=find((PicGray>=Xm(2^r)-1)&(PicGray<=Xm(2^r+1)-1));
PicHEt=FuncHE(PicGray,PicHEt,row,col,h,Xm(2^r)-1,Xm(2^r+1)-1,m,n);

PicHE=uint8(PicHEt);
h1=imhist(PicHE);
figure(3),plot(h1),title('histogram of RMSHE');
figure(4),imshow(PicHE),title('RMSHE');

