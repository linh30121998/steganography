function w = KeyExpansion(key)
    key = hex2dec(reshape(key,2,[])');
    w = reshape(key,4,[]);
    for i = 8:59
        temp = w(:,i);
        if mod(i,8) == 0
            temp = SubBytes(circshift(temp,-1));
            temp = bitxor(temp,[2^(i/8-1),0,0,0]');
        elseif mod(i,8) == 4
            temp = SubBytes(temp);
        end
        w(:,i+1) = bitxor(w(:,i-7),temp);
    end
end