function datachar = Int2Char(data)
    datachar = '';
    for i = 0:7
        tmp = data(1,8*i+1:8*(i+1));
        datachar(i+1) = char(bi2de(flip(tmp)));
    end
end