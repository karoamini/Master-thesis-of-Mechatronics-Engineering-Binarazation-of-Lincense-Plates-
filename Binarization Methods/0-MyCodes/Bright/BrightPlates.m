clear all;
close all;
clc;

im=imread('p (3).jpg');
im=rgb2gray(im);
[m,n]=size(im);

im=imresize(im,[80,500]);

im=wiener2(im,[5 5]);
figure,
subplot(2,1,1);imshow(im),title('original')

Enhanced=size(im);
for i=1:size(im,1)
    for j=1:size(im,2)
        in = (im(i,j)+1);
        Enhanced(i,j) = exp(double(in)/46.01);
    end
end

% subplot(3,1,2);imshow(uint8(Enhanced));title('Enhanced image')


M=50;
N=20;

bw=MySauvola(Enhanced,M,N);

subplot(2,1,2),imshow(bw),title('bw of MySauvola')

