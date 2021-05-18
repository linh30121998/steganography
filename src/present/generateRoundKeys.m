function roundKeys = generateRoundKeys(key)
    roundKeys = zeros(32,80);
    for i = 1:80
        roundKeys(1,i) = key(i);
    end
    for i = 1:31
        temp = zeros(1,80);
        for j = 0:79
            if(j > 60)
                x = j - 61;
            else
                x = 19 + j;
            end
            temp(j+1) = roundKeys(i,x+1);
        end
        % 4 bit cuoi qua S box
        for j = 0:79
            roundKeys(i+1,80-j) = temp(j+1);
        end
        sBoxLayer(temp,0);
        for j = 0:3
            roundKeys(i,80-j) = temp(j+1);
        end
        %phep xor 5 bit
        for j = 0:4
            temp(j+1) = roundKeys(i,20-j);
        end
        % convert so <32 sang bin
        iround = dec2bin(i,5)-'0';
        for j = 0:4
            roundKeys(i,20-j) = bitxor(iround(j+1),temp(j+1));
        end
    end
end