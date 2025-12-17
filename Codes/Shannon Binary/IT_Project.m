clc; close all; clearvars;

image = imread("pic.png");
% for JPEG images (redundant genralization)
if ndims(image)==3                % colour image
    image = rgb2gray(image);      % 0-255 grayscale
end

[prob, I, H_2, counts, symbols] = imgstats(image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%               Shannon Binary Encoding               %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[codebook_sh_bin, len_avg_sh_bin, alpha] = sh_bin_dict(prob, I, H_2);


% Convert image color values to bits
[r, c] = size(image);

% CRITICAL CHANGE: Pass the 'symbols' input to the encoder
[encoded_seq, loc] = encoder(codebook_sh_bin, image, symbols); 


% ###########################################################################
% ###########################################################################
% ######                 Shannon Binary Decoding                       ######
% ###########################################################################
% ###########################################################################

decoded_sequence = decoder(codebook_sh_bin, r, c, encoded_seq, symbols);

if all(image(:) == decoded_sequence(:)) % Using all() for array comparison
    disp('Reconstruction OK')
    figure;
    imshow(decoded_sequence)
else
    disp('False')
end
