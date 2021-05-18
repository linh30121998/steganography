function S = shiftRows(S)
    for i = 2:5
        S(i,:) = circshift(S(i,:),-(i-1));
    end
end