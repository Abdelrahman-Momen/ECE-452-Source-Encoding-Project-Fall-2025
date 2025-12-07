clc; close all; clearvars;
% Read image
image = imread('pic.png');

[prob, I, H_2, counts] = imgstats(image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%               Shannon Binary Encoding               %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[codebook_sh_bin, len_avg_sh_bin, alpha] = sh_bin_dict(prob, I);
% % Create formatted table
alpha_bin = "0." + codebook_sh_bin;
Bits = codebook_sh_bin;
T = table(alpha, alpha_bin, Bits, 'VariableNames', {'alpha', 'alpha_bin', 'Bits'});
disp(T);

% Convert image color values to bits
[r, c] = size(image);
bitstream = string(image(:));
bitstream = strtrim(bitstream);
encoded_seq = strings(r*c, 1);
k = 0;
for i = 1:length(bitstream)
    for j = 1:length(prob)
        codeword = codebook_sh_bin(j);
        color_value = string(j-1);
        if bitstream(i) == color_value
            k = k + 1;
            encoded_seq(i) = join(codeword, "");
        end
    end
end
encoded_seq = encoded_seq(1:k);

% ###########################################################################
% ###########################################################################
% ############               Shannon Binary Decoding             ############
% ###########################################################################
% ###########################################################################
% 
decoded_sequence = sh_bin_decoder(codebook_sh_bin, r, c, encoded_seq);
if string(image(:)) == decoded_sequence(:)
    imshow(decoded_sequence)
else
    disp('False')
end












