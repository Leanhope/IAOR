% Exercise A,b and d
% The histogramm of the original image shows us
% that the grey values are in a small range, which 
% means there is little contrast in the image. 
% After applying contrast stretching the histogramm
% shows a much wider range of values. The image 
% displays a lot more darker values, the histogramm 
% has shifted towards zero (black).

% Exercise B, c
% We tested different values for the threshold before 
% choosing to use the graythresh function.
% At 0.5, the image was missing some areas that were
% supposed to be kept (houses).
% When increasing the value to 0.8, almost the whole
% image is whited out, no houses remain.
% When decreasing to 0.3, almost the entire river remains.
% At 0.4, only a small bit of the river is seen.
% In the end, we chose to use the graythresh function,
% since it got a better result than our chosen values.

% Exercise E
% The results are not ideal but satisfy our requirements.
% There are some 'holes' in the housing areas resulting 
% from the morphological filtering. This could result
% in difficulties, if the images need to be analysed further.
% The method to separate the background from the foreground
% is only possible if there is a high contrast between them.
% Obtaining a high contrast image without losing other details
% may not always be possible.

function iaor_ex1
  imgInput = imread('input_sat_image.jpg');
  imgStretched = stretch(imgInput);
  imgBin = binary(imgStretched);
  imgMorph = morph(imgBin);

  figure;
  subplot(3,2,1); imshow(imgInput); title('Original Image');
  subplot(3,2,2); plot(imhist(imgInput)); title('Histogramm of the OI')
  subplot(3,2,3); imshow(imgStretched); title('Contrast Stretched Image');
  subplot(3,2,4); plot(imhist(imgStretched)); title('Histogramm of the CSI');
  subplot(3,2,5); imshow(imgBin); title('Binarized Image');
  subplot(3,2,6); imshow(imgMorph); title('Morphological Filter');
  
  % Overlay of the contrast stretched image with the filtered mask
  imgFinal = imoverlay(imgStretched,imgMorph,'white');
  figure, imshow(imgFinal); title('Final Image'); 
end

% Image enhancement through contrast stretching
function stretch = stretch(img) 
  imgTemp = img(:,:,1);
  minTemp = min(imgTemp);         
  minFinal = min(minTemp);
  maxTemp = max(imgTemp);       
  maxFinal = max(maxTemp);

  middle = maxFinal - minFinal;
  
  for i = 1:size(imgTemp,1)
      for j = 1:size(imgTemp,2)
          imgTemp(i, j) = (double((imgTemp(i,j) - minFinal))/double(middle))*255;
      end
  end      
  stretch = imgTemp;
end
% Gets threshold and binarizes image 
function binary = binary(img)
  thresh = graythresh(img);
  binary = imcomplement(imbinarize(img, thresh));
end

% Morphological filtering opens and closes 
function morph = morph(img)
  se = strel('disk',4,0); % We chose disk radius through experimenting for best results
  imgTemp = imopen(img, se);
  morph = imclose(imgTemp, se);
end
