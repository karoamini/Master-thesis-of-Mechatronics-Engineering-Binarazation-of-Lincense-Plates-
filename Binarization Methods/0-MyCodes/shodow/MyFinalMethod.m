% new method to binarize non-uniform illumination plate
% Author = F.amini.        E-mail: karo.amini@gmail.com

clear all;
close all;
clc;

%% read and convert image to double

img=imread('p (14).jpg');
img=rgb2gray(img);
img=im2double(img);

%% resize image 

[m n k]=size(img);
img=imresize(img,[80,(80/m)*n]);

%% Use wiener filter to reduce noise

im=wiener2(img,[5 5]);

%% Contrast Enhancement

[m,n]=size(im);
[im]=MyImCom(im,m,n);

%% My method to binarize License plate

k=0.5;
r=128;

for i=1:m
mask=im(i,:);
Mean=mean(mask(:));
stdm=std(mask(:));
bwx(i,:)=( mask>Mean*(1+k*(stdm/r-1)));
end

%% show results

subplot(2,1,1),imshow(img),title('original')
subplot(2,1,2),imshow(bwx),title('Bw Of My Method')

