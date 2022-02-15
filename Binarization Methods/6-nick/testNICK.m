org = imread('d (3).jpg');
org=rgb2gray(org);
org=imresize(org,[60,250]);
out=nick(org,[20,20]);

figure,
subplot(2,1,1),imshow(org);title('original image')
subplot(2,1,2),imshow(out);title('nick')

