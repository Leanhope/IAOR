function iaor_ex1
  J = imread("input_sat_image.jpg");
  #figure, imshow(J);
  #figure, imhist(J);
  #stretched = imadjust(J, stretchlim(J, [0, 1]));
  #figure, imshow(stretched);
  #figure, imhist(stretched);
  imgStretched = stretched(J);
  figure, imshow(imgStretched);
  figure, imhist(imgStretched); 
end

function stretched = stretched(img) 
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
  stretched = imgTemp;
end