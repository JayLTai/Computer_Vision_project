function [img] = webcam_snapshot()
%make sure you have the webcam support package installed
imnum = 0;
nametemplate = 'image_%04d.tif';  %name pattern
   cam = webcam(1)
   img = snapshot(cam);
   clear('cam');
   imnum = imnum + 1;
   thisfile = sprintf(nametemplate, imnum);  %create filename
   imwrite( img, fullfile(cd, thisfile));  %write the image there as tif