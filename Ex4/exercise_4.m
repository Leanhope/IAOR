% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================
% Task A - Image filtering
pkg load image;
% Task a
im = im2double(rgb2gray(imread('taskA.png')));
% Task b
% compute noisy image
imn = imnoise(im, "gaussian", 0, 0.01); % mean = 0, variance = 0.01
figure; imshow(imn); title('Original image in grayscale with Gaussian noise');
% Task c
g = gaussgradient2D(2.8);

[h, w] = size(imn);
[gh, gw] = size(g);
row = round(h/2 - gh/2);
col = round(w/2 - gw/2);

% compute filtering kernel with same size as image
% with 2D gaussian filter and zero padding arround
g_pad = zeros(h, w);
g_pad(1:gh, 1:gw) = g;
g_pad = circshift(g_pad, round([-gh/2, -gw/2]));

% FFT of image and filter
imn_fft = fft2(imn);
g_pad_fft = fft2(g_pad);

% multiply element-wise in the frequency domain
fil_fft = g_pad_fft .* imn_fft;
% apply inverse FFT
fil = ifft2(fil_fft);
figure; imagesc(log(abs(fftshift(imn_fft)))); title('Logarithmic centered image spectra');
figure; imagesc(log(abs(fftshift(g_pad_fft)))); title('Logarithmic circular shifted padded Gaussian filter spectra');
figure; imagesc(log(abs(fftshift(fil_fft)))); title('Logarithmic centered product of spatial and frequency domain')
figure; imshow(fil); title('Filtered image');
