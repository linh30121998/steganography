function [OutputChannel, count] = Add2BitsPerPixel(Channel, step, randomBits, bitLength)
% adding 2 bits LSB/pixel
    [height, width] = size(Channel);
    count = 0;
    OutputChannel = Channel;
    for i = 1:height
        for j = 1:step:width
            if(2*count < bitLength)
                count = count + 1;
                bitsAdd = bitshift(randomBits(2*count-1),1) + randomBits(2*count);
                OutputChannel(i,j) = bitand(Channel(i,j),252)+ bitsAdd;
            else
                break;
            end
            
        end
    end
end
