%  MG approach
function BWI=MyNiblack(I)
[row, col]=size(I);

%I=I/255;
k=-0.2;
L=7;
Itemp=zeros(row+2*L,col+2*L);
Itemp(L+1:row+L,L+1:col+L)=I;
for i=1:row
    for j=1:col

            mask=Itemp(i:i+2*L,j:j+2*L);
            mu=mean(mask(:));
            ST=std(mask(:));
            T=mu+k*ST^2;
            if I(i,j)>T
               BWI(i,j)=1;
            else
               BWI(i,j)=0;
            end     
        end
    end
end
        
        