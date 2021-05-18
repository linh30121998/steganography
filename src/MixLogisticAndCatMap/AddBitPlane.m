function stegoChannel = AddBitPlane(channel, bitPlane, num)
% add bitplane to image
    [H,W] = size(bitPlane);
    len = H*W;
    [H,W] = size(channel);
    bitPlane = reshape(bitPlane,[len/num,num]);
    plane = zeros(H,W,num);
    for i = 1:num
        plane(:,:,num) = reshape(bitPlane(:,i),[H,W]);
        plane(:,:,num) = plane(:,:,num)';
    end
    %convert to decimal
    decPlane = zeros(H,W);
    for i = 1:num
        decPlane = decPlane + plane(:,:,i).*2^(i-1);
    end
    stegoChannel = channel;
    for i = 1:H
        for j = 1:W
            stegoChannel(i,j) = bitand(channel(i,j),252)+ decPlane(i,j);
        end
    end
end