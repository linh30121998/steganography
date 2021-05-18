clear;
addpath('../../digitalImage');
filename = 'IMG-0004-00005.jpg';
rgbImage = imread(filename);
image = rgb2gray(rgbImage);
[H,W] = size(image);
len = H*W/2;
randomBits = uint8(randi([0 1],len,1));
rp = 5;
kp1 = 1;
kp2 = 1;
addpath('../standard_map');
[x,y] = Catmap(rp, kp1, kp2);
addpath('../chaoticsmap');

bitPlane1 = SplitBitPlane(1, image);
bitPlane2 = SplitBitPlane(2, image);
% bitPlane3 = SplitBitPlane(3, image);
% bitPlane4 = SplitBitPlane(4, image);
% bitPlane = [bitPlane1,bitPlane2,bitPlane3,bitPlane4];
bitPlane = [bitPlane1,bitPlane2];
addpath('../chaoticsmap');
count = zeros(4,1);
% [~,a] = ChaoticMap(H*W*4); % a: index embedding
[~,a] = ChaoticMap(H*W*2); % a: index embedding
for i = 1:len
    bitPlane(a(i)) = randomBits(i);
    count(ceil(a(i)/(H*W))) = count(ceil(a(i)/(H*W))) + 1;
end
count = count./len;

stegoImage = AddBitPlane(image, bitPlane, 2);
% stegoImage = AddBitPlane(image, bitPlane, 4);
stegoname = 'stego.png';
imwrite(stegoImage,stegoname);

% Decode
stegoname = 'stego.png';
stego = imread(stegoname);
[H,W] = size(stegoImage);
len = H*W/2;
bitPlane1o = SplitBitPlane(1, stegoImage);
bitPlane2o = SplitBitPlane(2, stegoImage);
% bitPlane3 = SplitBitPlane(3, stegoImage);
% bitPlane4 = SplitBitPlane(4, stegoImage);
% bitPlaneo = [bitPlane1,bitPlane2,bitPlane3,bitPlane4];
bitPlaneo = [bitPlane1,bitPlane2];
[~,a] = ChaoticMap(H*W*2); % a: index embedding
% [~,a] = ChaoticMap(H*W*4); % a: index embedding
outBits = zeros(len,1);
for i = 1:len
    outBits(i) = bitPlane(a(i));
end
if(sum(abs(outBits - double(randomBits))) == 0)
    disp('Decode true');
    addpath('../hidding_rgb_image');
    [capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(image, stego, len);
else
    disp('Decode false');
end