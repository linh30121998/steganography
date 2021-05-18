function stegoImage = Encode(rgbImage, randomBits, bitLength)
    % Extract color channels.
    redChannel = rgbImage(:,:,1); % Red channel
    greenChannel = rgbImage(:,:,2); % Green channel
    blueChannel = rgbImage(:,:,3); % Blue channel
    [height, width] = size(redChannel);
    %Encode: Hide 2 bits/pixel 
    step = 1;
    [redChannel, countRed] = Add2BitsPerPixel(redChannel, step, randomBits, bitLength);
    if(countRed == height*width)
        bitGreenLength = bitLength - 2*countRed;
        if(bitGreenLength > 0)
            greenBits = randomBits(2*countRed+1:bitLength);
            [greenChannel, countGreen] = Add2BitsPerPixel(greenChannel, step, greenBits, bitGreenLength);
            if(countGreen == height*width)
                bitBlueLength = bitGreenLength - 2*countGreen;
                if(bitBlueLength > 0)
                    blueBits = greenBits(2*countGreen+1:bitBlueLength);
                    [blueChannel, ~] = Add2BitsPerPixel(blueChannel, step, blueBits, bitBlueLength);
                end
            end
        end
    end
    stegoImage = cat(3, redChannel, greenChannel, blueChannel);
end