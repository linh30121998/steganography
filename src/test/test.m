clear;
addpath('../../digitalImage/size256256'); % addpath('../../digitalImage');
filename = 'IMG-0001-00001.jpg';
rgbImage = imread(filename);
image = rgb2gray(rgbImage);
[H,W] = size(image);
len = H*W/2;
%Initial value for logistic map
% rp = 100;
x0 = rand(H*W,1); % init value from 0 to 1
%Initial values for cat map
kp1 = 1;
kp2 = 1;
%Message
randomBits = uint8(randi([0 1],len,1));
cap = zeros(1,3); mse = zeros(1,3); psnr = zeros(1,3); hist = zeros(1,3); wPSNR = zeros(1,3); ssim = zeros(1,3); ER = zeros(1,3);
%Encode & Decode
T = zeros(20,3);
tEnd = zeros(20,3);
for rp = 1000:500:10000
    i = 1 + (rp - 1000)/500;
    tStart1 = tic;
    tic
    stegoname = EncodeLogisticMap(randomBits, image, x0, rp);
    T(i,1) = toc;
    outBits1 = DecodeLogisticMap(stegoname, x0, rp);
    tEnd(i,1) = toc(tStart1);
    %Calculate
    if(sum(abs(outBits1 - double(randomBits))) == 0)
        % tinh toan lai cai gia tri
%         disp('Decode Logistic Map true');
        origin = image;
        stego = imread(stegoname);
        addpath('../hidding_rgb_image');
        [cap(1), mse(1), psnr(1), wPSNR(1), hist(1), ssim(1), ER(1)] = CaculateValues(origin, stego, len);
    else
        disp('Decode Logistic Map fail');
    end

    tStart2 = tic;
    tic
    stegoname = EncodeCatMap(randomBits, image, rp, kp1, kp2);
    T(i,2) = toc;
    outBits2 = DecodeCatMap(stegoname, rp, kp1, kp2);
    tEnd(i,2) = toc(tStart2);

    %Calculate
    if(sum(abs(outBits2 - double(randomBits))) == 0)
        % tinh toan lai cai gia tri
%         disp('Decode Cat Map true');
        origin = image;
        stego = imread(stegoname);
        addpath('../hidding_rgb_image');
        [cap(2), mse(2), psnr(2), wPSNR(2), hist(2), ssim(2), ER(2)] = CaculateValues(origin, stego, len);
    else
        disp('Decode Cat Map fail');
    end

    tStart3 = tic;
    tic
    stegoname = EncodeMixMap(randomBits, image, rp, kp1, kp2, x0);
    T(i,3) = toc;
    outBits3 = DecodeMixMap(stegoname, rp, kp1, kp2, x0);
    tEnd(i,3) = toc(tStart3);
    %Calculate
    if(sum(abs(outBits3 - double(randomBits))) == 0)
        % tinh toan lai cai gia tri
%         disp('Decode Mix Map true');
        origin = image;
        stego = imread(stegoname);
        addpath('../hidding_rgb_image');
        [cap(3), mse(3), psnr(3), wPSNR(3), hist(3), ssim(3), ER(3)] = CaculateValues(origin, stego, len);
    else
        disp('Decode Mix Map fail');
    end
end