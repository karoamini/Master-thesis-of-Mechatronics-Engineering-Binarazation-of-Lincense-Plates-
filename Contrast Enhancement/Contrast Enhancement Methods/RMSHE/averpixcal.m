function Xm=averpixcal(h,begin,ending)



PixSum=0;
Sum=0;
for i=begin:ending
	PixSum=(i-1)*h(i)+PixSum;
	Sum=h(i)+Sum;
end

Xm=ceil(PixSum/Sum);