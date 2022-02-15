clc;
close all;
clear all;
WAAD_img= imread('F:\6.bmp');
WAAD_img= rgb2gray(WAAD_img);figure,imshow(WAAD_img),title('original image')
% WAAD_hist=Fn_get_hist(WAAD_img,R,C);
WAAD_hist=imhist(uint8(WAAD_img))';
m = zeros(1,5);
[R C] = size(WAAD_img);
for i = 1 : 256
    if WAAD_hist(i)>R*C/100000;     m(1) = i; break;
    end
end
for i = 256 :-1: 1
    if WAAD_hist(i)>R*C/100000;     m(5) = i; break;
    end
end
cdf_data = cumsum(WAAD_hist)/(R*C);
[val idx] = find(cdf_data >= 0.25 &cdf_data < 0.50);
if size(idx) ~= 0
    m(2) = idx(1);
    m(3) = idx(end);
else
    [val idx] = find(cdf_data > 0);
    m(2) = m(1);
    m(3) = m(1);
end
[val idx] = find(cdf_data >= 0.75);
m(4) = idx(1)-1;
% cliping 
avgFreqOfimage = floor(R*C/256);
chist_data = zeros(1,256);
for i = 1 :256
    if WAAD_hist(i) >= avgFreqOfimage
        chist_data(i) = avgFreqOfimage; 
    else 
    chist_data(i) = WAAD_hist(i);
    end
end
span= zeros(1,4);
for i = 1 : 4
    span(i) = m(i+1)-m(i);
end
range = round(256*span/sum(span));
sepPosition = cumsum([0 range]);
new_cdf= zeros(1,256);
map = zeros(1,256);
for i = 1 : 4
     if i==1      
         temp = cumsum(chist_data(m(i):m(i+1)));
        new_cdf(m(i):m(i+1)) = temp/temp(end);
        map(m(i):m(i+1)) = round(range(i)*new_cdf(m(i):m(i+1))); 
     else
         temp = cumsum(chist_data(m(i):m(i+1)));
        new_cdf(m(i):m(i+1)) = temp/temp(end);
        map(m(i):m(i+1)) = round(range(i)*new_cdf(m(i):m(i+1))+sepPosition(i));        
    end   
end
QDHE_img = zeros(R,C);
for i = 1: R
    for j = 1: C
%         QDHE_img(i,j) = map(WAAD_img(i,j));
QDHE_img(i,j) = map(1 + int16(WAAD_img(i,j)));
    end
end
QDHE_img = uint8(QDHE_img);
        figure, imshow(QDHE_img),title('QHDE')