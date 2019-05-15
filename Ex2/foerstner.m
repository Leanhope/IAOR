function [w, q] = foerstner(I, I_x, I_y)
  w_N = ones(5); % image window
  dim = size(w_N);
  r = floor(dim(1) / 2);
  
  q = zeros(size(I));
  w = zeros(size(I));
   
  for x = r + 1:size(I,1) - r
    for y = r + 1:size(I,2) - r
      I_x2 = w_N .* I_x(x - r:x + r, y - r:y + r) .^ 2;
      I_y2 = w_N .* I_y(x - r:x + r, y - r:y + r) .^ 2;
      I_xy = w_N .* I_x(x - r:x + r, y - r:y + r) .* I_y(x - r:x + r, y - r:y + r);
      % M = [I_x2 I_xy;I_xy I_y2]
      M = [sum(sum(I_x2)), sum(sum(I_xy)); 
           sum(sum(I_xy)), sum(sum(I_y2))];
      trace_M = trace(M);
      det_M = det(M);     
      tw = trace_M / 2 - sqrt((trace_M / 2)^2 - det_M);
      if tw > 0.0004 % apply given threshold
        w(x, y) = tw;
      end
      tq = 4 * det_M / (trace_M^2 + eps);
      if tq > 0.5
        q(x, y) = tq;
      end
    end
  end
end
