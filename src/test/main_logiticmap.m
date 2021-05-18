clear;
rp = 100;
% Encode
addpath('../../digitalImage/size256256');
% addpath('../../digitalImage');
filename = 'IMG-0001-00001.jpg';
rgbImage = imread(filename);
image = rgb2gray(rgbImage);
origin = image;
[H,W] = size(image);
len = H*W/2;
randomBits = uint8(randi([0 1],len,1));
x0 = rand(H*W,1); % init value from 0 to 1
[~,a] = LogisticMap(x0, H*W, rp);
addpath('../chaoticsmap');
bitPlane1 = SplitBitPlane(1, image);
bitPlane2 = SplitBitPlane(2, image);
for i = 1:len/2
    bitPlane1(a(i)) = randomBits(2*i-1);
    bitPlane2(a(i)) = randomBits(2*i);
end
bitPlane1o = reshape(bitPlane1,[H,W]);
bitPlane2o = reshape(bitPlane2,[H,W]);
stegoImage = Add2BitPlane(image, bitPlane1, bitPlane2);
stegoname = 'stego.png';
imwrite(stegoImage,stegoname);

% Decode
image = imread(stegoname);
stego = image;
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
if(sum(abs(outBits - double(randomBits))) == 0)
    % tinh toan lai cai gia tri
    disp('Decode true');
    addpath('../hidding_rgb_image');
    imhist(origin);
    hold on;
    imhist(stego);
    legend('cover image', 'stego-image');
    [capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(origin, stego, len);
else
    disp('Decode fail');
end