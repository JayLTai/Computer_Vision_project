load('coeff')


colormap gray;
for i = 1:9
    subplot(3, 6, i);
   imagesc(reshape(coeff(:, i), 64, 64)); 
end


testIm = reshape(im2double(imresize(rgb2gray(imread('mug.jpg')), [64 64])), 1, 4096);

res = testIm * coeff;


colormap gray;
for i = 1:9
    subplot(3, 6, 6 + i);
   imagesc(reshape(re(:, i), 64, 64)); 
end