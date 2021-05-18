function hashS = permutation(S)
    RC = [1,3,7,14,13,11,6,12,9,2,5,10];
    ICd = [0,1,3,6,4];
    for k = 1:12
        S = addConstant(S, RC, k, ICd);
        S = subCells(S);
        S = shiftRows(S);
        S = mixColumnsSerial(S);
    end
    hashS = S(1:5, 1:5);
end