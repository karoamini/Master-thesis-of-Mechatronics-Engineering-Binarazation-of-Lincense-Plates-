clear all
close all
clc

I=imread('5.jpg');
I=rgb2gray(I);

[A, T] = EntropyThresholding(I);

figure,
subplot(2,1,1),imshow(I);title('original image')
subplot(2,1,2),imshow(A);title('Kapur image')
