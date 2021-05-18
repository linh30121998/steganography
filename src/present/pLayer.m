%pLayer
function pLayer(data)
    temp = zeros(1,64);
    for i = 0:63
        a = 16*i+1;
        while(a > 64)
            a = a - 64;
        end
        temp(a) = data(i+1);
    end
    for i = 1:64
        data(i) = temp(i);
    end
end