% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

function iaor_ex2
img_original = imread('ampelmaennchen.png');
img_filter = rgb2gray(im2double(img_original));
% 2D GoG filter computation
sigma = 0.5; % standard deviation
[imx,imy] = gaussgradient(img_filter, sigma);
magnitude = abs(imx)+abs(imy); %compute the gradient magnitude
% Exercise 1 plots
figure(1);
subplot(1, 3, 1); imshow(img_original); title('Original image');
subplot(1, 3, 2); imshow(img_filter); title('Gray scale image');
subplot(1, 3, 3); imshow(magnitude); title('GoG filter image');

[W, Q] = foerstner(img_filter, imx, imy);
% Exercise 2 plots
figure(2);
subplot(1, 3, 1); imshow(img_original); title('Original image');
%subplot(1, 4, 2); imshow(imx, []); subplot(1, 4, 3); imshow(imy, []);
subplot(1, 3, 2); imshow(W); colormap('jet'); title('Cornerness');
subplot(1, 3, 3); imshow(Q); colormap('jet'); title('Roundness'); %Roundness result looks different than in the slides, although we use a threshold given there..

mask = zeros(size(img_filter));
for i = 1:numel(W)
   if W(i) > 0.004
       if Q(i) > 0.5
           mask(i) = 1;
       end
   end
end
result = img_filter + mask;
figure();
imshow(result);title('With binary map applied.');

