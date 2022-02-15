close all,clear all ;clc

I=imread('p (13).jpg');
subplot(2,1,1),imshow(I);title('original image');
I=rgb2gray(I);
ws=30;C=0.03;


[m n]=size(I);
I=imresize(I,[80,(80/m)*n]);

I=wiener2(I,[5 5]);
IM=mat2gray(I);
% figure,imshow(I),title('IM');

mIM=imfilter(IM,fspecial('average',ws),'replicate');
% figure,imshow(mIM),title('mIM');

sIM=mIM-IM-C;
% figure,imshow(sIM),title('sIM');

bw=im2bw(sIM,0);
bw=imcomplement(bw);
subplot(2,1,2),imshow(bw),title('bw')