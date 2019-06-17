function F = makeFourierDescriptor(bm)
  % i. extract boundaries of binary mask
[B,L] = bwboundaries(bm);
% ii. number of elements for the descriptor
m = length(B);
figure; %imshow(L);
hold on
for k = 1:m
  boundary = B{k};
  plot(boundary(:,2),  boundary(:,1), 'r', 'LineWidth', 2);
endfor

Df = complex(boundary(:,2), boundary(:,1));
n = 24; 
Dr = Df(1:24);

F = fft(Dr);

for j = 1:length(F)
  % make translation invariant
  F(j) = F(j) - F(1);
  % make scale invariant
  F(j) = F(j) / abs(F(2));
  % make rotation invariant
  F(j) = abs(F(j));
endfor

endfunction
