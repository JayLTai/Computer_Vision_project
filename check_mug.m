load('coeff')


colormap gray;
for i = 1:9
    subplot(6, 3, i);
   imagesc(reshape(coeff(:, i), 64, 64)); 
end

tIm = im2double(imresize(rgb2gray(imread('mug2.jpg')), [64 64]));

testIm = reshape(tIm, 1, 4096);

res = (testIm - mean(testIm)) * coeff;

tt = mean(testIm) + res * coeff';

err = norm(testIm - tt);
colormap gray;

subplot(6, 3, 10);
imagesc(tIm);
subplot(6, 3, 11);
imagesc(reshape(tt, 64, 64));