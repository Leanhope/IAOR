function [B, descriptors] = makeFourierDescriptor(bm)
    % i. extract boundaries of binary mask
    [B] = bwboundaries(bm);
    % ii. number of elements for the descriptor
    m = length(B);
    n = 24; 
    descriptors = zeros(m, n);

    for k = 1:m
        boundary = B{k};
        Df = complex(boundary(:,2), boundary(:,1));
        if length(Df) > n
            Dr = Df(1:n);
            F = fft(Dr);
            for j = 1:length(F)
                % make translation invariant
                F(j) = F(j) - F(1);
                % make scale invariant
                F(j) = F(j) / abs(F(2));
                % make rotation invariant
                F(j) = abs(F(j));
            end

            for j = 1:length(F)
                descriptors(k, j) = F(j);
            end
        end
    end
end
