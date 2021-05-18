clear;
% gen key, message
symbols = ['a':'z' 'A':'Z' '0':'9'];
key_length = 32;
mess_length = 60;
nums = randi(numel(symbols),[1 key_length]);
rand = symbols(nums);
hex = dec2hex(rand);
key = reshape(hex,1,[]);

nums = randi(numel(symbols),[1 mess_length]);
message = symbols(nums);
cipher = Encrypt(message, key);
% hiding image
addpath('d:/Linh_K61/Steganography/digitalImage');
path = 'IMG-0004-00002.jpg';
img = imread(path);
[H,W] = size(img);
max_step = 1;
cap = zeros(max_step, 1);   %capacity
m = zeros(max_step, 1);     %mse
psnrval = zeros(max_step, 1);
histval = zeros(max_step, 1);
ssimval = zeros(max_step, 1);
for step = 1:max_step
    [len, matrix_encode] = encode_LSB(path, cipher, step);
    % extract cipher 
    stego_img = 'stego_image.png';
    [decode_mess, matrix_input] = decode_LSB(stego_img, len, step);
    % decrypt
    message_check = Decrypt(key, decode_mess);
    if(strcmp(message_check, message) == 1)
      disp('true');
    end
    %Hiding capacity
    origin_img = 'origin.png';
    origin = imread(origin_img);
    stego = imread(stego_img);
    cap(step) = capacity(origin);
    disp(cap(step));
    %MSE 
    m(step) = 1/3 * mse(origin, stego);
    disp(m(step));
    % PSNR
    [row, col] = size(stego);

    original = double(origin);
    target = double(stego);
    tmp = 0;
    for i = 1:row
        for j = 1:col
            d1 = target(i,j);

            d2 = original(i,j);

            tmp = tmp+(d1-d2)^2;
        end
    end
    tmp = tmp/(row*col);
    psnrval(step) = 10*log10((255^2)/tmp);
    disp(psnrval(step));
    % Histogram
    origin_hist = cat(2, origin);
    stego_hist = cat(2, stego);
    diff = stego_hist - origin_hist;
    histval(step) = sum(sum(diff));
    % SSIM
    ssimval(step) = ssim(origin, stego);
    % payload (bpp) https://www.scirp.org/html/2-1680054_30619.htm
    ER = len*8/(H*W);
    % wPSNR: https://www.researchgate.net/publication/26511628_Human_Visual_System_Models_in_Digital_Image_Watermarking/download
    [val, wPSNRval] = psnrMetric(origin, stego, 4);
    disp(val);
    disp(wPSNRval);
    %test
    
end
