function datas = encryptPresent(message,rootkey,rootkey64)
    [~,length] = size(message);
    key = convertASCII2bin(rootkey); % key length = 80 bits
    key64 = convertASCII2bin(rootkey64); % key length = 64 bits
    roundKeys = generateRoundKeys(key);
    % convert block 8 byte
    n = 8*ceil(length/8); % length padding
    if(n > length)
        pad = zeros(1,n-length) + '0';
        datachar1 = [message pad];
    else
        datachar1 = message;
    end
    datachar1 = reshape(datachar1,8,n/8)';
    datas = zeros(n/8, 64);
    param_player = 16;
    for i = 1:n/8
        datas(i,:) = convertASCII2bin(datachar1(i,:));
        for j = 1:31
            datas(i,:) = addRoundKey(datas(i,:),roundKeys(j,:));
            datas(i,:) = sBoxLayer(datas(i,:),64,0);
            datas(i,:) = pLayer(datas(i,:),param_player);
        end
        datas(i,:) = addRoundKey(datas(i,:), roundKeys(32,:));
        datachar1(i,:) = Int2Char(datas(i,:));
    end
    % ma hoa moc xich
    datas(1,:) = addRoundKey(datas(1,:), key64);
    for i = 2:n/8
        datas(i,:) = addRoundKey(datas(i-1,:),datas(i,:));
    end
end