tic
clear all;
close all;
clc;
img=imread('d (1).jpg');
img=rgb2gray(img);
[m n k]=size(img);
% img=imresize(img,[80,(80/m)*n]);
img=imresize(img,[60,250]);
BW = niblack(img,[30,30]);


figure,
subplot(2,1,1),imshow(img);title('original image')
subplot(2,1,2),imshow(BW);title('Niblack')
toc