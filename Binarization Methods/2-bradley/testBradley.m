close all;clear all;clc;

I=rgb2gray(imread('F:\pb\12.jpg'));
I=imresize(I,[80,500]);
I=wiener2(I,[5,5]);
bw=bradley(I, [30 30], 5);
imshow(bw)