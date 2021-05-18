clear;
addpath('../../digitalImage');
filename = 'IMG-0004-00001.jpg';
rgbImage = imread(filename);
image = rgb2gray(rgbImage);
[H,W] = size(image);
len = H*W/2;
randomBits = uint8(randi([0 1],len,1));
rp = 10000;
kp1 = 1;
kp2 = 1;
[x,y] = Catmap(rp, kp1, kp2);
bitPlane1 = SplitBitPlane(1, image);
bitPlane2 = SplitBitPlane(2, image);
count = zeros(H,W);
for i = 1:len/2
    bitPlane1(x(i), y(i)) = randomBits(2*i-1);
    bitPlane2(x(i), y(i)) = randomBits(2*i);
    count(x(i), y(i)) = count(x(i), y(i)) + 1;
end
addpath('../chaoticsmap');
stegoImage = Add2BitPlane(image, bitPlane1, bitPlane2);
stegoname = 'stego.png';
imwrite(stegoImage,stegoname);
%%Decode
stegoname = 'stego.png';
stegoImage = imread(stegoname);
[H,W] = size(stegoImage);
len = H*W/2;
bitPlane1o = SplitBitPlane(1, stegoImage);
bitPlane2o = SplitBitPlane(2, stegoImage);
outBits = zeros(len,1);
for i = 1:len/2
    outBits(2*i-1) = bitPlane1(x(i), y(i));
    outBits(2*i) = bitPlane2(x(i), y(i));
end
if(sum(abs(outBits - double(randomBits))) == 0)
    disp('Decode true');
    addpath('../hidding_rgb_image');
    [capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(image, stegoImage, len);
else
    disp('Decode fail');
end
