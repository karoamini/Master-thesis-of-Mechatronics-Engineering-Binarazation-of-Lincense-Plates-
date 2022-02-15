function Xm=cdfdivcal(h,divarea)

SUM(1)=h(1);
for i=2:256
	SUM(i)=h(i)+SUM(i-1);
end

index=find(SUM>=divarea);
Xm=index(1);