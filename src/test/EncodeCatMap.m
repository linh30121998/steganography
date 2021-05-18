function stegoname = EncodeCatMap(randomBits, image, rp, kp1, kp2)
    len = size(randomBits,1);
    N = ceil(sqrt(len));
    [x,y] = Catmap(rp, kp1, kp2, N);
    addpath('../standard_map');
    bitPlane1 = SplitBitPlane(1, image);
    bitPlane2 = SplitBitPlane(2, image);
    for i = 1:len/2
        bitPlane1(x(i), y(i)) = randomBits(2*i-1);
        bitPlane2(x(i), y(i)) = randomBits(2*i);
    end
    addpath('../chaoticsmap');
    stegoImage = Add2BitPlane(image, bitPlane1, bitPlane2);
    stegoname = 'stegoCatMap.png';
    imwrite(stegoImage,stegoname);
end