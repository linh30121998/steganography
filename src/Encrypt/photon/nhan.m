function c1 = nhan(a1,S1,c1)
    temp = zeros(4,4);
    m = [0,0,1,1];
    for j = 1:4
        temp(1,j) = a1(j);
    end
    
    for i = 2:4
        for j = 1:3
            temp(i,j) = temp(i-1,j+1);
        end
        temp(i,4) = 0;
        if (temp(i-1,1) == 1)
            for j = 1:4
                temp(i,j) = bitxor(temp(i,j),m(j));
            end
        end
    end
    
    for k = 1:4
        if(S1(5-k) == 0)
            continue;
        elseif(S1(5-k) == 1)
            for j = 1:4
                c1(j) = bitxor(c1(j),temp(k,j));
            end 
        end
    end
end