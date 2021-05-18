function Ychar = GCTR(message, rootkey, rootkey64, ICB)
    [~,length] = size(message);
    n = ceil(length/16);
    CB = ICB;
    Y = zeros(n,128);
    for i = 1:n-1
        addpath('../../present');
        encryptCB = encryptPresent(CB,rootkey,rootkey64);
        [c,r] = size(encryptCB);
        encryptCB = reshape(encryptCB',c*r,1)';
        X = message(16*(i-1)+1:16*i);
        Xbin = convertASCII2bin(X);
        Y(i,:) = bitxor(Xbin,encryptCB);
        CB = inc32(CB);
    end
    encryptCB = encryptPresent(CB,rootkey,rootkey64);
    [c,r] = size(encryptCB);
    encryptCB = reshape(encryptCB',c*r,1)';
    [~,lenCB] = size(encryptCB);
    X = message(16*(n-1)+1:length);
    Xbin = convertASCII2bin(X);
    [~,lenXn] = size(Xbin);
    Y(n,1:lenXn) = bitxor(Xbin,encryptCB(lenCB-lenXn+1:lenCB));
    [c,r] = size(Y);
    Y = reshape(Y',c*r,1)';
    Y = Y(1:length*8);
    Ychar = '';
    for i = 0:length-1
        tmp = Y(1,8*i+1:8*(i+1));
        Ychar(i+1) = char(bi2de(flip(tmp)));
    end
    Ychar = matlab.net.base64encode(Ychar);
end
