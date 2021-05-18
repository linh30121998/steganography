% sBoxLayer
function sBoxLayer(data, n)
    SBOX = [12,5,6,11,9,0,10,13,3,14,15,8,4,7,1,2];
    for i = 1:(n/4)
        sum = bi2de(flip(data));
        sum = SBOX(sum+1);
        data = dec2bin(sum);
    end
end