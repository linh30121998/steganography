function val = AES_GET_BE32(a)
    a = uint32(a);
    val = bitshift(a(1),24) + bitshift(a(2),16) + bitshift(a(3),8) + a(4);
end
