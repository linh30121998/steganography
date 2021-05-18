clear;
addpath('../../digitalImage');
filename = 'IMG-0004-00005.jpg';
rgbImage = imread(filename);
% Generate message contain 2^20 bits
bitLength = 2^20;
randomBits = uint8(randi([0 1],bitLength,1));
stegoImage = Encode(rgbImage, randomBits, bitLength);
fileStegoName = 'IMG-0004-00005-stego.png';
imwrite(stegoImage,fileStegoName);

%%Decode
rgbStegoImage = imread(fileStegoName);
decodeBits = Decode(rgbStegoImage, bitLength);
if(size(decodeBits) ~= bitLength)
    disp('Decode length fail');
end
if(sum(abs(decodeBits - double(randomBits))) == 0)
    disp('Decode true');
else
    disp('Decode fail');
end
% tinh toan lai cai gia tri
addpath('../../digitalImage');
filename = 'IMG-0004-00005.jpg';
origin = imread(filename);
fileStegoName = 'IMG-0004-00005-stego.png'; 
stego = imread(fileStegoName);
bitLength = 2^20;
[capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(origin, stego, bitLength);