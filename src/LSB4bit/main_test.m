clear;
% addpath('../../digitalImage/size256256');
% path = 'IMG-0001-00001.jpg';
% rgbImage = imread(path);
% image = rgb2gray(rgbImage);
% [H,W] = size(image);
% len_bits = H*W/2;
% len = len_bits/8;
% symbols = ['a':'z' 'A':'Z' '0':'9'];
% nums = randi(numel(symbols),[1 len]);
% message = symbols(nums);
message = 'identifier:linh';
capVal = zeros(2^9,1); mseVal = zeros(2^9,1); psnrVal = zeros(2^9,1);
wPSNRval = zeros(2^9,1); histVal = zeros(2^9,1); ssimVal = zeros(2^9,1);
for k = 1:1
    addpath('../../digitalImage/size256256');
    str = int2str(5);
    path = strcat('IMG-0001-0000',str,'.jpg');
    rgbImage = imread(path);
    image = rgb2gray(rgbImage);
    for i = 1:2^9
        step = i;
        [len, result] = encode_LSB(image, message, step);
        imwrite(result,'stego.png');
        message_check = decode_LSB(result, len, step);
        if(strcmp(message_check, message) == 1)
%             disp('true');
            stego = imread('stego.png');
            origin = image;
%             subplot(1,2,1);
%             imhist(origin);
%             title('Originated Image');
%             subplot(1,2,2);
%             imhist(stego);
%             title('Stego Image');
            addpath('../hidding_rgb_image');
            len_bits = len*8;
            [capVal(i), mseVal(i), psnrVal(i), wPSNRval(i), histVal(i), ssimVal(i), ER] = CaculateValues(origin, stego, len_bits);
        else 
            disp('fail');
        end
    end
end
% step = 1:2^9;
% title(path);
% title('Grey Image 256x256, Length Message: 120 bits');
% figure;
% plot(capVal,step);title('Capacity');
% figure;
% plot(mseVal,step);title('MSE Value');
% figure;
% plot(psnrVal,step);title('PSNR Value');
% figure;
% plot(wPSNRval,step);title('wPSNR Value');
% figure;
% plot(histVal,step);title('Histogram Difference');
% figure;
% plot(ssimVal,step);title('SSIM Value');

