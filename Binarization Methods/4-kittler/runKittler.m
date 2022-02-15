clear all;
close all;
clc;

img=imread('3.jpg');
img=rgb2gray(img);

[T, V] = kittler(img);
bw=img>T;

figure,
subplot(2,1,1),imshow(img);title('original image')
subplot(2,1,2),imshow(bw);title('Kittler image')