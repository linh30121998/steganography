function message = Decrypt(key,em)
%AES-256 decoding using Cipher Block Chaining (CBC) mode with ciphertext
%stealing. Encrypted message length needs to be greater than 256-bits or 64 
%hexidecimal characters. Key is a 256-bit hexidecimal string (64 characters
%long). Message output is a character string (UTF-8).
    m = hex2dec(reshape(em,2,[])')';
    count = ceil(length(m)/16);
    b = length(m)-16*(count-1);
    intiationVector = [173,76,37,247,147,53,68,24,174,242,40,171,201,231,131,99];%just picked a random vector
    w = KeyExpansion(key);
    e = InvCipher(w,m(1:16));
    message(1,:) = bitxor(e,intiationVector);
    for k = 2:count-1
        e = InvCipher(w,m(16*(k-1)+1:16*k));
        message(k,:) = bitxor(e,m(16*(k-2)+1:16*(k-1)));
    end
    mm = [m(16*(count-1)+1:end),e(b+1:end)];
    ee = InvCipher(w,mm);
    message(count-1,:) = bitxor(ee,m(16*(count-3)+1:16*(count-2)));
    message(count,:) = bitxor(e,mm);
    message = message';
    message = native2unicode(message(1:length(m)),'UTF-8');
end