clc; close all; clearvars;
% Read image
prompt = 'Enter the picture file name followed by the file extension: ';
image_name = input(prompt, 's');
image = imread(image_name);
if ndims(image)==3                % colour image
    image = rgb2gray(image);      % 0-255 grayscale
end

[prob, I, H_2, counts] = imgstats(image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%               Shannon Binary Encoding               %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[codebook_sh_bin, len_avg_sh_bin, alpha] = sh_bin_dict(prob, I);
efficiency_sh_bin = H_2 / len_avg_sh_bin;
fprintf("Shannon Binary Efficiency equals %.3f \n", efficiency_sh_bin);
% % Create formatted table
alpha_bin = "0." + codebook_sh_bin;
Bits = codebook_sh_bin;
pixel_vals = (0:length(codebook_sh_bin)-1)';
T = table(pixel_vals, alpha, alpha_bin, Bits, 'VariableNames', {'values', 'alpha', 'alpha_bin', 'Bits'});
disp(T);

% Convert image color values to bits
[r, c] = size(image);
encoded_seq = sh_bin_encoder(codebook_sh_bin, image);



% ###########################################################################
% ###########################################################################
% ############               Shannon Binary Decoding             ############
% ###########################################################################
% ###########################################################################

decoded_sequence = sh_bin_decoder(codebook_sh_bin, r, c, encoded_seq);

if image(:) == decoded_sequence(:)
    disp('Reconstruction OK')
    figure;
    imshow(decoded_sequence)
else
    disp('False')
end












