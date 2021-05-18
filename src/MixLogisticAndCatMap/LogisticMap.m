function x = LogisticMap(len)
    r = 3.95;
    x0 = rand(len,1); % init value from 0 to 1
    N = 5; % interations
    % number generation
    x = zeros(len,1,'double');
    for j = 1:N
        for i = 2:len
            x(i) = r*x0(i)*(1-x0(i));
        end
    end
    x = round(4*x);
end