function [sx, ax] = ChaoticMap(len)
    r = 3.95;
    x0 = 0.12; % init value from 0 to 1
    N = 5; % interations
    % number generation
    x = zeros(len,1,'double');
    x(1) = x0;
    for j = 2:len
        y = zeros(1,N,'double');
        y(1) = x(j-1);
        for i = 2:N
            y(i) = r*y(i-1)*(1-y(i-1));
        end
        x(j) = y(N);
    end
    [sx, ax] = sort(x);
end