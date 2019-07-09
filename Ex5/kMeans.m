function rgb = kMeans(img, k, d, n)
    rgb = reshape(img(:),[],3);
    rgb = [rgb zeros(size(rgb, 1), 1)];

    centers = zeros(k,d);
    groups = zeros(k,d);
    x = zeros(1, d);
    y = zeros(1, d);
    
    x_count = 0;
    y_count = 0;
    pixelCounter = 0;
    
    size(img, 1)
    size(img, 2)
    
    if d == 5
        for i = drange(1:size(rgb, 1))
            rgb(i, 4) = x_count;
            rgb(i, 5) = y_count;
            pixelCounter = pixelCounter + 1;
            y_count = y_count + 1;
            if mod(pixelCounter, size(img, 1)) == 0
                x_count = x_count + 1;
                y_count = 0;
            end
        end
    end
    for i = drange(1:k)
        for j = drange(1, d)
            if j < 4
                centers(i, j) =  randi([0 255]);
            elseif j == 4
                centers(i, j) =  randi([0 size(img, 1)]);
            else
                centers(i, j) =  randi([0 size(img, 2)]);
            end
        end
    end
    
    go = true;
    %find the closest center
    %while go
    for l = drange(1:n)
        for i = drange(1:size(rgb, 1))
            min = 1000;
            mIndex = 1;
            if d == 3
                x = int32([rgb(i, 1), rgb(i, 2), rgb(i, 3)]);
            elseif d == 5
                x = int64([rgb(i, 1), rgb(i, 2), rgb(i, 3), rgb(i, 4), rgb(i, 5)]);
            end
            for j = drange(1,k)
                if d == 3
                    y = int32([centers(j, 1), centers(j, 2), centers(j, 3)]);
                elseif d == 5
                    y = int64([centers(j, 1), centers(j, 2), centers(j, 3), centers(j, 4), centers(j, 5)]);
                end
                if min > sqrt(sum((x - y) .^ 2))
                    min = sqrt(sum((x - y) .^ 2));
                    mIndex = j;
                end
                if j == k
                    rgb(i, d + 1) = mIndex;
                    if i > 1
                        for m = drange(1:d)
                            groups(mIndex, m) = (groups(mIndex, m) + x(m))/2;
                        end
                    else
                        for m = drange(1:d)
                            groups(mIndex, m) = x(m);
                        end
                    end
                end
            end
        end
        if groups == centers
            go = false;
        end
        centers = groups;
        groups = zeros(k,d);
    end
end