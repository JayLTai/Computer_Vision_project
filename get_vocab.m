imds = imageDatastore('images');

x = imds.read();


ims = [];

for i = 1:1198
    try
    x = im2double(rgb2gray(readimage(imds, i)));
    x = imresize(x, [64 64]);
    x = x - mean2(x);
    x = reshape(imresize(x, [64 64]), 1, 4096);
    ims = [ims; x];
    catch
        
    end
    %imshow(x);
end

coeff = pca(ims, 'NumComponents', 3);

save('coeff.mat', 'coeff')

%{
bag = bagOfFeatures(imds, 'VocabularySize', 100, 'StrongestFeatures', 0.1);

img = readimage(imds, 1);
featureVector = encode(bag, img);

save('bag.mat', 'bag')

% Plot the histogram of visual word occurrences
figure
bar(featureVector)
title('Visual word occurrences')
xlabel('Visual word index')
ylabel('Frequency of occurrence')
%}