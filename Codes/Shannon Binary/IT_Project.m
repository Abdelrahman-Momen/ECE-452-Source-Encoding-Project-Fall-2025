clc; close all; clearvars;

image = imread("dog.png"); % Changed to dog.png for testing
if ndims(image)==3                % colour image
    image = rgb2gray(image);      % 0-255 grayscale
end

% CRITICAL CHANGE: Capture the new 'symbols' output
[prob, I, H_2, counts, symbols] = imgstats(image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%               Shannon Binary Encoding               %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[codebook_sh_bin, len_avg_sh_bin, alpha] = sh_bin_dict(prob, I);
efficiency_sh_bin = H_2 / len_avg_sh_bin;
fprintf("Shannon Binary Efficiency equals %.3f \n", efficiency_sh_bin);

% Convert image color values to bits
[r, c] = size(image);

% CRITICAL CHANGE: Pass the 'symbols' input to the encoder
[encoded_seq, loc] = sh_bin_encoder(codebook_sh_bin, image, symbols); 


% ###########################################################################
% ###########################################################################
% ############               Shannon Binary Decoding             ############
% ###########################################################################
% ###########################################################################

decoded_sequence = sh_bin_decoder(codebook_sh_bin, r, c, encoded_seq, symbols);

if all(image(:) == decoded_sequence(:)) % Using all() for array comparison
    disp('Reconstruction OK')
    figure;
    imshow(decoded_sequence)
else
    disp('False')
end
