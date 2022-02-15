% BBHE --> Bi-Histogram Equalization:
tic;
% o_img=rgb2gray(o_img);
org_img = imread('moon.tif');

imshow(org_img);title('orginal image')

sz = size(org_img);

o_mean = round(mean(org_img(:)));

%  HISTOGRAM

his_L = zeros(256,1);

his_H = zeros(256,1);

for i = 1:sz(1)
    for j = 1:sz(2)
        
        g_val = org_img(i,j);
        
        if(g_val<=o_mean)
           his_L(g_val+1) = his_L(g_val+1) + 1;
        else
            his_H(g_val+1) = his_H(g_val+1)+ 1;
        end
        
    end
end

% NORMALIZED HISTOGRAM OR PDF

nh_l = his_L/sum(his_L);
nh_u = his_H/sum(his_H);

% CDF

hist_l_cdf = double(zeros(256,1));
hist_u_cdf = double(zeros(256,1));

hist_l_cdf(1) = nh_l(1);
hist_u_cdf(1) = nh_u(1);

for k = 2:256
    hist_l_cdf(k) =  hist_l_cdf(k-1) + nh_l(k);
    hist_u_cdf(k) =  hist_u_cdf(k-1) + nh_u(k);
end

% IMAGE MODIFICATION

equalized_img = zeros(sz);

range_l = [0 o_mean];
range_u = [(o_mean+1) 255];

for i =1:sz(1)
    for j =1:sz(2)
        g_val = org_img(i,j);
        
        if(g_val<=o_mean)
           equalized_img(i,j) = range_l(1) + round(((range_l(2)-range_l(1))*hist_l_cdf(g_val+1))); 
        else
           equalized_img(i,j) = range_u(1) + round(((range_u(2)-range_u(1))*hist_u_cdf(g_val+1))); 
        end
        
    end
end

figure,imshow(uint8(equalized_img));title('Equalized image')

toc;

