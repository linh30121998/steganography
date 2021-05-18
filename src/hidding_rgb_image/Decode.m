function decodeBits = Decode(rgbStegoImage, bitLength)   
    redChannel = rgbStegoImage(:,:,1);
    greenChannel = rgbStegoImage(:,:,2);
    blueChannel = rgbStegoImage(:,:,3);
    [height, width] = size(redChannel);
    greenBits = [];
    blueBits = [];
    step = 1;
    if(bitLength/2 < height*width)
        lengthPixel = bitLength/2;
        redBits = Decode2BitsPerPixel(redChannel, step, lengthPixel);
    else 
        redBits = Decode2BitsPerPixel(redChannel, step, height*width);
        if(bitLength/2 - 2*height*width >= 0)
            greenBits = Decode2BitsPerPixel(greenChannel, step, height*width);
            if(bitLength/2 - 3*height*width >= 0)
                blueBits = Decode2BitsPerPixel(blueChannel, step, height*width);
            else
                blueBits = Decode2BitsPerPixel(blueChannel, step, bitLength/2 - 2*height*width);
            end
        else
            greenBits = Decode2BitsPerPixel(greenChannel, step, bitLength/2 - height*width);
        end
    end
    decodeBits = [redBits; greenBits; blueBits] ;
end