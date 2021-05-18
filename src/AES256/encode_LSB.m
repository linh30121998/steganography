function [len, output] = encode_LSB(path, message, step) 
% input: matrix grey scale of image 'IMG-0002-00001.jpg'
% mess: 'identifier'
    input = imread(path);
    input = rgb2gray(input);
    imwrite(input, 'origin.png');
    symbol_length = 4;          % init the number of bit in a symbol
    bit_length = 8;             % the number of bit in a char
    len = length(message);    % Length of the message where each character is 8 bits
    ascii_value = uint8(message);
    array = zeros(1,ceil(len*bit_length/symbol_length)); %split 4 bit 
    for i = 1:len
        array(2*i-1) = bitshift(ascii_value(i), -symbol_length); % 4 bit dau
        array(2*i) = double(bitand(ascii_value(i),15));          % 4 bit cuoi
    end
    %stego-image
    output = input;             % Initialize output as input 
    height = size(input, 1); 
    width = size(input, 2); 
    embed_counter = 1;          % Counter for number of embedded bits 

    for i = 1:height
        for j = 1:step:width
            if(embed_counter <= length(array))
                output(i,j) = bitand(input(i,j),240)+array(embed_counter);
                embed_counter = embed_counter + 1;
            end
        end
    end
    imwrite(output,'stego_image.png');
end
