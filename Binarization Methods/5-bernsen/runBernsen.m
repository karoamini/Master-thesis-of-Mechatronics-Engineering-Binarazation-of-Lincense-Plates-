clear all;
close all;
clc;

img=imread('4.jpg');
img=rgb2gray(img);

BW= bernsen(img,[25,25]);

figure,
subplot(2,1,1),imshow(img);title('original image')
subplot(2,1,2),imshow(BW);title('bernsen image')