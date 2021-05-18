function decodeBits = Decode2BitsPerPixel(channel, step, length)
% length: so pixel chen du lieu
    decodeBits = zeros(length*2,1);
    count = 1;
    [height, width] = size(channel);
    for i = 1:height
        for j = 1:step:width
            if(count <= length)
                decodeBits(2*count-1) = bitshift(bitand(channel(i,j),2),-1);
                decodeBits(2*count) = bitand(channel(i,j),1);
                count = count + 1;
            end
        end
    end
end