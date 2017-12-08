function [images] = read_images()

images = {};

fid = fopen('imagenet.synset.txt');
imgs = textscan(fid, '%s');

urls  = imgs{1};

for i = 1:size(urls, 1)
    
    try
    im = imread(urls{i});
    images = {images, im};
    fname = strcat('images/f', num2str(i), '.jpg');
    imwrite(im, fname);
    
    catch
        disp("Couldn't read file");
        
    end
end

end