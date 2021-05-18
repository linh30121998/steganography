function c = nhanPhanTu(c,a,S,i,j,r)
    c1 = convertIntToBit(c,i,j);
    a1 = convertIntToBit(a,i,r);
    S1 = convertIntToBit(S,r,j);
    c1 = nhan(a1,S1,c1);
    c(i,j) = convertBitToInt(c1);
end