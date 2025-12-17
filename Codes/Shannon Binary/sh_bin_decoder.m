function decoded_sequence = sh_bin_decoder(codebook_sh_bin, r, c, encoded_seq)
   % --- your original downstream lines (unchanged) ------------------------
    bitChars   = char(join(encoded_seq, ""));   % 1×N char row
    bitstream  = bitChars - '0';                % 0/1 double row vector
    bitstream  = bitstream(:);                  % force column
    fprintf('Length of bitstream: %d characters\n\n', length(bitstream));

    L = height(codebook_sh_bin);                % number of codewords

    % -----------------------------------------------------------------------
    % FAST VECTORISED DECODER
    % -----------------------------------------------------------------------
    decoded_sequence = zeros(numel(bitstream),1);   % over-allocate
    current_buffer   = "";                          % string scalar
    k                = 0;

    % pre-build a look-up table once
    dictStrings = codebook_sh_bin.';               % 1×L string row

    for i = 1:numel(bitstream)
        current_buffer = current_buffer + char('0' + bitstream(i));   % append bit

        % vectorised search: is current_buffer in the dictionary?
        [found, idx] = ismember(current_buffer, dictStrings);

        if found                                      % match found
            k = k + 1;
            decoded_sequence(k) = idx - 1;            % zero-indexed value
            current_buffer      = "";                 % reset buffer
        end
    end

decoded_sequence = uint8(decoded_sequence(1:k));  % trim over-allocation
decoded_sequence = reshape(decoded_sequence, r, c); % back to image shape











    % Transmitted bitstream as string "bitstream"
    % prompt = 'Please enter bitstream: ';
    % bitstream = input(prompt, 's');
    % [r, c] = size(image);
    % bitstream = string(image(:));
    % bitstream = strtrim(bitstream);
##
##    function decoded_sequence  = sh_bin_decoder(codebook_sh_bin, r, c, encoded_seq)
##   % --- your original downstream lines (unchanged) ------------------------
##    bitChars   = char(join(encoded_seq, ""));   % 1×N char row
##    bitstream  = bitChars - '0';                % 0/1 double row vector
##    bitstream  = bitstream(:);                  % force column
##    fprintf('Length of bitstream: %d characters\n\n', length(bitstream));
##
##    L = height(codebook_sh_bin);                % number of codewords
##
##    % -----------------------------------------------------------------------
##    % FAST VECTORISED DECODER
##    % -----------------------------------------------------------------------
##    decoded_sequence = zeros(numel(bitstream),1);   % over-allocate
##    current_buffer   = "";                          % string scalar
##    k                = 0;
##
##    % pre-build a look-up table once
##    dictStrings = codebook_sh_bin.';               % 1×L string row
##
##    for i = 1:numel(bitstream)
##        current_buffer = current_buffer + char('0' + bitstream(i));   % append bit
##
##        % vectorised search: is current_buffer in the dictionary?
##        [found, idx] = ismember(current_buffer, dictStrings);
##
##        if found                                      % match found
##            k = k + 1;
##            decoded_sequence(k) = idx - 1;            % zero-indexed value
##            current_buffer      = "";                 % reset buffer
##        end
##    end
##
##decoded_sequence = uint8(decoded_sequence(1:k));  % trim over-allocation
##decoded_sequence = reshape(decoded_sequence, r, c); % back to image shape
##
##
##
##
##
##
##
##
##
##
##
##    % Transmitted bitstream as string "bitstream"
##    % prompt = 'Please enter bitstream: ';
##    % bitstream = input(prompt, 's');
##    % [r, c] = size(image);
##    % bitstream = string(image(:));
##    % bitstream = strtrim(bitstream);
