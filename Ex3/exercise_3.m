function exercise_3
    im = rgb2gray(imread("input_ex3.jpg"));
    imStretch = imadjust(im,stretchlim(im),[]);
    [imx, imy] = gaussgradient(imStretch, 0.5);
    magnitude = abs(imx)+abs(imy);
    edges = edge(magnitude,'Canny', 0.1);
    [H,R,T] = houghVoting(edges);
    
    peaks = 10;
    P = houghpeaks(H, peaks);
    imshow(H,[]);
    hold on;
    plot(P(:, 2), P(:, 1),'s','color','red')
end

function[H, Rho, Theta] = houghVoting(binMask)
    [n_row, n_col] = size(binMask);
    rho_max = floor(sqrt(n_row^2+n_col^2));
    
    H = (zeros(2*rho_max+1, 180));    
    Rho = [-rho_max, rho_max -1];
    Theta = [-90, 89];
    
    for row = 1:n_row
        for col = 1:n_col
            if binMask(row, col) == 1
                x = col - 1;
                y = row - 1;
                for theta = -90:89
                    rho = round(x * cosd(theta) + y * sind(theta));
                    H(rho + rho_max + 1, theta + 91) = H(rho + rho_max + 1, theta + 91) + 1;
                end
            end
        end
    end
end