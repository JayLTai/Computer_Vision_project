function[abdist] = distance(centroidx,centroidy,x,y)
%size of image x, y
abx = (x)/2;
aby = (y)/2;

dist(1) = (abx-centroidx);
dist(2) = (aby-centroidy);

abdist = norm(dist);


end