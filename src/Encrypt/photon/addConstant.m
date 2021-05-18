function S = addConstant(S, RC, round, ICd)
        S(1:5,1) = bitxor(S(1:5,1),RC(round));
        S(1:5,1) = bitxor(S(1:5,1),ICd(:));
%         S(:,1) = bitxor(S(:,1),RC(round));
%         S(:,1) = bitxor(S(:,1),ICd(:));
end 