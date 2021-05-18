function [bitPlane,outBits] = Decode(stegoname)
    rgbImage = imread(stegoname);
    redChannel = rgbImage(:,:,1);
    greenChannel = rgbImage(:,:,2);
    % Extract bit plane
    redBitPlane1 = SplitBitPlane(1, redChannel);
    redBitPlane2 = SplitBitPlane(2, redChannel);
    greenBitPlane1 = SplitBitPlane(1, greenChannel);
    greenBitPlane2 = SplitBitPlane(2, greenChannel);
    % Generate Chaotic Squence
    len = 2^20;
    [~,a] = ChaoticMap(len);
    % Extract Bit
    bitPlane = [redBitPlane1,redBitPlane2,greenBitPlane1,greenBitPlane2];
    outBits = zeros(len,1);
    for i = 1:len
        outBits(i) = bitPlane(a(i));
    end
end