function stegoname = EncodeLogisticMap(randomBits, image, x0, rp)
    [H,W] = size(image);
    [~,a] = LogisticMap(x0, H*W, rp);
    addpath('../chaoticsmap');
    bitPlane1 = SplitBitPlane(1, image);
    bitPlane2 = SplitBitPlane(2, image);
    len = size(randomBits);
    for i = 1:len/2
        bitPlane1(a(i)) = randomBits(2*i-1);
        bitPlane2(a(i)) = randomBits(2*i);
    end
    bitPlane1 = reshape(bitPlane1,[H,W]);
    bitPlane2 = reshape(bitPlane2,[H,W]);
    stegoImage = Add2BitPlane(image, bitPlane1, bitPlane2);
    stegoname = 'stegoLogisticMap.png';
    imwrite(stegoImage,stegoname);
end