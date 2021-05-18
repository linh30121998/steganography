function a = AES_PUT_BE32(val)
   a = '';
   val = uint32(val);
   for i = 1:4
       a(i) = bitand(bitshift(val,-8*(4-i)), hex2dec('ff'));
   end
end