% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================
% Task A - Image filtering
pkg load image;
% Task a
imgA = im2double(rgb2gray(imread('taskA.png')));
% Task b
% compute noisy image
i_noise = imnoise(imgA, "gaussian", 0, 0.01); % mean = 0, variance = 0.01
%figure; imshow(i_noise); title('Original image in grayscale with Gaussian noise');
% Task c
g = gaussgradient2D(2.8);

[h, w] = size(i_noise);
[gh, gw] = size(g);
row = round(h/2 - gh/2);
col = round(w/2 - gw/2);

% compute filtering kernel with same size as image
% with 2D gaussian filter and zero padding arround
g_pad = zeros(h, w);
g_pad(1:gh, 1:gw) = g;
g_pad = circshift(g_pad, round([-gh/2, -gw/2]));

% FFT of image and filter
imn_fft = fft2(i_noise);
g_pad_fft = fft2(g_pad);

% multiply element-wise in the frequency domain
fil_fft = g_pad_fft .* imn_fft;
% apply inverse FFT
fil = ifft2(fil_fft);
%figure; imagesc(log(abs(fftshift(imn_fft)))); title('Logarithmic centered image spectra');
%figure; imagesc(log(abs(fftshift(g_pad_fft)))); title('Logarithmic circular shifted padded Gaussian filter spectra');
%figure; imagesc(log(abs(fftshift(fil_fft)))); title('Logarithmic centered product of spatial and frequency domain')
%figure; imshow(fil); title('Filtered image after inverse FFT');

% Task B - Shape recognition
% Task a
trainB = im2double(rgb2gray(imread('trainB.png')));
% Task b
bmtrainB = im2bw(trainB,graythresh(trainB));
% Task c
Df_train = makeFourierDescriptor(bmtrainB);
%figure; plot(Df_train); %Graph Fourier

test1B = im2double(rgb2gray(imread('test1B.jpg')));
bmtest1B = im2bw(test1B, graythresh(test1B));
img1BF = makeFourierDescriptor(bmtest1B); title('Boundaries of image test1B');
%figure; plot(img1BF); %Graph Fourier
if norm(Df_train .- img1BF) < 0.06
  print "Found something";
endif
%test2B = im2double(rgb2gray(imread('test2B.jpg')));
%bmtest2B = im2bw(test2B, graythresh(test2B));
%img2BF = makeFourierDescriptor(bmtest2B);
%figure; plot(img2BF); %Graph Fourier

%test3B = im2double(rgb2gray(imread('test3B.jpg')));
%bmtest3B = im2bw(test3B, graythresh(test3B));
%img3BF = makeFourierDescriptor(bmtest3B);
%figure; plot(img3BF); %Graph Fourier
