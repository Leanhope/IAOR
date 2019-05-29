% Group R
% Pia Fichtl (114545), Hans Lienhop (114926), Fulya Tasliarmut (111448)
% ===============================

function exercise_3
    % Task a
    im = im2double(rgb2gray(imread('input_ex3.jpg')));

    % Task b
    imStretch = imadjust(im, stretchlim(im),[]);
    [imx, imy] = gaussgradient(imStretch, 0.5);
    magnitude = abs(imx)+abs(imy);
    
    % Task c
    features = magnitude > 0.2; % where gradient is over 20 percent
    figure; imshow(features);
    
    % Task d
    [H,R,T] = houghvoting(features,imx,imy);
    
    % Task e and f
    % find local maxima with MATLAB function houghpeaks
    peaks = 20;
    %P = houghpeaks(H, peaks, 'threshold', ceil(0.3 * max(H(:))));
    P = houghpeaks(H, peaks, 'threshold', 0.1);
    imshow(H,[0, 10],'XData',T,'YData',R,'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    plot(T(P(:,2)),R(P(:,1)),'s','color','red');
    hold off;
    
    % Task h and i
    % utilize hough lines and visualiz them
    lines = houghlines(features,T,R,P,'FillGap', 5,'MinLength',25);
    figure;
    imshow(im), hold on
    max_len = 0;
    
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');

    end
    
end

