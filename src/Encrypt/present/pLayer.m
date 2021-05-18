%pLayer
function data = pLayer(data, param)
% if player param = 16
% player_inv param = 4
    temp = zeros(1,64);
    for i = 0:63
        a = param*i;
        while(a > 63)
            a = a - 63;
        end
        temp(a+1) = data(i+1);
    end
    for i = 1:64
        data(i) = temp(i);
    end
end