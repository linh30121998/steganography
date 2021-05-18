function S = mixColumnsSerial(S)
    a = [1,2,9,9,2;
        2,5,3,8,13;
        13,11,10,12,1;
        1,15,2,3,14;
        14,14,8,5,12];
    c = zeros(5,5);
    for i = 1:5
        for j = 1:5
            for r = 1:5
                c = nhanPhanTu(c,a,S,i,j,r);
            end
        end
    end
    
    for i = 1:5
        for j = 1:5
            S(i,j) = c(i,j);
        end
    end
end