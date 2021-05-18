function dataout = convertASCII2bin(datain)
    % key la chuoi ky tu dai 10 ky tu voi key thuong va 8 ky tu voi key64
    bit_length = 8;
    ascii_value = uint8(datain);
    dataout = dec2bin(ascii_value,bit_length)-'0';
    dataout = reshape(dataout.',1,[]);
end