% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================
% Task A - Image filtering
%pkg load image;
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
[values_train, Df_train] = makeFourierDescriptor(bmtrainB);
%figure; plot(Df_train); %Graph Fourier


test1B = im2double(rgb2gray(imread('test1B.jpg')));
bmtest1B = imbinarize(test1B, graythresh(test1B));
[valuesB1, img1descriptors] = makeFourierDescriptor(bmtest1B);
figure; imshow(bmtest1B);
hold on
for k = 1:length(img1descriptors)
    norm(Df_train - img1descriptors(k, :))
    if norm(Df_train - img1descriptors(k, :)) < 0.06
        boundary = valuesB1{k};
        plot(boundary(:,2),  boundary(:,1), 'r', 'LineWidth', 2); 
    end
end

test2B = im2double(rgb2gray(imread('test2B.jpg')));
bmtest2B = imbinarize(test2B, graythresh(test2B));
[valuesB2, img2descriptors] = makeFourierDescriptor(bmtest2B);
figure; imshow(bmtest2B);
hold on
for k = 1:length(img2descriptors)
    norm(Df_train - img2descriptors(k, :))
    if norm(Df_train - img2descriptors(k, :)) < 0.06
        boundary = valuesB2{k};
        plot(boundary(:,2),  boundary(:,1), 'r', 'LineWidth', 2); 
    end
end

test3B = im2double(rgb2gray(imread('test3B.jpg')));
bmtest3B = imbinarize(test3B, graythresh(test3B));
[valuesB3, img3descriptors] = makeFourierDescriptor(bmtest3B);
figure; imshow(bmtest3B);
hold on
for k = 1:length(img3descriptors)
    norm(Df_train - img3descriptors(k, :))
    if norm(Df_train - img3descriptors(k, :)) < 0.06
        boundary = valuesB3{k};
        plot(boundary(:,2),  boundary(:,1), 'r', 'LineWidth', 2); 
    end
end
