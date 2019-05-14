function [w, q] = foerstner(I, Ix, Iy)
  wn = ones(5);
  %r = (wn - 1) / 2;
  dim = size(wn);
  r = floor(dim(1) / 2);
  %[img_w, img_h] = size(I);
  q = zeros(size(I));
  w = zeros(size(I));
  for x = r + 1:size(I,1) - r
    for y = r + 1:size(I,2) - r
      I_x2 = Ix(x - r:x + r, y - r:y + r) .^ 2 .* wn;
      I_y2 = Iy(x - r:x + r, y - r:y + r) .^ 2 .* wn;
      I_xy = Ix(x - r:x + r, y - r:y + r) .* Iy(x - r:x + r, y - r:y + r) .* wn;
      M = [sum(sum(I_x2)), sum(sum(I_xy));
           sum(sum(I_xy)), sum(sum(I_y2))];
      trace_M = trace(M);
      det_M = det(M);     
      tw = trace_M / 2 - sqrt((trace_M / 2)^2 - det_M);
      if tw > 0
        w(x, y) = tw;
      end
      tq = 4 * det_M / (trace_M^2 + eps);
      if tq > 0 && tq < 1
        q(x, y) = tq;
      end
    end
  end
end
