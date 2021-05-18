clear;
% addpath('../../digitalImage/size256256'); 
addpath('../../digitalImage');
filename = 'IMG-0004-00001.jpg';
rgbImage = imread(filename);
image = rgb2gray(rgbImage);
[H,W] = size(image);
len = H*W/2;
%Message
randomBits = uint8(randi([0 1],len,1));
%Encode
addpath('../hiding_rgb_image');
step = 1;
bitLength = size(randomBits,1);
tStart = tic;
tic
[stegoImage, count] = Add2BitsPerPixel(image, step, randomBits, bitLength);
stegoname = 'stegoLSB2Bit.png';
imwrite(stegoImage,stegoname);
T = toc;

%Decode
stego = imread(stegoname);
outBits = Decode2BitsPerPixel(stego, step, bitLength/2);
tEnd = toc(tStart);
%Calculate
if(sum(abs(outBits - double(randomBits))) == 0)
    % tinh toan lai cai gia tri
    disp('Decode LSB 2 bit true');
    origin = image;
    stego = imread(stegoname);
    addpath('../hidding_rgb_image');
    [cap(1), mse(1), psnr(1), wPSNR(1), hist(1), ssim(1), ER(1)] = CaculateValues(origin, stego, len);
else
    disp('Decode LSB 2 bit fail');
end