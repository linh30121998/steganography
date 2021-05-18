function outBits = DecodeCatMap(stegoname, rp, kp1, kp2)
    stegoImage = imread(stegoname);
    [H,W] = size(stegoImage);
    len = H*W/2;
    N = ceil(sqrt(len));
    [x,y] = Catmap(rp, kp1, kp2, N);
    addpath('../standard_map');
    bitPlane1 = SplitBitPlane(1, stegoImage);
    bitPlane2 = SplitBitPlane(2, stegoImage);
    outBits = zeros(len,1);
    for i = 1:len/2
        outBits(2*i-1) = bitPlane1(x(i), y(i));
        outBits(2*i) = bitPlane2(x(i), y(i));
    end
end