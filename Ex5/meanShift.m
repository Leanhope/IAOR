function [output, pixels1, pixels2] = meanShift(img, w, c)
rgbrange = 256;
input = imresize(img,[rgbrange,rgbrange]); % needs the image package!
windowsize = w;
colorspace = c;
convergence = 3;


% make the color histogram
num_clusters = 10;
hist1 = zeros([num_clusters num_clusters num_clusters]);
center = 0;
for i = 1:size(input, 1)
  for j = 1:size(input, 2)
    p = double(reshape(input(i, j,:),[1 3]));
    p = floor(p/(rgbrange/num_clusters)) + 1;
    center = center + 1;
    arr1(center,:) = [p(1),p(2),p(3)];
    hist1(p(1),p(2),p(3)) = hist1(p(1),p(2),p(3)) + 1;
    pixels1(center,:) = [input(i,j,:)];
  end
end
hist1 = hist1(:);
hist1 = hist1./sum(hist1);
finalhist = reshape(hist1,[num_clusters,num_clusters,num_clusters]);

height = size(input,1);
width = size(input,2);
output=input;

% Starting the mean shift algorithm
for i = 1:size(input,1)
  for j = 1:size(input,2)
    p_y = i;
    p_x = j;
    %window boundaries
    left = p_x - windowsize;
    right = p_x + windowsize;
    lower = p_y - windowsize;
    upper = p_y + windowsize;
    
    % check window boundaries
    if (left < 1) left = 1; end
      if (lower < 1) lower = 1; end
        if (right > height) right = height; end
          if (upper > width) upper = width; end
            patch=input(left:right, lower:upper,:);
            R = input(p_y, p_x, 1);
            G = input(p_y, p_x, 2);
            B = input(p_y,p_x,3);
            factor = rgbrange/num_clusters;
            new_red = ceil(double(R)/factor);
            new_green = ceil(double(G)/factor);
            new_blue = ceil(double(B)/factor);
            distance = convergence + 1;
            while(distance > convergence)
            hr = min(num_clusters,(new_red + colorspace));
            lr = max(1,(new_red - colorspace));
            hg = min(num_clusters,(new_green + colorspace));
            lg = max(1,(new_green - colorspace));
            hb = min(num_clusters,(new_blue + colorspace));
            lb = max(1,(new_blue - colorspace));
            s_r = 0;
            s_b = 0;
            s_g = 0;
            weight = 0;
            for k = lr:hr
              for l = lg:hg
                for m = lb:hb
                  s_r = s_r + k * finalhist(k,l,m);
                  s_g = s_g + l * finalhist(k,l,m);
                  s_b = s_b + m * finalhist(k,l,m);
                  weight = weight + finalhist(k,l,m);
                end
              end
            end
            s_r = s_r/weight;
            s_g = s_g/weight;
            s_b = s_b/weight;
            rd = (s_r-new_red);
            gd = (s_g-new_green);
            bd = (s_b-new_blue);
            distance = sqrt(rd^2 + gd^2 + bd^2);
            new_red = round(s_r);
            new_green = round(s_g);
            new_blue = round(s_b);
          end
          color_r = new_red*(rgbrange/num_clusters); % compute new color
          color_g = new_green*(rgbrange/num_clusters);
          color_b = new_blue*(rgbrange/num_clusters);
          output(i,j,1) = color_r;
          output(i,j,2) = color_g;
          output(i,j,3) = color_b;
        end
      end
      % color histogram for output image
      hist2 = zeros([num_clusters num_clusters num_clusters]);
      center = 0;
      for i = 1:size(output, 1)
        for j = 1:size(output, 2)
          p = double(reshape(output(i, j,:),[1 3]));
          p = floor(p/(rgbrange/num_clusters)) + 1;
          center = center + 1;
          arr2(center,:) = [p(1),p(2),p(3)];
          pixels2(center,:) = [output(i,j,:)];
        end
      end
end