% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

function iaor_ex2
img_original = imread('ampelmaennchen.png');
img_filter = rgb2gray(im2double(img_original));
sigma = 0.5
[imx,imy] = gaussgradient(img_filter, sigma);

[W, Q] = foerstner(img_original, imx, imy);
% Exercise 1 plots
figure();
subplot(1, 2, 1);
imshow(img_filter);title("Gray scale image");
subplot(1, 2, 2);
imshow(abs(imx)+abs(imy));title("GoG filter image");
% Exercise 2
figure();
subplot(1, 3, 1);
imshow(img_original);title("Original");
subplot(1, 3, 2);
imshow(Q,colormap(jet));title("Cornerness");
subplot(1, 3, 3);
imshow(W, colormap(jet));title("Roundness");


end

function [Gx,Gy] = gaussgradient(img, sigma)
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

function [w, q] = foerstner(I, I_x, I_y)
  wn = ones(5);
  r = (wn - 1) / 2;
  %[img_w, img_h] = size(I);
  q = zeros(size(I));
  for x = r + 1:size(I,1) - r
    for y = r + 1:size(I,2) - r
      I_x2 = I_x(x - r:x + r, y - r:y + r) .^ 2 .* wn;
      I_y2 = I_y(x - r:x + r, y - r:y + r) .^ 2 .* wn;
      I_xy = I_x(x - r:x + r, y - r:y + r) .* I_y(x - r:x + r, y - r:y + r) .* wn;
      M = [sum(sum(I_x2)), sum(sum(I_xy));
           sum(sum(I_xy)), sum(sum(I_y2))];
      trace_M = trace(M);
      det_M = det(M);     
      w(x, y) = abs(trace_M / 2 - max(sqrt((trace_M / 2)^2 -  det_M),0.5));
      q(x, y) = abs((4 * det_M) / max(0.00001, (trace_M^2)));
    end
  end
end
