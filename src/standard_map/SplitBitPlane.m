function result = SplitBitPlane(pos,matrix)
% matrix: ma tran 8 bit can tach
% pos: vi tri bit can tach
% result: mang co size = size(matrix)
   [H, W] = size(matrix);
   result = zeros(H,W);
   for i = 1:H
       for j = 1:W
           result(i,j) = bitand(matrix(i,j), 2^(pos-1));
           result(i,j) = bitshift(result(i,j), -pos+1);
       end
   end
end