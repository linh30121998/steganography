function S = subCells(S)
    SBOX = [12,5,6,11,9,0,10,13,3,14,15,8,4,7,1,2];
    for i = 1:5
        for j = 1:5
            S(i,j) = SBOX(S(i,j)+1);
        end
    end
end