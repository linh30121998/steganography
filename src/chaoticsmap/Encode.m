function [tmp,stegoname] = Encode(randomBits, filename)
    addpath('../../digitalImage');
    rgbImage = imread(filename);
    % Extract color channels.
    redChannel = rgbImage(:,:,1);
    greenChannel = rgbImage(:,:,2);
    blueChannel = rgbImage(:,:,3);
    % Extract bit plane
    redBitPlane1 = SplitBitPlane(1, redChannel);
    redBitPlane2 = SplitBitPlane(2, redChannel);
    greenBitPlane1 = SplitBitPlane(1, greenChannel);
    greenBitPlane2 = SplitBitPlane(2, greenChannel);
    % Generate Chaotic Squence
    len = size(randomBits,1);
    [~,a] = ChaoticMap(len); % a: index embedding
    % Embedding processing
    bitPlane = [redBitPlane1,redBitPlane2,greenBitPlane1,greenBitPlane2];
    for i = 1:len
        bitPlane(a(i)) = randomBits(i);
    end
    tmp = bitPlane;
    bitPlane = reshape(bitPlane,[len/4,4]);
    redBitPlane1 = reshape(bitPlane(:,1),[512,512]);redBitPlane1 = redBitPlane1';
    redBitPlane2 = reshape(bitPlane(:,2),[512,512]);redBitPlane2 = redBitPlane2';
    greenBitPlane1 = reshape(bitPlane(:,3),[512,512]);greenBitPlane1 = greenBitPlane1';
    greenBitPlane2 = reshape(bitPlane(:,4),[512,512]);greenBitPlane2 = greenBitPlane2';

    % Add 2 bit Plane into previous channel respectively
    redChannel = Add2BitPlane(redChannel, redBitPlane1, redBitPlane2);
    greenChannel = Add2BitPlane(greenChannel, greenBitPlane1, greenBitPlane2);

    % create Stego Image
    stegoImage = cat(3, redChannel, greenChannel, blueChannel);
    addpath('./stegoimage');
    stegoname = 'stego.png';
    imwrite(stegoImage,stegoname);
end

