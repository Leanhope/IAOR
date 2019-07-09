% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

%When using the image coordinates as the 4th and 5th dimension in the
%k-Means algorithm, more centers must be selected. The results are not
%significantly better, while both being rather bad.
%Our implementation of the k-means algorithm seems suboptimal, so it takes
%a lot of time to execute, we limited the number of iterations.
%The meanshift algorithm produced significantly better results than the
%kMeans algorithm, also with a considerably faster runtime.

% Choose image
img = imread('inputEx5_1.jpg');
%img = imread('inputEx5_2.jpg');

k = 4; %amount of centers
d = 3; %number of dimensions
n = 3; %number of iterations, when while loop takes too long

rgb = kMeans(img, k, d, n);
figure;
subplot(1,2,1), scatter3(rgb(:,1), rgb(:,2), rgb(:,3), [], rgb(:,d+1))
b2img = reshape(rgb(:,d+1), [size(img, 1), size(img, 2)]);
subplot(1,2,2),imshow(imadjust(b2img,stretchlim(b2img),[]), 'Colormap',jet(255))

k = 5;
d = 5; %number of dimensions
n = 3;

rgb = kMeans(img, k, d, n);
figure;
subplot(1,2,1), scatter3(rgb(:,1), rgb(:,2), rgb(:,3), [], rgb(:,d+1))
b2img = reshape(rgb(:,d+1), [size(img, 1), size(img, 2)]);
subplot(1,2,2),imshow(imadjust(b2img,stretchlim(b2img),[]), 'Colormap',jet(255))

w = 20;
c = 3;

[output, pixels1, pixels2] = meanShift(img, w, c);

figure;
subplot(1,2,1),imshow(img); title('Original image');
subplot(1,2,2),imshow(output); title('Mean shift image');
figure;
subplot(1,2,1),plot3(pixels1(:,1),pixels1(:,2),pixels1(:,3),'o');title('Histogram of original image');
subplot(1,2,2),plot3(pixels2(:,1),pixels2(:,2),pixels2(:,3),'o');title('Histogram of segmented image');

