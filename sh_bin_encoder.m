function [encoded_seq, loc] = sh_bin_encoder(codebook_sh_bin, image)

% 1. same initial "string" stream you already create
stream      = string(image(:));              % r*c×1 string column
stream      = strtrim(stream);               % (defensive, keeps your line)

% 2. build the look-up table once
dict_length = height(codebook_sh_bin);       % number of codewords
colorValues = string(0:dict_length-1).';     % 0-based colour indices as strings

% 3. vectorised look-up: find the row index for every pixel
[~, loc]    = ismember(stream, colorValues); % loc(i) = row in codebook_sh_bin

encoded_seq = codebook_sh_bin(loc);          % r*c×1 string array
