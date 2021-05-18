function [x1, y1] = Catmap(rp, kp1, kp2)
    N = 512;
    j = 0:N-1;
    x = repmat(j',[1 N]);
    y = repmat(j ,[N 1]);
    x1 = zeros(N,N);
    y1 = zeros(N,N);
    for loop = 1: rp
        for i = 1:N
            for k = 1:N
                x1(i,k) = mod((2*x(i,k)) + y(i,k),N) + 1;
                y1(i,k) = mod(x(i,k) + y(i,k), N) + 1;
            end
        end
        x = x1;
        y = y1;
    end
end