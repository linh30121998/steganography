% sBoxLayer
function data = sBoxLayer(data, n, mode)
    SBOX = [12,5,6,11,9,0,10,13,3,14,15,8,4,7,1,2]; % mode = 0
    SBOX_inv = [5,14,15,8,12,1,2,13,11,4,6,3,0,7,9,10]; % mode = 1
    if (mode == 1)
        sbox = SBOX_inv;
    else
        sbox = SBOX;
    end
    for i = 1:(n/4)
        tmp = data(1,4*i-3:4*i);
        sum = bi2de(flip(tmp));
        sum = sbox(sum+1);
        tmp = dec2bin(sum,4) - '0';
        data(1,4*i-3:4*i) = tmp;
    end
end