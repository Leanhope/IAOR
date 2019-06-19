function [B, descriptors] = makeFourierDescriptor(bm)
    % i. extract boundaries of binary mask
    B = bwboundaries(bm);
    % ii. number of elements for the descriptor
    m = length(B);
    n = 24; 
    descriptors = zeros(1, n);
    count = 1;
    
    for k = 1:size(B,1)
        boundary = B{k};
        Df = complex(boundary(:,2), boundary(:,1));
        Df = fft(Df);
        if size(Df, 1) > n
          % make translation, scale, rotation invariant
          Df = Df(1:(n+1));
          Df = Df(2:(size(Df)));
          Df = Df / abs(Df(1));
          Df = abs(Df);
          for i = 1:n
            descriptors(count, i) = Df(i);
          end
         else
          descriptors(count,:) = zeros(1,n);
        end
        count = count + 1;
    end
end