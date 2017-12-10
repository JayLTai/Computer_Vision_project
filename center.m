function [x, y] = center(poly)

    x = 0;
    y = 0;
    
    for i = 1:size(poly, 1)
       x = x + poly(i, 1);
       y = x + poly(i, 2);
    end

    x = x/size(poly, 1);
    y = y/size(poly, 1);
end