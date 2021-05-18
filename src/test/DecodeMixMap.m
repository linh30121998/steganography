function outBits = DecodeMixMap(stegoname, rp, kp1, kp2, x0)
    stegoImage = imread(stegoname);
    [H,W] = size(stegoImage);
    len = H*W/2;
    N = ceil(sqrt(len));
    [x,y] = Catmap(rp, kp1, kp2, N);
    addpath('../standard_map');
    bitPlane1 = SplitBitPlane(1, stegoImage);
    bitPlane2 = SplitBitPlane(2, stegoImage);
    bitArray = zeros(1,len);
    for i = 1:len/2
        bitArray(2*i-1) = bitPlane1(x(i), y(i));
        bitArray(2*i) = bitPlane2(x(i), y(i));
    end
    [~,a] = LogisticMap(x0, len, rp);
    outBits = zeros(len,1);
    for i = 1:len
        outBits(i) = bitArray(a(i));
    end
end