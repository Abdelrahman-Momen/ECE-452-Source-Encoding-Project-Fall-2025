function decoded_sequence = sh_bin_decoder(codebook_sh_bin, r, c, encoded_seq)
    % Transmitted bitstream as string "bitstream"
    % prompt = 'Please enter bitstream: ';
    % bitstream = input(prompt, 's');
    % [r, c] = size(image);
    % bitstream = string(image(:));
    % bitstream = strtrim(bitstream);
    bitstream = encoded_seq;
    bitstream = str2double(bitstream);
    % Display what was received for confirmation
    % fprintf('\nYou entered the following bitstream:\n');
    % disp(bitstream);
    fprintf('Length of bitstream: %d characters\n\n', length(bitstream));
    
    L = length(codebook_sh_bin);
    
    decoded_sequence = zeros(L, 1);
    current_buffer = "";
    
    k = 0;
    for i = 1 : length(bitstream)
        bit = bitstream(i);
        current_buffer = current_buffer + bit;
        for j = 1:L
            dict_value = codebook_sh_bin(j);
            if dict_value == current_buffer
                k = k + 1;
                decoded_sequence(k) = j;
                current_buffer = "";
            end
        end
    end
    decoded_sequence = decoded_sequence(1:k);
    decoded_sequence = join(string(decoded_sequence), " ");
    % disp({decoded_sequence, bitstream})
    decoded_sequence = resize(decoded_sequence, [r c]);
    % imshow(decoded_sequence)
