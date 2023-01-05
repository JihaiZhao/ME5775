function imageDisplayFromVector(M,Wpixel,Hpixel)

M = reshape(M,Wpixel,Hpixel)'; % make it a square matrix of pixels and
M = uint8(M);
imshow(M)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]); % this makes sure that the figure size is big enough

end