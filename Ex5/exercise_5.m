% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

% Choose image
img = imread('inputEx5_1.jpg');
%img = imread('inputEx5_2.jpg');

k = 5; %amount of centers
d = 3; %number of dimensions
n = 5; %number of iterations, when while loop takes too long

%rgb = kMeans(img, k, d, n);

w = 20;
c = 3;
[output, pixels1, pixels2] = meanShift(img, w, c);

%figure;
%scatter3(rgb(:,1), rgb(:,2), rgb(:,3), [], rgb(:,4))
%b2img = reshape(rgb(:,4), [size(img, 1), size(img, 2)]);
%figure;
%imshow(imadjust(b2img,stretchlim(b2img),[]))

figure;
subplot(1,2,1),imshow(img); title('Original image');
subplot(1,2,2),imshow(output); title('Mean shift image');
figure;
subplot(1,2,1),plot3(pixels1(:,1),pixels1(:,2),pixels1(:,3),'o');title('Histogram of original image');
subplot(1,2,2),plot3(pixels2(:,1),pixels2(:,2),pixels2(:,3),'o');title('Histogram of segmented image');

