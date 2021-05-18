function stegoChannel = Add2BitPlane(channel, plane1, plane2);
% Channel: R,G,B
% plane11: LSB
% plane2: 2nd bits
    [H, W] = size(channel);
    stegoChannel = channel;
    for i = 1:H
        for j = 1:W
            bitsAdd = bitshift(plane2(i,j),1) + plane1(i,j);
            stegoChannel(i,j) = bitand(channel(i,j),252)+ bitsAdd;
        end
    end
end