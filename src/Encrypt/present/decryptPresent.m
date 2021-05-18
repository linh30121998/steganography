function data_out = decryptPresent(datas, rootkey, rootkey64, length)
    key = convertASCII2bin(rootkey); % key length = 80 bits
    key64 = convertASCII2bin(rootkey64); % key length = 64 bits
    % encode present
    roundKeys = generateRoundKeys(key);
    % convert block 8 byte
    n = 8*ceil(length/8); % length padding
    % giai ma moc xich
    for i = n/8:-1:2
        datas(i,:) = addRoundKey(datas(i,:), datas(i-1,:));
    end
    datas(1,:) = addRoundKey(datas(1,:), key64);
%     for i = 1:n/8
%         datachar1(i,:) = Int2Char(datas(i,:));
%     end
    % giai ma
    param_playerinv = 4;
    data_out = '';
    for i = 1:n/8
        datas(i,:) = addRoundKey(datas(i,:), roundKeys(32,:));
        for j = 31:-1:1
            datas(i,:) = pLayer(datas(i,:),param_playerinv);
            datas(i,:) = sBoxLayer(datas(i,:),64,1);
            datas(i,:) = addRoundKey(datas(i,:),roundKeys(j,:));
        end
        data_out(i,:) = Int2Char(datas(i,:));
    end
    data_out = reshape(data_out',1,n);
    data_out = data_out(1,1:length);
end 