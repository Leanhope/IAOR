% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

function iaor_ex2
img_original = imread('ampelmaennchen.png');
img_filter = rgb2gray(im2double(img_original));
sigma = 0.5
[imx,imy] = gaussgradient(img_filter, sigma);
% Exercise 1 plots
figure(1);
subplot(1, 3, 1); imshow(img_original); title("Original image");
subplot(1, 3, 2); imshow(img_filter); title("Gray scale image");
subplot(1, 3, 3); imshow(abs(imx)+abs(imy)); title("GoG filter image");

[W, Q] = foerstner(img_filter, imx, imy);
% Exercise 2
figure(2);
subplot(1, 3, 1); imshow(img_original); title("Original image");
subplot(1, 3, 2); imshow(Q, []); colormap(jet);title("Cornerness");
subplot(1, 3, 3); imshow(W, []);title("Roundness");
end


