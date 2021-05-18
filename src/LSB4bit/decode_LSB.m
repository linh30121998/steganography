function message = decode_LSB(matrix_decode, len_mess, step)
%path_decode: image link needs decoding
%len_mess: length of mess in binary
    
    message = '';
    input = matrix_decode;
    height = size(input,1);
    width = size(input,2);
    bit_length = 8;
    symbol_length = 4;
    array = zeros(1,ceil(len_mess*bit_length/symbol_length));
    k = 1;
    for i = 1:height
        for j = 1:step:width
            if(k <= length(array))
                array(k) = bitand(input(i,j),15);
                k = k + 1;
            end
        end
    end
    ascii_value = zeros(1,len_mess);
    for i = 1:len_mess
        ascii_value(i) = uint8(array(2*i)+bitshift(array(2*i-1),symbol_length));
        message = char(ascii_value);
    end
end