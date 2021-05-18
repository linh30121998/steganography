clear;
rp = 100;
kp1 = 1;
kp2 = 1;
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
x0 = rand(len,1); % init value from 0 to 1
N = ceil(sqrt(len));
[x,y] = Catmap(rp, kp1, kp2, N);
addpath('../chaoticsmap');
bitPlane1 = SplitBitPlane(1, image);
bitPlane2 = SplitBitPlane(2, image);
bitArray = zeros(1,len);
for i = 1:len/2
    bitArray(2*i-1) = bitPlane1(x(i), y(i));
    bitArray(2*i) = bitPlane2(x(i), y(i));
end
[~,a] = LogisticMap(x0, len, rp);
for i = 1:len
    bitArray(a(i)) = randomBits(i);
end
for i = 1:len/2
    bitPlane1(x(i), y(i)) = bitArray(2*i-1);
    bitPlane2(x(i), y(i)) = bitArray(2*i);
end
addpath('../chaoticsmap');
stegoImage = Add2BitPlane(image, bitPlane1, bitPlane2);
stegoname = 'stego.png';
imwrite(stegoImage,stegoname);

%Decode
stegoname = 'stego.png';
stegoImage = imread(stegoname);
[H,W] = size(stegoImage);
len = H*W/2;
[x,y] = Catmap(rp, kp1, kp2, N);
addpath('../standard_map');
bitPlane1o = SplitBitPlane(1, stegoImage);
bitPlane2o = SplitBitPlane(2, stegoImage);
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
if(sum(abs(outBits - double(randomBits))) == 0)
    disp('Decode true');
    addpath('../hidding_rgb_image');
    histogram(image);
    hold on;
    histogram(stegoImage);
    [capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(image, stegoImage, len);
else
    disp('Decode fail');
end
