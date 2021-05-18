function dataout = convertIntToBit(datain, index_x, index_y)
    dataout = dec2bin(datain(index_x,index_y),4)-'0';
end