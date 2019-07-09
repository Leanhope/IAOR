% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

%When using the image coordinates as the 4th and 5th dimension in the
%k-Means algorithm, more centers and iterations were necessary to achieve
%comparable results

%img = imread('inputEx5_1.jpg');
img = imread('inputEx5_2.jpg');

k = 3; %amount of centers
d = 3; %number of dimensions
n = 1; %number of iterations, when while takes too long...

rgb = kMeans(img, k, d, n);
figure;
scatter3(rgb(:,1), rgb(:,2), rgb(:,3), [], rgb(:,d+1))
b2img = reshape(rgb(:,d+1), [size(img, 1), size(img, 2)]);
figure;
imshow(imadjust(b2img,stretchlim(b2img),[]), 'Colormap',jet(255))

k = 4;
d = 5; %number of dimensions
n = 2;
rgb = kMeans(img, k, d, n);
figure;
scatter3(rgb(:,1), rgb(:,2), rgb(:,3), [], rgb(:,d+1))
b2img = reshape(rgb(:,d+1), [size(img, 1), size(img, 2)]);
figure;
imshow(imadjust(b2img,stretchlim(b2img),[]), 'Colormap',jet(255))
