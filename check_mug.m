load('coeff')


colormap gray;
for i = 1:6
    subplot(6, 3, i);
   imagesc(reshape(coeff(:, i), 64, 64)); 
end


preTestImage = imresize(im2double(rgb2gray(imread('mug5.jpg'))), [96, 96]);

[M, N] = size(preTestImage);
mErr = 90000.0;
bestW = [];
for i = 1:16:M
    for j = 1:16:N
        if (i + 63 > M || j + 63 > N)
            continue;
        end
        w = preTestImage(i:i+63, j:j+63) - mean2(preTestImage(i:i+63, j:j+63));
        testIm = reshape(w, 1, 4096);

        res = (testIm) * (coeff);

        tt = (mean2(preTestImage(i:i+63, j:j+63))) + coeff * res';

        err = norm(testIm' - tt);
        
        subplot(6, 3, 11);
        imagesc(reshape(tt, 64, 64));
        
        subplot(6, 3, 10);
        imagesc(w);
        
        if (err < mErr)
            mErr = err;
            bestW = w;
            subplot(6, 3, 10);
            imagesc(w);
        end
        pause(2);
        
    end
end



colormap gray;

subplot(6, 3, 11);
imagesc(bestW);

subplot(6, 3, 12);
imagesc(preTestImage);