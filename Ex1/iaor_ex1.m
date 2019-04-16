function iaor_ex1
  imgInput = imcomplement(imread("input_sat_image.jpg"));
  imgStretched = stretch(imgInput);
  imgBin = binary(imgStretched);
  imgMorph = morph(imgBin);
  #figure, imshowpair(imgInput, imhist(imgInput), 'montage')
  #figure, imshowpair(imgStretched, imhist(imgStretched), 'montage')
  #figure, imshowpair(imgBin, imgMorph, 'montage')
  
  figure, imshow(imgInput);
  figure, imhist(imgInput);
  figure, imshow(imgStretched);
  figure, imhist(imgStretched);
  figure, imshow(imgBin);
  figure, imshow(imgMorph);
end

function stretch = stretch(img) 
  imgTemp = img(:,:,1);
  minTemp = min(imgTemp);         
  minFinal = min(minTemp);
  maxTemp = max(imgTemp);       
  maxFinal = max(maxTemp);

  middle = maxFinal - minFinal;
  disp(minFinal)
  disp(maxFinal)

  for i = 1:size(imgTemp,1)
      for j = 1:size(imgTemp,2)
       imgTemp(i, j) = (double((imgTemp(i,j) - minFinal))/double(middle))*250;
      endfor
  endfor      
  stretch = imgTemp;
end

function binary = binary(img)
  thresh = 0.675#graythresh(img);
  binary = im2bw(img, thresh);
endfunction

function morph = morph(img)
  se = strel('disk',4, 0);
  imgTemp = imopen(img, se);
  #figure, imshow(imgTemp)
  morph = imclose(imgTemp, se);
endfunction
