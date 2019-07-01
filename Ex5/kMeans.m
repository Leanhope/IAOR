function rgb = kMeans(img, k, d, n)

rgb = reshape(img(:),[],3);
rgb = [rgb zeros(size(rgb, 1), 1)];

centers = zeros(k,d);
groups = zeros(k,d);
groups_tmp = zeros(k,d);

for i = drange(1:k)
    for j = drange(1, d)
        centers(i, j) =  randi([0 255]);
    end
end

%find the closest center
%while groups_tmp ~= centers
for l = drange(1:n)
    for i = drange(1:size(rgb, 1))
        min = 1000;
        mIndex = 1;
        x = int16([rgb(i, 1), rgb(i, 2), rgb(i, 3)]);
        for j = drange(1,k)
            y = int16([centers(j, 1), centers(j, 2), centers(j, 3)]);
            if min > sqrt(sum((x - y) .^ 2))
                min = sqrt(sum((x - y) .^ 2));
                mIndex = j;
            end
            if j == k
                rgb(i, 4) = mIndex;
                if i > 1
                    groups(mIndex, 1) = (groups(mIndex, 1) + x(1))/2;
                    groups(mIndex, 2) = (groups(mIndex, 2) + x(2))/2;
                    groups(mIndex, 3) = (groups(mIndex, 3) + x(3))/2;
                end
            end
        end
    end
    %groups_tmp = centers
    centers = groups;
    groups = zeros(k,d);
end

end