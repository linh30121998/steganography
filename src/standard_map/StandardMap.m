% Standard Map
function [x, y] = StandardMap(N, len) % N: h or w size of square image
    K = 0.2;            % parameter - positive integer
    rp = 5;             % iteration
    x0 = 0.1;
    y0 = 0.0;
    x = zeros(1, len);
    y = zeros(1, len);
    x(1) = x0; y(1) = y0;
    for i = 2:len
        x_tmp = zeros(1, rp);
        y_tmp = zeros(1, rp);
        x_tmp(1) = x(i - 1);
        y_tmp(1) = y(i - 1);
        for j = 2:rp
            x_tmp(j) = mod((x_tmp(j-1)+y_tmp(j-1)),N);
            y_tmp(j) = mod((y_tmp(j-1)+K*sin(x_tmp(j)*2*pi/N)),N);
        end
        x(i) = x_tmp(rp);
        y(i) = y_tmp(rp);
    end
    x = floor(x);
    y = floor(y);
end
