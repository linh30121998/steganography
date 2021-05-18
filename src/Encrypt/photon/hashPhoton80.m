function hash = hashPhoton80(m,c)
    [~,length] = size(m);
    % convert to 2D matrix nx5
    column = ceil(length/5);
    lengthpad = column*5-length;
    if( lengthpad ) 
        padding = [1,zeros(1,lengthpad-1)];
        m = [m,padding];
        m = reshape(m,5,column)';
    end
    S = [zeros(1,5);c];
    % absorting
    for i = 1:column 
        S = [bitxor(m(i,:),S(1,:));S(2:5,:)]; % test vector
        S = permutation(S);
    end 
    % squeezing
    outputlength = 20;
    rout = 4; % 16 bit 
    column = outputlength/rout;
    z = zeros(column,rout);
    for i = 1:column
        z(i,:)= S(1,1:4);
        S = permutation(S);
    end
    hash = reshape(z',1,outputlength);
end