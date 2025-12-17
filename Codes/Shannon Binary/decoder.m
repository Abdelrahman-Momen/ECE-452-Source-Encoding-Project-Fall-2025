function decoded_sequence = decoder(codebook_sh_bin, r, c, encoded_seq, symbols)
   
    bitChars   = char(join(encoded_seq, ""));
    bitstream  = bitChars - '0';
    bitstream  = bitstream(:);
    fprintf('Length of bitstream: %d characters\n\n', length(bitstream));

    L = height(codebook_sh_bin);

    % -----------------------------------------------------------------------
    %                                DECODER
    % -----------------------------------------------------------------------
    decoded_sequence = zeros(numel(bitstream),1);
    current_buffer   = "";
    k                = 0;

    % pre-build a look-up table once
    dictStrings = codebook_sh_bin.';

    for i = 1:numel(bitstream)
        current_buffer = current_buffer + char('0' + bitstream(i));

        [found, idx] = ismember(current_buffer, dictStrings);

        if found
            k = k + 1;
            
            % Map the 1-based index (idx) to the 0-based
            % original pixel value using the 'symbols' array.
            % 'symbols' array is 0-based (0 to L-1), but accessed here with 1-based index (idx)
            decoded_sequence(k) = symbols(idx); % idx is 1-based, symbols is 1-based indexed
            
            current_buffer      = "";
        end
    end

decoded_sequence = uint8(decoded_sequence(1:k));
decoded_sequence = reshape(decoded_sequence, r, c);
end
