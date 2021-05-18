function [capVal, mseVal, psnrVal, wPSNRval, histVal, ssimVal, ER] = CaculateValues(origin, stego, bitLength)
    addpath('../AES256');
    %Hiding capacity
    capVal = capacity(origin);
    %MSE 
    mseVal = immse(origin, stego);
    %PSNR & wPSNR
    [psnrVal, wPSNRval] = psnrMetric(origin, stego, 4);
    % Histogram
    originHist = cat(2, origin);
    stegoHist = cat(2, stego);
    diff = abs(stegoHist - originHist);
    histVal = sum(sum(diff));
    % SSIM
    ssimVal = ssim(origin, stego);
    % Payload
    [H, W] = size(origin);
    ER = (bitLength/8*2)/(H*W);
end