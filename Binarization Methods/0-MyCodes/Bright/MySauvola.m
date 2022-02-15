

function [BW]=MySauvola(im,M,N)

k=0.5;
r=128;


out=[];
[row,col]=size(im);
for i=1:N:row
     out1 = []; %// Inner matrix
     for j=1:M:col
          mask=im(i:i+N-1,j:j+M-1);
         meaN=mean(mask(:));
         stdm=std(mask(:));

bwx = ( mask > meaN * ( 1 + k* ( stdm / r - 1 ) ) );

          out1 = [out1 bwx];
     end
     out = [out; out1];%figure,imshow(out1)
end
BW=out;