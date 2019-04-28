function iaor_ex2
im=imread('ampelmaennchen.png');
fim=rgb2gray(im2double(im));
[imx,imy]=gaussgradient(fim,0.5);
%imshow(imx, [])
%imshow(imy, [])
imshow(abs(imx)+abs(imy));
end

function [Gx,Gy]=gaussgradient(img,sigma)
radius = 2;
size = 5;
Gx = zeros(5,5);

for i=1:size
    for j=1:size
        u=[i-radius-1 j-radius-1];
        Gx(i,j)= (exp(-u(1)^2/(2*sigma^2)) / (sigma*sqrt(2*pi))) * ...
        (-u(2) * exp(-u(2)^2/(2*sigma^2)) / (sigma*sqrt(2*pi)) / sigma^2);
    end
end

Gy=Gx';

Gx=imfilter(img,Gx,'conv');
Gy=imfilter(img,Gy,'conv');
end