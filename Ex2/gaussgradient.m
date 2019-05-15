function [Gx,Gy] = gaussgradient(img, sigma)
    radius = 3 * sigma; % filter kernel radius
    size = 5;
    Gx = zeros(5,5);

    for i=1:size
        for j=1:size
            u=[i-radius-1 j-radius-1];
            Gx(i,j)= (exp(-u(1)^2/(2*sigma^2)) / (sigma*sqrt(2*pi))) * ...
            (-u(2) * exp(-u(2)^2/(2*sigma^2)) / (sigma*sqrt(2*pi)) / sigma^2);
        end
    end

    Gy=Gx';

    Gx=imfilter(img,Gx,'conv');
    Gy=imfilter(img,Gy,'conv');
end