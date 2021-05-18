function [x1, y1] = stdmaploop(rp,kp)
    N = 256;
    j = 0:N-1;
    x = repmat(j',[1 N]);
    y = repmat(j,[N 1]);
    x1 = zeros(N,N);
    y1 = zeros(N,N);
    %key = unidrnd(kp,1,rp);
    key = zeros(1,rp);
    dk = 0;
    for i = 1:rp
        key(i) = kp + dk;
        dk = dk + 1;
    end
    for loop = 1: rp
        for i = 1:N
            for k = 1:N
                x1(i,k) = mod(x(i,k) + y(i,k) + 3,N);
                y1(i,k) = mod(y(i,k) + 2 + floor(key(loop)*sin(x1(i,k)*N/(2*pi))), N);
            end
        end
        x = x1;
        y = y1;
    end
end