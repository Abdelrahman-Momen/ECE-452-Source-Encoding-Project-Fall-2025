function [encoded_seq, loc] = encoder(codebook_sh_bin, image, symbols)

stream      = string(image(:));              % r*c×1 string column
stream      = strtrim(stream);               % (defensive, keeps your line)

% 2. build the look-up table once
colorValues = string(symbols);               % Convert the 0-255 values to strings

% 3. look-up: find the row index for every pixel
[~, loc]    = ismember(stream, colorValues); % loc(i) = 1-based row index in codebook_sh_bin

% If loc contains 0, it means a pixel value in the image was not present
% in 'symbols', indicating a major fault in imgstats.m

encoded_seq = codebook_sh_bin(loc);          % (r*c)×1 string array
end
