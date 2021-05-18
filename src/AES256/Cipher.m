function Out = Cipher(w,In)
%AES-256 cipher
%Impliments FIBS-197, key is 256-bit hexidecimal input, 
% message (In) is 128-bit hexidecimal.
    state = reshape(In,4,[]);
    state = AddRoundKey(state,w(:,1:4));
    for k = 2:14
        state = SubBytes(state);
        state = ShiftRows(state);
        state = MixColumns(state);
        state = AddRoundKey(state,w(:,4*(k-1)+1:4*k));
    end
    state = SubBytes(state);
    state = ShiftRows(state);
    state = AddRoundKey(state,w(:,57:60));
    Out = state(:);
end