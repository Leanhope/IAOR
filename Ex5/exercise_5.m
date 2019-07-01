% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

%img = imread('inputEx5_1.jpg');
img = imread('inputEx5_2.jpg');

k = 5; %amount of centers
d = 3; %number of dimensions
n = 5; %number of iterations, when while loop takes too long

rgb = kMeans(img, k, d, n);

figure;
scatter3(rgb(:,1), rgb(:,2), rgb(:,3), [], rgb(:,4))
b2img = reshape(rgb(:,4), [size(img, 1), size(img, 2)]);
figure;
imshow(imadjust(b2img,stretchlim(b2img),[]))
