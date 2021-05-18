clear;
addpath('../../digitalImage/size256256');
filename = 'IMG-0001-00001.jpg';
rgbImage = imread(filename);
image = rgb2gray(rgbImage);
[H,W] = size(image);
len = H*W/2;
randomBits = uint8(randi([0 1],len,1));
[~,a] = ChaoticMap(H*W); % a: index embedding
bitPlane1 = SplitBitPlane(1, image);
bitPlane2 = SplitBitPlane(2, image);
for i = 1:len/2
    bitPlane1(a(i)) = randomBits(2*i-1);
    bitPlane2(a(i)) = randomBits(2*i);
end
bitPlane1 = reshape(bitPlane1,[H,W]);bitPlane1 = bitPlane1';
bitPlane2 = reshape(bitPlane2,[H,W]);bitPlane2 = bitPlane2';
stegoImage = Add2BitPlane(image, bitPlane1, bitPlane2);
stegoname = 'stego.png';
imwrite(stegoImage,stegoname);
    addpath('../hidding_rgb_image');
    [capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(image, stegoImage, len);