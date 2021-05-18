function result = SplitBitPlane(pos,matrix)
% matrix: ma tran 8 bit can tach
% pos: vi tri bit can tach
% result: mang (1, 2^18)
   [H, W] = size(matrix);
   result = zeros(H,W);
   for i = 1:H
       for j = 1:W
           result(i,j) = bitand(matrix(i,j), 2^(pos-1));
           result(i,j) = bitshift(result(i,j), -pos+1);
       end
   end
   result = reshape(result', [1,H*W]);
   for i = 1:H*W
       if(result(i) > 1)
           disp('fail');
           disp(i);
           disp(result(i));
           break
       end
   end
end
