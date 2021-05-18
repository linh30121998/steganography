function block = inc32(block)
    AES_BLOCK_SIZE = 16;
    val = AES_GET_BE32(block(AES_BLOCK_SIZE-3:AES_BLOCK_SIZE));
    val = val + 1;
    block(AES_BLOCK_SIZE-3:AES_BLOCK_SIZE) = AES_PUT_BE32(val);
    block = char(block);
end 