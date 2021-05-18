function stegoname = EncodeMixMap(randomBits, image, rp, kp1, kp2, x0)
    len = size(randomBits,1);
    N = ceil(sqrt(len));
    [x,y] = Catmap(rp, kp1, kp2, N);
    addpath('../chaoticsmap');
    bitPlane1 = SplitBitPlane(1, image);
    bitPlane2 = SplitBitPlane(2, image);
    bitArray = zeros(1,len);
    for i = 1:len/2
        bitArray(2*i-1) = bitPlane1(x(i), y(i));
        bitArray(2*i) = bitPlane2(x(i), y(i));
    end
    [~,a] = LogisticMap(x0, len, rp);
    for i = 1:len
        bitArray(a(i)) = randomBits(i);
    end
    for i = 1:len/2
        bitPlane1(x(i), y(i)) = bitArray(2*i-1);
        bitPlane2(x(i), y(i)) = bitArray(2*i);
    end
    addpath('../chaoticsmap');
    stegoImage = Add2BitPlane(image, bitPlane1, bitPlane2);
    stegoname = 'stegoMixMap.png';
    imwrite(stegoImage,stegoname);
end