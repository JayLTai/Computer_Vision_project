load('coeff');

trainImage = im2double(rgb2gray(imread('trainMug.jpg')));
%trainImage = reshape(coeff(:, 1), 64, 64);
testImage = imresize(im2double(rgb2gray(imread('mug2.jpg'))), [1024, 1024]);
boxPoints = detectSURFFeatures(trainImage);
scenePoints = detectSURFFeatures(testImage);

figure;
imshow(trainImage);
title('100 Strongest Feature Points from Box Image');
hold on;
plot(selectStrongest(boxPoints, 100));

figure;
imshow(testImage);
title('300 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(scenePoints, 300));


[boxFeatures, boxPoints] = extractFeatures(trainImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(testImage, scenePoints);

boxPairs = matchFeatures(boxFeatures, sceneFeatures);
matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(trainImage, testImage, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');

[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

boxPolygon = [1, 1;...                           % top-left
        size(trainImage, 2), 1;...                 % top-right
        size(trainImage, 2), size(trainImage, 1);... % bottom-right
        1, size(trainImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
    
    newBoxPolygon = transformPointsForward(tform, boxPolygon);
figure;
imshow(testImage);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Box');