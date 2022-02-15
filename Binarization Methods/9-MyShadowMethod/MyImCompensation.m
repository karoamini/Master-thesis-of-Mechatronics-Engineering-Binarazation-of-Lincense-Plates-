%%%%%%%%%%%%%%%%%%%%%%%%%% Image Compensation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CEI]=MyImCom(I,h,w)
%c=0.9;
% hist=imhist(I);
% hp=[]; flag=0;
sigma=50/255;   
ave=mean2(I);
sted=std2(I);  
    CEI=zeros(h,w);
    for i=1:w*h
        CEI(i)= ((I(i)-0.6*ave)*sqrt(sigma/sted));
        if CEI(i)<0
            CEI(i)=0;
        elseif CEI(i)>255
            CEI(i)=255;
        end
    end
%figure, imshow(CEI);
end