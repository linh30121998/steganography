function Y = GHash(X) % X is mesage 
    blockLength = 20; % 80 bit follow Photon80
    Y = zeros(1,blockLength);
    [~,XLength] = size(X);
    round = ceil(XLength/blockLength); % the number of round
    lengthpad = round*blockLength - XLength;
    if( lengthpad ) 
        padding = zeros(1,lengthpad); % padding zeros 
        X = [X,padding];
    end
    for i = 0 : round-1
        start = i*blockLength + 1;
        finish = start + blockLength - 1;
        input = X(start:finish);
        input = bitxor(input,Y);
        addpath('../../photon');
        c = [0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 1; 4 1 4 1 0];
        Y = hashPhoton80(input,c);
    end
end