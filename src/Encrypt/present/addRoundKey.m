function data = addRoundKey(data, key)
    for i = 1:64
        data(i) = bitxor(data(i), key(i));
    end
end