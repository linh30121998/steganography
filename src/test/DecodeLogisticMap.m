function outBits = DecodeLogisticMap(stegoname, x0, rp)
    image = imread(stegoname);
    [H,W] = size(image);
    len = H*W/2;
    [~,a] = LogisticMap(x0, H*W, rp);
    addpath('../chaoticsmap');
    bitPlane1 = SplitBitPlane(1, image);
    bitPlane2 = SplitBitPlane(2, image);
    outBits = zeros(len,1);
    for i = 1:len/2
        outBits(2*i-1) = bitPlane1(a(i));
        outBits(2*i) = bitPlane2(a(i));
    end
end