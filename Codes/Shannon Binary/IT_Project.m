clc; close all; clearvars;

diary off;
log_filename = 'log.txt'; % Define your file name

% Check if the file exists from a previous run, and DELETE it.
if exist(log_filename, 'file')
    delete(log_filename);
end

% Start the new log file
diary(log_filename);
diary on

%% Load Image
image = imread("landscape.png");
% for JPEG images (redundant genralization)
if ndims(image)==3                % colour image
    image = rgb2gray(image);      % 0-255 grayscale
end

[r, c] = size(image);
[prob, I, H_2, counts, symbols] = imgstats(image,r,c);

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%               Shannon Binary Encoding               %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[codebook_sh_bin, len_avg_sh_bin, alpha] = sh_bin_dict(prob, I, H_2);

encoded_seq_sh_bin = encoder(codebook_sh_bin, image, symbols); 

%% 

% ###########################################################################
% ###########################################################################
% ######                 Shannon Binary Decoding                       ######
% ###########################################################################
% ###########################################################################

decoded_seq_sh_bin = decoder(codebook_sh_bin, r, c, encoded_seq_sh_bin, symbols);

if all(image(:) == decoded_seq_sh_bin(:)) % Using all() for array comparison
    disp('Shannon Binary Reconstruction OK/NO Errors')
    figure;
    imshow(decoded_seq_sh_bin)
    title('Decoded Shannon Binary Code')
else
    disp('Shannon Binary False')
end

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%                Huffman Encoding                     %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[codebook_huff , symbols_huff] = huff_dict(symbols,prob,H_2);

encoded_seq_huff = encoder(codebook_huff,image,symbols_huff);

%% 
% ###########################################################################
% ###########################################################################
% ######                    Huffman Decoding                           ######
% ###########################################################################
% ###########################################################################


decoded_seq_huff = decoder(codebook_huff, r, c, encoded_seq_huff, symbols_huff);
mse_huff = sum(sum((decoded_seq_huff - image).^2))/(r*c+1);

if mse_huff < eps 
    disp('Huffman Reconstruction OK/NO Errors')
    figure;
    imshow(decoded_seq_huff)
    title('Decoded Huffman Code')
else
    fprintf("The Mean Square Error = %.5f\n\n",mse_huff)
end

diary off
