
function[cx,cy, d] = feature_match(trainImage,testImage)
load('coeff');


boxPoints = detectSURFFeatures(trainImage);
scenePoints = detectSURFFeatures(testImage);


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
    centroid = mean(newBoxPolygon);%center(newBoxPolygon);
    cx = centroid(1);
    cy = centroid(2);
    
    d = 2*abs(cx - min(newBoxPolygon(:, 1)));
figure;
imshow(testImage);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
plot(cx, cy, 'r*', 'LineWidth', 2, 'MarkerSize', 15);
title('Detected Box');
hold off;

end