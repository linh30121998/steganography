function [encryption] = Encrypt(message,key)
%AES-256 encoding using Cipher Block Chaining (CBC) mode with ciphertext
%stealing. Message length needs to be greater than 32 characters. Key is a
%256-bit hexidecimal string (64 characters long). Encrypted output is in
%hexidemical form.
    m = double(unicode2native(message,'UTF-8'));
    count = ceil(length(m)/16);
    b = length(m)-16*(count-1);
    intiationVector = [173,76,37,247,147,53,68,24,174,242,40,171,201,231,131,99];%just picked a random vector
    md = bitxor(m(1:16),intiationVector);
    w = KeyExpansion(key);
    E(1,:) = Cipher(w,md);
    for k = 2:count-1
        md = bitxor(m(16*(k-1)+1:16*k),E(k-1,:));
        E(k,:) = Cipher(w,md);
    end
    ee = E(count-1,:);
    mm = zeros(1,16);
    mm(1:b) = m(16*(count-1)+1:end);
    md = bitxor(mm,ee);
    E(count-1,:) = Cipher(w,md);
    E(count,:) = ee;
    E=E';
    encryption = lower(dec2hex(E(1:length(m)))');
    encryption = encryption(:)';
end