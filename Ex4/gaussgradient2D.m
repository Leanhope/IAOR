function g = gaussgradient2D(sigma)
  size = round(3 * sigma);
  Gx = zeros(size,size);
  r = (size-1)/2;
  for i = -r:r
      for j = -r:r
          % centering
          x0 = (size+1)/2;y0=(size+1)/2;
          row = i+x0;
          col = j+y0;
          Gx(col,row) = exp(-((row-x0)^2+(col-y0)^2)/2/sigma/sigma);
      end
  end
  % normalize filter
  g = Gx/sum(sum(Gx));
end