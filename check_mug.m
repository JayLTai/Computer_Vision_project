load('coeff')


colormap gray;
for i = 1:9
    subplot(6, 3, i);
   imagesc(reshape(coeff(:, i), 64, 64)); 
end


preTestImage = im2double(rgb2gray(imread('mug2.jpg')));

[M, N] = size(preTestImage);
mErr = 90;
bestW = [];
for i = 1:16:M
    for j = 1:16:N
        if (i + 63 > M || j + 63 > N)
            break;
        end
        w = preTestImage(i:i+63, j:j+63);
        wMean = w - mean(mean(w));
        testIm = reshape(wMean, 1, 4096);

        res = (testIm) * (coeff);

        tt = mean(mean(w)) + coeff * res';

        err = norm(testIm - tt);
        
        if (err < mErr)
            mErr = err;
            bestW = w;
            %subplot(6, 3, 10);
            %imagesc(w);
        end
        
    end
end



colormap gray;

subplot(6, 3, 11);
imagesc(w);