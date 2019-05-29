function[H, Rhos, Thetas] = houghvoting(binMask,imx,imy)
    [n_row, n_col] = size(binMask);
    rho_max = floor(sqrt(n_row^2 + n_col^2));
    Rhos = [-rho_max:rho_max];
    Thetas = [-90:89];
    % initialize voting array
    H = double(zeros(2 * rho_max, 180));    
    
    % loop over features
    for row = 1:n_row
        for col = 1:n_col
            if binMask(row, col) > 0
                 Theta = atan(imy(row, col) / imx(row, col));
                 Rho = col * cos(Theta) + row * sin(Theta);
                 
                 H_x = find(Rhos == round(Rho));
                 H_y = find(Thetas == round(rad2deg(Theta)));
                 H(H_x, H_y) = H(H_x, H_y) + 1;
            end
        end
    end
end