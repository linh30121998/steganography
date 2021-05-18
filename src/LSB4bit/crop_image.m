function crop_img = crop_image(path)
    input = imread(path);
    input = rgb2gray(input);
    [row_length, col_length] = size(input);
    threshold = 75;         % survey to find the threshold
    input_bw = input > threshold;
    bin_reshape = reshape(input_bw,[row_length*col_length,1]);
    input_dec = bi2de(bin_reshape);
    input_dec = reshape(input_dec, [row_length col_length]);
    row = sum(input_dec, 1);
    row_flip = flip(row);
    col = sum(input_dec, 2);
    col_flip = flip(col);
    minrow = 0; mincol = 0;
    maxrow = 0; maxcol = 0;
    for i = 1:length(row)
        if ((minrow ~= 0)&&(maxrow ~= 0))
            break;
        end
        if (row(i) > 0 && minrow == 0)
            minrow = i;
        end
        if (row_flip(i) > 0 && maxrow == 0)
            maxrow = length(row) - i;
        end
    end
    
    for i = 1:length(col)
        if ((mincol ~= 0)&&(maxcol ~= 0))
            break;
        end
        if (col(i) > 0 && mincol == 0)
            mincol = i;
        end
        if (col_flip(i) > 0 && maxcol == 0)
            maxcol = length(col) - i;
        end
    end
    
    crop_img = input(mincol:maxcol, minrow:maxrow);
%     imshow(crop_img)
end