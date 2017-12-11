trainImage = im2double(rgb2gray(imread('train2.jpg')));

% 
%trainImage = reshape(coeff(:, 1), 64, 64);
testImage = (im2double(rgb2gray(imread('mugClose.tif'))));

testImage2 = (im2double(rgb2gray(imread('mugClose2.tif'))));

[cx1,cy1, p1]=feature_match(trainImage,testImage);
[cx2,cy2, p2]=feature_match(trainImage,testImage2);
% 
% [x,y] = size(testImage);
% [x2,y2] = size(testImage2);
% 
% dist1 = l2distance(cx1,cy1,x,y);
% dist2 = l2distance(cx2,cy2,x2,y2);


w_mug = 88.9;
F = 735;%3.67;

actD1 = w_mug * F / p1;
actD2 = w_mug * F / p2;
