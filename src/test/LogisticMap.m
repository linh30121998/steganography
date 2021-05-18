function [sx, ax] = LogisticMap(x0, len, rp)
    r = 3.95;
    x = zeros(len,1,'double');
    for j = 1:rp
        for i = 1:len
            x(i) = r*x0(i)*(1-x0(i));
        end
    end
    [sx, ax] = sort(x);
end