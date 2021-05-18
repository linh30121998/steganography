clear;
filename = 'IMG-0004-00005.jpg';
% Generate message contain 2^20 bits
len = 2^20;
randomBits = uint8(randi([0 1],len,1));
[tmp,stegoname] = Encode(randomBits, filename);
[bitPlane,outBits] = Decode(stegoname);
if(sum(abs(outBits - double(randomBits))) == 0)
    disp('Decode true');
    % tinh toan lai cai gia tri
    addpath('../../digitalImage');
    filename = 'IMG-0004-00005.jpg';
    origin = imread(filename);
    stegoname = 'stego.png';
    stego = imread(stegoname);
    addpath('../hidding_rgb_image');
    [capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(origin, stego, len);
else
    disp('Decode fail');
end
